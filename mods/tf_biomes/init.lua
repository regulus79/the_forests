

---
--- Grassland
---

core.register_biome({
	name = "grassland",
	node_top = "tf_nodes:dirt_with_grass1",
	depth_top = 1,
	node_filler = "tf_nodes:dirt1",
	depth_filler = 3,
	node_stone = "tf_nodes:stone1",

	node_water = "tf_nodes:water_source",

	node_riverbed = "tf_nodes:sand",
	depth_riverbed = 1,

	sky_color = "#b3e6e2",
	horizon_color = "#e7f0f0",
	fog_color = "#e7f0f0",
	fog_distance = 100,
	daylight = 1,
	nightlight = 0.4,
})

for i = 1, tf_nodes.num_boulders do
	core.register_decoration({
		deco_type = "simple",
		place_on = "tf_nodes:dirt_with_grass1",
		biomes = {"grassland"},
		fill_ratio = 0.001 / tf_nodes.num_boulders,
		decoration = "tf_nodes:stone1_boulder" .. i,
		param2 = 0,
		param2_max = 4,
	})
end







---
--- Dry Grassland
---

core.register_biome({
	name = "drygrassland",
	node_top = "tf_nodes:dirt_with_grass2",
	depth_top = 1,
	node_filler = "tf_nodes:dirt2",
	depth_filler = 3,
	node_stone = "tf_nodes:stone3",

	node_water = "tf_nodes:water_source",

	node_riverbed = "tf_nodes:sand",
	depth_riverbed = 1,

	sky_color = "#d2c681",
	horizon_color = "#f9eeae",
	fog_color = "#f9eeae",
	fog_distance = 100,
	daylight = 1,
	nightlight = 0.4,
})
for i = 1, tf_nodes.num_boulders do
	core.register_decoration({
		deco_type = "simple",
		place_on = "tf_nodes:dirt_with_grass2",
		biomes = {"drygrassland"},
		fill_ratio = 0.001 / tf_nodes.num_boulders,
		decoration = "tf_nodes:stone3_boulder" .. i,
		param2 = 0,
		param2_max = 4,
	})
end





---
--- Firefly Forest
---

core.register_biome({
	name = "fireflyforest",
	node_top = "tf_nodes:dirt_with_grass3",
	depth_top = 1,
	node_filler = "tf_nodes:dirt3",
	depth_filler = 3,
	node_stone = "tf_nodes:stone2",

	node_water = "tf_nodes:water_source",

	node_riverbed = "tf_nodes:sand",
	depth_riverbed = 1,

	sky_color = "#817036",
	horizon_color = "#322f1f",
	fog_color = "#322f1f",
	fog_distance = 40,
	daylight = 0.8,
	nightlight = 0.4,
})
for i = 1, tf_nodes.num_boulders do
	core.register_decoration({
		deco_type = "simple",
		place_on = "tf_nodes:dirt_with_grass3",
		biomes = {"fireflyforest"},
		fill_ratio = 0.001 / tf_nodes.num_boulders,
		decoration = "tf_nodes:stone2_boulder" .. i,
		param2 = 0,
		param2_max = 4,
	})
end






---
--- Backyard Forest
---

core.register_biome({
	name = "backyardforest",
	node_top = "tf_nodes:dirt_with_grass4",
	depth_top = 1,
	node_filler = "tf_nodes:dirt1",
	depth_filler = 3,
	node_stone = "tf_nodes:stone4",

	node_water = "tf_nodes:water_source",

	node_riverbed = "tf_nodes:sand",
	depth_riverbed = 1,

	sky_color = "#b3e6e2",
	horizon_color = "#e7f0f0",
	fog_color = "#e7f0f0",
	fog_distance = 100,
	daylight = 1,
	nightlight = 0.4,
})
for i = 1, tf_nodes.num_boulders do
	core.register_decoration({
		deco_type = "simple",
		place_on = "tf_nodes:dirt_with_grass4",
		biomes = {"backyardforest"},
		fill_ratio = 0.001 / tf_nodes.num_boulders,
		decoration = "tf_nodes:stone4_boulder" .. i,
		param2 = 0,
		param2_max = 4,
	})
end

core.register_ore({
	name = "livingstone",
	ore_type = "scatter",
	ore = "tf_nodes:livingstone",
	wherein = "tf_nodes:stone4",
	biomes = {"backyardforest"},
	clust_scarcity = 3*3*3,
	clust_num_ores = 8,
	clust_size = 3,
})







---
--- Red Forest
---

core.register_biome({
	name = "redforest",
	node_top = "tf_nodes:dirt_with_grass5",
	depth_top = 1,
	node_filler = "tf_nodes:dirt1",
	depth_filler = 3,
	node_stone = "tf_nodes:stone5",

	node_water = "tf_nodes:water_source",

	node_riverbed = "tf_nodes:sand",
	depth_riverbed = 1,

	sky_color = "#b3e6e2",
	horizon_color = "#441f24",
	fog_color = "#441f24",
	fog_distance = 100,
	daylight = 1,
	nightlight = 0.6,
})
for i = 1, tf_nodes.num_boulders do
	core.register_decoration({
		deco_type = "simple",
		place_on = "tf_nodes:dirt_with_grass5",
		biomes = {"redforest"},
		fill_ratio = 0.001 / tf_nodes.num_boulders,
		decoration = "tf_nodes:stone5_boulder" .. i,
		param2 = 0,
		param2_max = 4,
	})
end