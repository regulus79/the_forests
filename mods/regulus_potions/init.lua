

regulus_potions = {}


regulus_potions.potion_effects = {
	speed = {
		update = function(player, intensity)
			local physics_override = player:get_physics_override()
			physics_override.speed_walk = 1 + intensity
			player:set_physics_override(physics_override)
		end
	},
}


-- Some compounds have special effects
-- potions must correspond to defined compounds
regulus_potions.potions = {
	feyrf = {
		halflife = 15,
		effects = {speed = 1}
	},
	potion2 = {
		halflife = 5,
		effects = {speed = 1}
	},
	potion3 = {
		halflife = 5,
		effects = {speed = 1}
	},
}





regulus_potions.drink_solution = function(player, solution_state)
	local potion_levels = core.deserialize(player:get_meta():get_string("potion_levels"))
	core.debug("Drink!", dump(potion_levels))
	core.debug(dump(potion_levels), dump(solution_state))
	for compound, amount in pairs(solution_state) do
		if regulus_potions.potions[compound] then
			potion_levels[compound] = (potion_levels[compound] or 0) + amount
		end
	end
	player:get_meta():set_string("potion_levels", core.serialize(potion_levels))
end




core.register_on_joinplayer(function(player)
	regulus_hud.add_hud_element(player, "potions_vignette", {
		type = "image",
		position = {x = 0.5, y = 0.5},
		scale = {x = -100, y = -100},
		text = "regulus_vignette.png^[opacity:0",
		z_index = -400,
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
				for effect, multiplier in pairs(regulus_potions.potions[potion].effects) do
					total_effects[effect] = (total_effects[effect] or 0) + multiplier * potion_levels[potion]
				end
				-- Update levels based on potion half-lives
				potion_levels[potion] = potion_levels[potion] * (0.5) ^ (dtime / regulus_potions.potions[potion].halflife)
			end
			player:get_meta():set_string("potion_levels", core.serialize(potion_levels))
			-- Apply potion effects
			for effect, intensity in pairs(total_effects) do
				regulus_potions.potion_effects[effect].update(player, intensity)
			end
			-- Update vignette
			local alpha = math.floor(math.min(255, 255 * total_amount / 10))
			local colorVec = regulus_containers.get_solution_color(potion_levels) or vector.new(0,0,0) -- If empty, it will return nil, so default to black (but the alpha is 0, so it will not be visible)
			local colorString = core.rgba(colorVec.x, colorVec.y, colorVec.z, alpha)
			regulus_hud.change_hud_element(player, "potions_vignette", "text", "regulus_vignette.png^[multiply:" .. colorString .. "^[opacity:" .. alpha)
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


