


local nodes_to_be_cut = {}

for nodename, def in pairs(core.registered_nodes) do
	if def.groups.generate_stairs then
		nodes_to_be_cut[nodename] = def
	end
end



local stair_types = {
	stair = {
		name = "Stair",
		craft_count = 8,
		recipe = {
			{true, false, false},
			{true, true, false},
			{true, true, true},
		},
		node_boxes = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	slab = {
		name = "Slab",
		craft_count = 6,
		recipe = {
			{false, false, false},
			{false, false, false},
			{true, true, true},
		},
		node_boxes = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
	},
	short_slab = {
		name = "Short Slab",
		craft_count = 4,
		recipe = {
			{false, false, false},
			{false, false, false},
			{true, true, false},
		},
		node_boxes = {
			{-0.5, -0.5, 0, 0.5, 0, 0.5},
		},
	},
	inner_corner_stair = {
		name = "Inner Corner Stair",
		craft_count = 10,
		recipe = {
			{true, false, true},
			{true, true, true},
			{true, true, true},
		},
		node_boxes = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0.5, 0.5, 0.5},
			{0, 0, -0.5, 0.5, 0.5, 0},
		},
	},
	outer_corner_stair = {
		name = "Outer Corner Stair",
		craft_count = 10,
		recipe = {
			{false, false, false},
			{false, true, false},
			{true, true, true},
		},
		node_boxes = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, 0, 0.5, 0.5, 0.5},
		},
	},
}



for nodename, def in pairs(nodes_to_be_cut) do
	for stairtype, stairdef in pairs(stair_types) do
		local newdef = {}
		for k,v in pairs(def) do
			newdef[k] = v
		end
		local stair_nodename = nodename .. "_" .. stairtype
		newdef.description = newdef.description .. " " .. stairdef.name
		newdef.drawtype = "nodebox"
		newdef.node_box = {
			type = "fixed",
			fixed = stairdef.node_boxes,
		}
		newdef.paramtype = "light"
		newdef.paramtype2 = "facedir"
		newdef.on_place = core.rotate_node
		newdef.groups.generate_stairs = nil

		local recipe = {}
		for rowidx, row in pairs(stairdef.recipe) do
			recipe[rowidx] = {}
			for colidx, elem in pairs(row) do
				recipe[rowidx][colidx] = (elem and nodename) or ""
			end
		end
		print(nodename, stairtype, dump(recipe))

		core.register_node(stair_nodename, newdef)
		core.register_craft({
			type = "shaped",
			output = stair_nodename .. " " .. stairdef.craft_count,
			recipe = recipe,
		})
	end
end




--
-- Screwdriver
--

core.register_craftitem("tf_nodes:screwdriver", {
	description = "Screwdriver",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		local node = core.get_node(pointed_thing.under)
		node.param2 = math.floor(node.param2 / 4) * 4 + ((node.param2 + 1) % 4)
		core.swap_node(pointed_thing.under, node)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local node = core.get_node(pointed_thing.under)
		node.param2 = (node.param2 + 4) % 24
		core.swap_node(pointed_thing.under, node)
	end,
})