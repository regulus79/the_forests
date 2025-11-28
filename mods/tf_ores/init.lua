

tf_ores = {}

tf_ores.oredefs = {
	iron = {
		name = "Iron",
		ore_type = "scatter",
		level = 2,
		clust_scarcity = 10^3,
		composition = {iron = 1},
	},
	raga = {
		name = "Raga",
		ore_type = "blob",
		level = 3,
		biomes = {"grassland"},
		y_max = 0,
		clust_scarcity = 10^3,
		composition = {raga = 1},
	},
	coal = {
		name = "Coal",
		ore_type = "blob",
		level = 1,
		clust_scarcity = 6^3,
		composition = {coal = 1},
	}
}







for oreid, oredef in pairs(tf_ores.oredefs) do
	for i = 1,5 do
		core.register_node("tf_ores:stone" .. i .. "_with_" .. oreid, {
			description = "Stone with " .. oredef.name,
			tiles = {"tf_stone" .. i .. ".png^tf_" .. oreid .. "_ore.png"},
			drop = "tf_ores:" .. oreid,
			groups = {stone = oredef.level},
		})
		core.register_ore({
			name = oreid,
			ore_type = oredef.ore_type or "scatter",
			ore = "tf_ores:stone" .. i .. "_with_" .. oreid,
			wherein = "tf_nodes:stone" .. i,
			biomes = oredef.biomes,
			clust_scarcity = oredef.clust_scarcity,
			clust_num_ores = oredef.clust_num_ores or 8,
			clust_size = oredef.clust_size or 3,
			y_max = oredef.y_max,
		})
	end
	core.register_craftitem("tf_ores:" .. oreid, {
		description = oredef.name,
		inventory_image = "tf_" .. oreid .. "_ore.png",
		groups = {ore = 1, [oreid] = 1},
	})
end


tf_ores.get_ore_composition = function(nodename)
	local oreid = string.sub(nodename, #"tf_ores:" + 1)
	if tf_ores.oredefs[oreid] then
		return tf_ores.oredefs[oreid].composition or {}
	else
		return {}
	end
end