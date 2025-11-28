

tf_potions = {}


tf_potions.potion_effects = {
	sickness = {
		name = "Sickness",
		update = function(player, intensity, dtime)
			if intensity > 0 then
				local probPerSec = math.exp(-1 / intensity)
				if math.random() < 1 - (1 - probPerSec) ^ dtime then
					player:set_hp(player:get_hp() - 1)
				end
			end
		end
	},
	fear = {
		name = "Fear",
		update = function(player, intensity, dtime)
			if intensity > 0.3 then
				tf_hud.set_caption(player, "fear", core.colorize("#220000", "FEAR"))
			else
				tf_hud.set_caption(player, "fear", "")
			end
		end,
	},
	speed = {
		name = "Speed",
		update = function(player, intensity, dtime)
			local physics_override = player:get_physics_override()
			physics_override.speed_walk = 1 + intensity
			player:set_physics_override(physics_override)
		end
	},
	jump = {
		name = "Jump",
		update = function(player, intensity, dtime)
			local physics_override = player:get_physics_override()
			physics_override.jump = 1 + intensity
			player:set_physics_override(physics_override)
		end
	},
	agility = {
		name = "Agility",
		update = function(player, intensity, dtime)
			local physics_override = player:get_physics_override()
			physics_override.acceleration_default = 1 + intensity
			player:set_physics_override(physics_override)
		end
	},
}


-- Some compounds have special effects
-- potions must correspond to defined compounds
tf_potions.potions = {
	--
	-- Misc
	--
	fear_hormone = {
		halflife = 15,
		effects = {sickness = 1, fear = 1},
	},
	--
	-- Plants
	--
	ichra = {
		halflife = 15,
		effects = {sickness = 1}
	},
	staeg = {
		halflife = 15,
		effects = {sickness = 0.1}
	},
	feyrf = {
		halflife = 15,
		effects = {speed = 1, sickness = 0.1}
	},
	bramrua = {
		halflife = 15,
		effects = {sickness = 0.1}
	},
	harnoua = {
		halflife = 15,
		effects = {sickness = 0.1}
	},
	raml = {
		halflife = 15,
		effects = {sickness = 0.1}
	},
	ytle = {
		halflife = 15,
		effects = {sickness = 0.1}
	},
	thrag = {
		halflife = 15,
		effects = {sickness = 0.1}
	},
	rheer = {
		halflife = 15,
		effects = {agility = 1, sickness = 0.1}
	},
	vurg = {
		halflife = 15,
		effects = {sickness = 0.1}
	},
	reghaou = {
		halflife = 15,
		effects = {jump = 1, sickness = 0.1}
	},
	gregoara = {
		halflife = 15,
		effects = {sickness = 0.1}
	},
	rhe = {
		halflife = 15,
		effects = {sickness = 0.1}
	},
	affer = {
		halflife = 15,
		effects = {sickness = 0.1, speed = 0.2}
	},
	gra = {
		halflife = 15,
		effects = {sickness = 0.1, jump = 0.2}
	},
	phye = {
		halflife = 15,
		effects = {sickness = 0.1, agility = 0.2}
	},
	--
	-- Ores
	--
	raga = {
		halflife = 15,
		effects = {sickness = 0.1, speed = 1}
	},
}





tf_potions.drink_solution = function(player, solution_state)
	local potion_levels = core.deserialize(player:get_meta():get_string("potion_levels"))
	for compound, amount in pairs(solution_state) do
		if tf_potions.potions[compound] then
			potion_levels[compound] = (potion_levels[compound] or 0) + amount
		end
	end
	player:get_meta():set_string("potion_levels", core.serialize(potion_levels))
end




core.register_on_joinplayer(function(player)
	tf_hud.add_hud_element(player, "potions_vignette", {
		type = "image",
		position = {x = 0.5, y = 0.5},
		scale = {x = -100, y = -101},
		text = "tf_vignette.png^[opacity:0",
		z_index = -400,
	})
	tf_hud.add_hud_element(player, "potions_levels", {
		type = "text",
		number = 0xFFFFFF,
		position = {x = 0, y = 1},
		scale = {x = 100, y = 100},
		alignment = {x = 1, y = -1},
		offset = {x = 10, y = -10},
		size = {x = 1},
		style = 0*1 + 0*2 + 0*4,
	})
	tf_hud.add_hud_element(player, "potions_effects", {
		type = "text",
		number = 0xFFFFFF,
		position = {x = 1, y = 1},
		scale = {x = 100, y = 100},
		alignment = {x = -1, y = -1},
		offset = {x = -10, y = -10},
		size = {x = 1},
		style = 0*1 + 0*2 + 0*4,
	})
end)


local update_timer = 0
local update_interval = 1
core.register_globalstep(function(dtime)
	update_timer = update_timer + dtime
	if update_timer > update_interval then
		update_timer = 0
		for _, player in pairs(core.get_connected_players()) do
			-- Get the amount of potions in their bloodstream
			local potion_levels = core.deserialize(player:get_meta():get_string("potion_levels")) or {}
			local total_effects = {}
			local total_amount = 0
			for potion, level in pairs(potion_levels) do
				total_amount = total_amount + level
				-- Tally up potion effects
				for effect, multiplier in pairs(tf_potions.potions[potion].effects) do
					total_effects[effect] = (total_effects[effect] or 0) + multiplier * potion_levels[potion]
				end
				-- Update levels based on potion half-lives
				potion_levels[potion] = potion_levels[potion] * (0.5) ^ (update_interval / tf_potions.potions[potion].halflife)
			end
			player:get_meta():set_string("potion_levels", core.serialize(potion_levels))
			-- Apply potion effects
			for effect, intensity in pairs(total_effects) do
				tf_potions.potion_effects[effect].update(player, intensity, update_interval)
			end
			-- Update vignette
			local alpha = math.floor(math.min(255, 255 * total_amount))
			local colorVec = tf_vessels.get_solution_color(potion_levels) or vector.new(0,0,0) -- If empty, it will return nil, so default to black (but the alpha is 0, so it will not be visible)
			local colorString = core.rgba(colorVec.x, colorVec.y, colorVec.z, alpha)
			tf_hud.change_hud_element(player, "potions_vignette", "text", "tf_vignette.png^[multiply:" .. colorString .. "^[opacity:" .. alpha)
			-- Update HUD stats
			-- Potion levels
			local hud_potion_levels_text = {"Potion Levels"}
			for _, potion in pairs(tf_vessels.get_sorted_components(potion_levels)) do
				local level = potion_levels[potion]
				if level > 0.01 then
					local compoundName = tf_compounds.compounds[potion].name
					local compoundColor = tf_vessels.colorStringFromVector(tf_compounds.compounds[potion].color)
					table.insert(hud_potion_levels_text, string.format("%.2f %s %s",
						level,
						core.colorize(compoundColor, string.rep("#", math.ceil(level * 10))),
						core.colorize(compoundColor, compoundName)
					))
				end
			end
			tf_hud.change_hud_element(player, "potions_levels", "text", table.concat(hud_potion_levels_text, "\n"))
			-- Effect levels
			local hud_effect_levels_text = {"Effect Levels"}
			for _, effect in pairs(tf_vessels.get_sorted_components(total_effects)) do
				local level = total_effects[effect]
				if level > 0.01 then
					table.insert(hud_effect_levels_text, string.format("%s %s %.2f",
						tf_potions.potion_effects[effect].name,
						string.rep("#", math.ceil(level * 10)),
						level
					))
				end
			end
			tf_hud.change_hud_element(player, "potions_effects", "text", table.concat(hud_effect_levels_text, "\n"))
		end
	end
end)



core.register_chatcommand("levels", {
	description = "potion levels in bloodstream debug only pls",
	func = function(name, param)
		player = core.get_player_by_name(name)
		local potion_levels = core.deserialize(player:get_meta():get_string("potion_levels"))
		core.debug(dump(potion_levels))
	end,
})




dofile(core.get_modpath("tf_potions") .. "/vessel_spawners.lua")