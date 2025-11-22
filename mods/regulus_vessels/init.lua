

regulus_vessels = {}


regulus_vessels.max_fullness_level = 10


regulus_vessels.vessels = {}


local get_vessel_name = function(nodename)
	local base_nodename, fullness_level = unpack(string.split(nodename, "_level_"))
	local _, vessel_name = unpack(string.split(base_nodename, ":"))
	return vessel_name
end


local get_state = function(meta)
	return core.deserialize(meta:get_string("state")) or {}
end

local total_amount_in_state = function(state)
	local total = 0
	for compound, amount in pairs(state) do
		total = total + amount
	end
	return total
end

local get_vessel_capacity = function(nodename)
	return regulus_vessels.vessels[get_vessel_name(nodename)].capacity
end

---
---
---

regulus_vessels.get_solution_color = function(state)
	local total_color = vector.new(0,0,0)
	local total_amount = 0
	-- Also keep track of the average "brightness" of the solution so that the color vec can be scaled to the right length at the end
	local total_brightness = 0
	for compound, amount in pairs(state) do
		total_color = total_color + regulus_compounds.compounds[compound].color * amount
		total_brightness = total_brightness + regulus_compounds.compounds[compound].color:length() * amount
		total_amount = total_amount + amount
	end
	if total_amount == 0 then
		return nil
	end
	average_color = total_color / total_amount
	-- Normalize and rescale to proper brightness/length to fix darkening when mixing orthogonal colors
	normalized_average_color = average_color:normalize() * (total_brightness / total_amount)
	return normalized_average_color
end

-- Used for getting the palette pixel index for the solution color
local get_param2_from_color_vec = function(vec)
	local red = math.floor(6 * vec.x / 256)
	local green = math.floor(6 * vec.y / 256)
	local blue = math.floor(6 * vec.z / 256)
	local index = red * 6 * 6 + green * 6 + blue
	return index
end

local colorStringFromVector = function(vec)
	return core.rgba(vec.x, vec.y, vec.z)
end


local descriptionFromSolutionContents = function(solution_state)
	local description = {}
	for compound, amount in pairs(solution_state) do
		local compoundName = regulus_compounds.compounds[compound].name
		local compoundColor = colorStringFromVector(regulus_compounds.compounds[compound].color)
		local lesserCompoundColor = colorStringFromVector((regulus_compounds.compounds[compound].color + vector.new(255,255,255)) / 2)
		table.insert(description, string.format("%.1f %s %s",
			amount,
			core.colorize(compoundColor, string.rep("#", math.ceil(amount))),
			core.colorize(lesserCompoundColor, compoundName)
		))
	end
	if #description == 0 then
		return "(Empty)"
	else
		return table.concat(description, "\n")
	end
end


---
---
---

local updateDescriptionAndInfotext = function(meta)
	local state = core.deserialize(meta:get_string("state")) or {}
	local state_description = descriptionFromSolutionContents(state)
	local vessel_description = core.registered_nodes
	-- TODO see if you can add the original vessel name/description
	meta:set_string("description", "" .. state_description)
	meta:set_string("infotext", "" .. state_description)
end

local updateState = function(meta, state)
	meta:set_string("state", core.serialize(state))
	updateDescriptionAndInfotext(meta)
end

local updateNode = function(pos, state)
	updateState(core.get_meta(pos), state)
	local ratio_full = total_amount_in_state(state) / get_vessel_capacity(core.get_node(pos).name)
	local vessel_name = get_vessel_name(core.get_node(pos).name)
	local new_level = math.round(ratio_full * regulus_vessels.max_fullness_level)
	-- Show color of solution via param2 palette color
	local colorIndex = 0
	if new_level > 0 then
		colorIndex = get_param2_from_color_vec(regulus_vessels.get_solution_color(state))
	end
	core.swap_node(pos, {name = "regulus_vessels:" .. vessel_name .. "_level_" .. tostring(new_level), param2 = colorIndex})
end

local updateItemStack = function(itemstack, state)
	updateState(itemstack:get_meta(), state)
	local ratio_full = total_amount_in_state(state) / get_vessel_capacity(itemstack:get_name())
	local vessel_name = get_vessel_name(itemstack:get_name())
	local new_level = math.round(ratio_full * regulus_vessels.max_fullness_level)
	itemstack:set_name("regulus_vessels:" .. vessel_name .. "_level_" .. tostring(new_level))
end




---
--- Callbacks
---


local on_rightclick_vessel = function(pos, node, clicker, itemstack)
	local meta = core.get_meta(pos)
	local state = get_state(meta)
	local max_capacity = get_vessel_capacity(node.name)
	local current_total_amount = total_amount_in_state(state)
	-- Find the max amount which can be added
	local max_transfer = math.max(0, max_capacity - current_total_amount)
	--
	-- If it's another vessel, pour it in
	--
	if core.get_node_group(itemstack:get_name(), "vessel") ~= 0 then
		local otherstate = get_state(itemstack:get_meta()) or {}
		local total_amount_in_other = total_amount_in_state(get_state(itemstack:get_meta()))
		local transfer_amount = math.min(max_transfer, total_amount_in_other)
		local transfer_ratio = transfer_amount / total_amount_in_other
		for compound, amount in pairs(otherstate) do
			state[compound] = (state[compound] or 0) + amount * transfer_ratio
			if transfer_ratio == 1 then
				-- If transferring completely, reset the contents (so they don't read as 0)
				otherstate[compound] = nil
			else
				otherstate[compound] = amount * (1 - transfer_ratio)
			end
		end
		updateNode(pos, state)
		updateItemStack(itemstack, otherstate)
		return itemstack
	end
	--
	-- If it's a plant/compound, then add its composition
	--
	if core.get_node_group(itemstack:get_name(), "plant") ~= 0 then
		local plant_composition = regulus_plants.get_plant_composition(itemstack:get_name())
		local total_in_plant_composition = total_amount_in_state(plant_composition)
		local transfer_amount = math.min(max_transfer, total_in_plant_composition)
		local transfer_ratio = transfer_amount / total_in_plant_composition
		if transfer_ratio > 0 then
			for compound, amount in pairs(plant_composition) do
				state[compound] = (state[compound] or 0) + transfer_ratio * amount
				-- Don't care about what left over isn't added. Idk
			end
			updateNode(pos, state)
			itemstack:take_item()
			return itemstack
		else
			-- If it's full, don't add anything, return the original item
			return itemstack
		end
	end
end

local after_pick_up_vessel = function(pos, oldnode, oldmeta, drops)
	-- Copy contents of the solution
	drops[1]:get_meta():set_string("state", oldmeta["state"])
	-- Update the description based on saved description, which is also updated at hte same time as infotext
	drops[1]:get_meta():set_string("description", oldmeta["description"])
end

local on_use_vessel = function(itemstack, user)
	-- Drink contents
	regulus_potions.drink_solution(user, core.deserialize(itemstack:get_meta():get_string("state")) or {})
	-- Empty contents
	updateItemStack(itemstack, {})
	return itemstack
end


local on_place_vessel = function(itemstack, placer, pointed_thing)
	-- Save solution state of itemstack
	local itemstack_state = core.deserialize(itemstack:get_meta():get_string("state")) or {}
	new_itemstack, pos = core.item_place(itemstack, placer, pointed_thing)
	if pos == nil then -- If nothing was placed, don't update any meta or anything
		return new_itemstack
	end
	-- Apply the state to the new node
	updateNode(pos, itemstack_state)
	return new_itemstack
end

local on_construct_vessel = function(pos)
	local meta = core.get_meta(pos)
	updateDescriptionAndInfotext(meta)
	-- TODO use global constant for tick length
	core.get_node_timer(pos):set(1, 0)
end


local on_timer_step_vessel = function(pos, elapsed, node, timeout)
	local meta = core.get_meta(pos)
	local state = core.deserialize(meta:get_string("state")) or {}
	-- Update state based on chem sim
	-- TODO
	updateNode(pos, state)
	return true
end






regulus_vessels.register_vessel = function(name, def)
	regulus_vessels.vessels[name] = def
	for level = 0, regulus_vessels.max_fullness_level do
		core.register_node("regulus_vessels:" .. name .. "_level_" .. tostring(level), {
			description = def.description or "Flask",
			stack_max = 1,
			drawtype = "nodebox",
			node_box = def.node_boxes[level],
			paramtype = "light",
			groups = {dig_immediate = 3, vessel = 1},
			tiles = (level > 0) and {"regulus_vessels_liquid.png"} or {def.texture},
			paramtype2 = (level > 0) and "color" or nil,
			palette = (level > 0) and "regulus_vessels_palette.png" or nil,
			overlay_tiles = (level > 0) and {
				{name = def.rim_texture, color = "white"},
				{name = def.texture, color = "white"},
				{name = def.texture, color = "white"},
				{name = def.texture, color = "white"},
				{name = def.texture, color = "white"},
				{name = def.texture, color = "white"},
			} or nil,

			on_rightclick = on_rightclick_vessel,
			preserve_metadata = after_pick_up_vessel,
			on_use = on_use_vessel,
			on_place = on_place_vessel,
			on_construct = on_construct_vessel,
			on_timer = on_timer_step_vessel,
		})
	end
end




dofile(core.get_modpath("regulus_vessels") .. "/vessels.lua")