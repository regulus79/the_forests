
regulus_plants = {}

dofile(core.get_modpath("regulus_plants") .. "/trees.lua")

regulus_plants.plantdefs = {
	grass1 = {
		name = "Grass",
		type = "simple",
		biomes = {"grassland"},
		place_on = "regulus_nodes:dirt_with_grass1",
		fill_ratio = 0.1,
	},
	grass2 = {
		name = "Dry Grass",
		type = "simple",
		biomes = {"drygrassland"},
		place_on = "regulus_nodes:dirt_with_grass2",
		fill_ratio = 0.1,
	},
	grass3 = {
		name = "Feyrf Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "regulus_nodes:dirt_with_grass3",
		fill_ratio = 0.05,
		light_source = 5,
	},
	grass4 = {
		name = "Feyrf Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "regulus_nodes:dirt_with_grass3",
		fill_ratio = 0.02,
		light_source = 5,
	},
	grass5 = {
		name = "Tall Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "regulus_nodes:dirt_with_grass3",
		fill_ratio = 0.02,
		scale = 2,
		toughness = 2,
	},
	grass6 = {
		name = "Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "regulus_nodes:dirt_with_grass3",
		fill_ratio = 0.1,
	},
	grass7 = {
		name = "Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "regulus_nodes:dirt_with_grass3",
		fill_ratio = 0.2,
	},
	grass8 = {
		name = "Tall Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "regulus_nodes:dirt_with_grass3",
		fill_ratio = 0.08,
		scale = 2,
		toughness = 2,
	},
	grass9 = {
		name = "Tall Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "regulus_nodes:dirt_with_grass3",
		fill_ratio = 0.3,
		scale = 2,
		toughness = 2,
	},
	grass10 = {
		name = "Grass",
		type = "simple",
		biomes = {"backyardforest"},
		place_on = "regulus_nodes:dirt_with_grass4",
		fill_ratio = 0.3,
	},
	grass11 = {
		name = "Grass",
		type = "simple",
		biomes = {"backyardforest"},
		place_on = "regulus_nodes:dirt_with_grass4",
		fill_ratio = 0.2,
	},
	grass12 = {
		name = "Reghaou Grass",
		type = "simple",
		biomes = {"redforest"},
		place_on = "regulus_nodes:dirt_with_grass5",
		fill_ratio = 0.1,
	},
	grass13 = {
		name = "Gregoara Grass",
		type = "simple",
		biomes = {"redforest"},
		place_on = "regulus_nodes:dirt_with_grass5",
		fill_ratio = 0.01,
	},
	grass14 = {
		name = "Rhe Grass",
		type = "simple",
		biomes = {"redforest"},
		place_on = "regulus_nodes:dirt_with_grass5",
		fill_ratio = 0.01,
		scale = 2,
		toughness = 2,
	},
	grass15 = {
		name = "Grass",
		type = "simple",
		biomes = {"redforest"},
		place_on = "regulus_nodes:dirt_with_grass5",
		fill_ratio = 0.4,
	},
}




math.randomseed(0)
for plantid, plantdef in pairs(regulus_plants.plantdefs) do
	core.register_node("regulus_plants:plant_" .. plantid,{
		description = plantdef.name,
		tiles = {"regulus_plant_" .. plantid .. ".png"},
		inventory_image = "regulus_plant_" .. plantid .. ".png",
		drawtype = "plantlike",
		paramtype = "light",
		paramtype2 = "meshoptions",
		walkable = false,
		buildable_to = true,
		visual_scale = plantdef.scale or 1,
		light_source = plantdef.light_source or 0,
		selection_box = {
			type = "fixed",
			fixed = {-0.25*(plantdef.scale or 1), -0.5, -0.25*(plantdef.scale or 1), 0.25*(plantdef.scale or 1), -0.5 + 0.5*(plantdef.scale or 1), 0.25*(plantdef.scale or 1)}
		},
		groups = {plant = plantdef.toughness or 1}
	})
	for _, biome in pairs(plantdef.biomes) do
		for _, flagbase in pairs({8 + 32, 8 + 16 + 32}) do
			core.register_decoration({
				deco_type = "simple",
				place_on = plantdef.place_on,
				biomes = plantdef.biomes,
				fill_ratio = plantdef.fill_ratio,
				decoration = "regulus_plants:plant_" .. plantid,
				param2 = flagbase + 0,
				param2_max = flagbase + 4,
				noise_params = plantdef.use_noise and {
					offset = 0,
					scale = 0.45,
					spread = vector.new(plantdef.noise_spread, plantdef.noise_spread, plantdef.noise_spread),
					seed = math.random(100000),
					octaves = 3,
					persistance = 0.7,
					lacunarity = 2.0,
					flags = "absolute",
				}
			})
		end
	end
end
math.randomseed()