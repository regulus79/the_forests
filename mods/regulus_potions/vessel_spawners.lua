
local register_vessel_spawner = function(name, vessel_name, initial_state)
	core.register_node("regulus_potions:vessel_spawner_" .. name, {
		description = "Spawner for " .. vessel_name .. " of " .. name,
		drawtype = "airlike",
	})
	core.register_abm({
		label = "Spawn " .. name,
		nodenames = {"regulus_potions:vessel_spawner_" .. name},
		interval = 1,
		chance = 1,
		action = function(pos)
			core.set_node(pos, {name = "regulus_vessels:" .. vessel_name .. "_level0"}) -- Level and param2 will be updated by the node timer
			regulus_vessels.updateNode(pos, initial_state)
			-- TODO use global constant for tick length
			core.get_node_timer(pos):set(regulus_vessels.update_interval, 0)
		end
	})
end


register_vessel_spawner("affer", "barrel1", {affer = 3})
register_vessel_spawner("gra", "barrel1", {gra = 3})
register_vessel_spawner("phye", "barrel1", {phye = 3})