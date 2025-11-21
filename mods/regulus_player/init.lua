
local map_parameters = dofile(minetest.get_modpath("rpgmapgen_settings") .. "/map_parameters.lua")




core.override_item("", {
	wield_image = "regulus_hand.png",
	wield_scale = vector.new(1,1,2),
	tool_capabilities = {
		groupcaps = {
			plant = {times = {1,2,3}, maxlevel = 3},
			dirt = {times = {2,3,4}, maxlevel = 3},
			wood = {times = {4,5,6}, maxlevel = 3},
		}
	}
})



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
	core.debug(old_light + 0.2 * (light - old_light))
	player:override_day_night_ratio(old_light + 0.2 * (light - old_light))
end




core.register_on_joinplayer(function(player)
	update_biome_sky(player)
end)

--Spawnpos
core.register_on_newplayer(function(player)
	player:set_pos(vector.new(0, 30.5, 0))
end)



local update_timer = 0
local update_interval = 2
core.register_globalstep(function(dtime)
	update_timer = update_timer + dtime
	if update_timer > update_interval then
		update_timer = 0
		for _, player in pairs(core.get_connected_players()) do
			update_biome_sky(player)
		end
	end
end)