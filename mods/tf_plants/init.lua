
tf_plants = {}

dofile(core.get_modpath("tf_plants") .. "/trees.lua")

tf_plants.plantdefs = {
	grass1 = {
		name = "Grass",
		type = "simple",
		biomes = {"grassland"},
		place_on = "tf_nodes:dirt_with_grass1",
		fill_ratio = 0.1,
		composition = {ichra = 1},
	},
	grass2 = {
		name = "Dry Grass",
		type = "simple",
		biomes = {"drygrassland"},
		place_on = "tf_nodes:dirt_with_grass2",
		fill_ratio = 0.1,
		composition = {staeg = 1},
	},
	grass3 = {
		name = "Feyrf Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "tf_nodes:dirt_with_grass3",
		fill_ratio = 0.05,
		light_source = 5,
		composition = {feyrf = 1},
	},
	grass4 = {
		name = "Feyrf Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "tf_nodes:dirt_with_grass3",
		fill_ratio = 0.02,
		light_source = 5,
		composition = {feyrf = 1},
	},
	grass5 = {
		name = "Tall Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "tf_nodes:dirt_with_grass3",
		fill_ratio = 0.02,
		scale = 2,
		toughness = 2,
		composition = {bramrua = 1},
	},
	grass6 = {
		name = "Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "tf_nodes:dirt_with_grass3",
		fill_ratio = 0.1,
		composition = {harnoua = 1},
	},
	grass7 = {
		name = "Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "tf_nodes:dirt_with_grass3",
		fill_ratio = 0.2,
		composition = {raml = 1},
	},
	grass8 = {
		name = "Tall Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "tf_nodes:dirt_with_grass3",
		fill_ratio = 0.08,
		scale = 2,
		toughness = 2,
		composition = {ytle = 1},
	},
	grass9 = {
		name = "Tall Grass",
		type = "simple",
		biomes = {"fireflyforest"},
		place_on = "tf_nodes:dirt_with_grass3",
		fill_ratio = 0.3,
		scale = 2,
		toughness = 2,
		composition = {thrag = 1},
	},
	grass10 = {
		name = "Grass",
		type = "simple",
		biomes = {"backyardforest"},
		place_on = "tf_nodes:dirt_with_grass4",
		fill_ratio = 0.3,
		composition = {rheer = 1},
	},
	grass11 = {
		name = "Grass",
		type = "simple",
		biomes = {"backyardforest"},
		place_on = "tf_nodes:dirt_with_grass4",
		fill_ratio = 0.2,
		composition = {vurg = 1},
	},
	grass12 = {
		name = "Reghaou Grass",
		type = "simple",
		biomes = {"redforest"},
		place_on = "tf_nodes:dirt_with_grass5",
		fill_ratio = 0.1,
		composition = {reghaou = 1},
	},
	grass13 = {
		name = "Gregoara Grass",
		type = "simple",
		biomes = {"redforest"},
		place_on = "tf_nodes:dirt_with_grass5",
		fill_ratio = 0.01,
		composition = {gregoara = 1},
	},
	grass14 = {
		name = "Rhe Grass",
		type = "simple",
		biomes = {"redforest"},
		place_on = "tf_nodes:dirt_with_grass5",
		fill_ratio = 0.01,
		scale = 2,
		toughness = 2,
		composition = {rhe = 1},
	},
	grass15 = {
		name = "Grass",
		type = "simple",
		biomes = {"redforest"},
		place_on = "tf_nodes:dirt_with_grass5",
		fill_ratio = 0.4,
		composition = {thrag = 1},
	},
	flower1 = {
		name = "Blue Flower",
		type = "simple",
		biomes = {"grassland"},
		place_on = "tf_nodes:dirt_with_grass1",
		use_noise = true,
		noise_spread = 100,
		fill_ratio = 0.01,
		noise_offset = -0.3,
		composition = {affer = 1},
	},
	flower2 = {
		name = "Red Flower",
		type = "simple",
		biomes = {"grassland"},
		place_on = "tf_nodes:dirt_with_grass1",
		use_noise = true,
		noise_spread = 100,
		fill_ratio = 0.01,
		noise_offset = -0.3,
		composition = {gra = 1},
	},
	flower3 = {
		name = "Yellow Flower",
		type = "simple",
		biomes = {"grassland"},
		place_on = "tf_nodes:dirt_with_grass1",
		use_noise = true,
		noise_spread = 100,
		fill_ratio = 0.01,
		noise_offset = -0.3,
		composition = {phye = 1},
	},
	flower3 = {
		name = "Orange Flower",
		type = "simple",
		biomes = {"backyardforest"},
		place_on = "tf_nodes:dirt_with_grass4",
		use_noise = true,
		noise_spread = 100,
		fill_ratio = 0.01,
		noise_offset = -0.3,
		composition = {deem = 1},
	},
}



local getPlantDescription = function(plantdef)
	local composition = {}
	local total_amount = 0
	for compound, amount in pairs(plantdef.composition) do
		total_amount = total_amount + amount
	end
	for _, compound in pairs(tf_vessels.get_sorted_components(plantdef.composition)) do
		local colorVec = tf_compounds.compounds[compound].color
		local colorString = core.rgba(colorVec.x, colorVec.y, colorVec.z)
		table.insert(composition, core.colorize(colorString, tf_compounds.compounds[compound].name))
	end
	return table.concat({
		plantdef.name,
		"Source of " .. table.concat(composition, ", "),
	}, "\n")
end



math.randomseed(0)
for plantid, plantdef in pairs(tf_plants.plantdefs) do
	core.register_node("tf_plants:plant_" .. plantid,{
		description = getPlantDescription(plantdef),
		tiles = {"tf_plant_" .. plantid .. ".png"},
		inventory_image = "tf_plant_" .. plantid .. ".png",
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
		groups = {plant = plantdef.toughness or 1, attached_node = 1}
	})
	for _, biome in pairs(plantdef.biomes) do
		for _, flagbase in pairs({8 + 32, 8 + 16 + 32}) do
			core.register_decoration({
				deco_type = "simple",
				place_on = plantdef.place_on,
				biomes = plantdef.biomes,
				fill_ratio = plantdef.fill_ratio,
				decoration = "tf_plants:plant_" .. plantid,
				param2 = flagbase + 0,
				param2_max = flagbase + 4,
				noise_params = plantdef.use_noise and {
					offset = plantdef.noise_offset or 0,
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



tf_plants.get_plant_composition = function(nodename)
	local plantid = string.sub(nodename, #"tf_plants:plant_" + 1)
	if tf_plants.plantdefs[plantid] then
		return tf_plants.plantdefs[plantid].composition or {}
	else
		return {}
	end
end