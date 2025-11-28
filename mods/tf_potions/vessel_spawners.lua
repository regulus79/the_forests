
local register_vessel_spawner = function(name, vessel_name, initial_state)
	core.register_node("tf_potions:vessel_spawner_" .. vessel_name.. "_" .. name, {
		description = "Spawner for " .. vessel_name .. " of " .. name,
		drawtype = "airlike",
	})
	if not core.is_creative_enabled() then
		core.register_abm({
			label = "Spawn " .. name,
			nodenames = {"tf_potions:vessel_spawner_" .. vessel_name.. "_" .. name},
			interval = 1,
			chance = 1,
			action = function(pos)
				core.set_node(pos, {name = "tf_vessels:" .. vessel_name .. "_level0"}) -- Level and param2 will be updated by the node timer
				tf_vessels.updateNode(pos, initial_state)
				core.get_node_timer(pos):set(tf_vessels.update_interval, 0)
			end
		})
	end
end


register_vessel_spawner("affer", "barrel1", {affer = 3})
register_vessel_spawner("gra", "barrel1", {gra = 3})
register_vessel_spawner("phye", "barrel1", {phye = 3})

register_vessel_spawner("empty", "barrel1", {})
register_vessel_spawner("empty", "barrel2", {})
register_vessel_spawner("empty", "barrel3", {})