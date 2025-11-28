
local map_parameters = dofile(minetest.get_modpath("rpgmapgen_settings") .. "/map_parameters.lua")




if not core.is_creative_enabled() then
	core.override_item("", {
		wield_image = "tf_hand.png",
		wield_scale = vector.new(1,1,2),
		tool_capabilities = {
			groupcaps = {
				plant = {times = {1,2,3}, maxlevel = 3},
				dirt = {times = {2,3,4}, maxlevel = 3},
				tree = {times = {6,7,8}, maxlevel = 3},
				wood = {times = {3,4,5}, maxlevel = 3},
				glass = {times = {2,3,4}, maxlevel = 3},
			}
		}
	})
else
	core.override_item("", {
		wield_image = "tf_hand.png",
		wield_scale = vector.new(1,1,2),
		tool_capabilities = {
			groupcaps = {
				plant = {times = {0.85}, maxlevel = 3},
				dirt = {times = {0.85}, maxlevel = 3},
				tree = {times = {0.85}, maxlevel = 3},
				wood = {times = {0.85}, maxlevel = 3},
				stone = {times = {0.85}, maxlevel = 3},
				glass = {times = {0.85}, maxlevel = 3},
			}
		}
	})
end



local update_biome_sky = function(player)
	local biomedef = core.registered_biomes[core.get_biome_name(map_parameters.get_biome_data(player:get_pos()).biome)]
	player:set_sky({
		type = "regular",
		clouds = true,
		sky_color = {
			day_sky = biomedef.sky_color,
			day_horizon = biomedef.horizon_color,
			dawn_sky = "#b0b0f0",
			dawn_horizon = "#b0c0f0",
			night_sky = "#0060f0",
			night_horizon = "4090f0",
			indoors = "#646464",
			fog_sun_tint = "#f07010",
			fog_moon_tint = "#7090c0",
			fog_tint_type = "default",
		},
		fog = {
			fog_distance = biomedef.fog_distance,
			fog_color = biomedef.fog_color
		}
	})
	-- Lerp based on time of day
	local light = biomedef.nightlight + (core.time_to_day_night_ratio(core.get_timeofday())) * (biomedef.daylight - biomedef.nightlight)
	-- and lerp from old to new
	local old_light = player:get_day_night_ratio() or light
	player:override_day_night_ratio(old_light + 0.2 * (light - old_light))
end




core.register_on_joinplayer(function(player)
	update_biome_sky(player)
end)

--Spawnpos
core.register_on_newplayer(function(player)
	player:set_pos(vector.new(0, 30.5, 0))
	player:set_look_horizontal(math.pi)
end)
core.register_on_respawnplayer(function(player)
	player:set_pos(vector.new(0, 30.5, 0))
	player:set_look_horizontal(math.pi)
	-- Reset potion levels
	player:get_meta():set_string("potion_levels", "")
	return true
end)

-- On death, drop inv contents
core.register_on_dieplayer(function(player)
	for listname, list in pairs(player:get_inventory():get_lists()) do
		for _, item in pairs(list) do
			core.item_drop(item, nil, player:get_pos())
		end
		player:get_inventory():set_list(listname, {})
	end
end)




local update_timer_sky = 0
local update_interval_sky = 2
local update_timer_health = 0
local update_interval_health = 10
core.register_globalstep(function(dtime)
	update_timer_sky = update_timer_sky + dtime
	if update_timer_sky > update_interval_sky then
		update_timer_sky = 0
		for _, player in pairs(core.get_connected_players()) do
			update_biome_sky(player)
		end
	end

	update_timer_health = update_timer_health + dtime
	if update_timer_health > update_interval_health then
		update_timer_health = 0
		for _, player in pairs(core.get_connected_players()) do
			player:set_hp(player:get_hp() + 1, "set_hp")
		end
	end
end)