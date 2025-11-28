
--
-- Example Map Parameters
--
-- Create a new mod folder "mod/rpgmapgen_settings/", add an empty init.lua, and add a copy of this file.
-- If the mod is named correctly, the mapgen will recognize it and load the settings from its "map_parameters.lua"
--


local map_parameters = {}

-- Wavelengths of each noise layer
map_parameters.noiseperiods = {500, 100, 50, 10}
-- Amplitudes of each noise layer
map_parameters.noiseamps = {30, 10, 5, 1}



-- General map height, before any noise or flat areas are added
-- Useful for adding a mountain range or ocean at a specific location on the map
map_parameters.map_height = function(x,z)
	local south_river = -math.exp(-((z - -250)/50)^2) * 40
	local north_mountain = math.exp(-((z - 1100)/200)^2) * 200
	return 40 + south_river + north_mountain
end



--- Helper variables
local grassland_center = vector.new(0,40,0)
local fork_in_road = vector.new(0,40,150)
local npc_house = vector.new(100,40,175)
local backyardforest_center = vector.new(0,40,500)
local drygrassland_center = vector.new(600,40,700)
local redforest_center = vector.new(400,40,500)
local in_front_of_fireflyforest = vector.new(700,40,700)
local fireflyforest_center = vector.new(900,40,700)




-- Procedurally generated paths from one place to another
map_parameters.paths = {}

-- Helper for creating long, segmented paths
local pathdefs = {
	{ -- Path from start to fork
		points = {
			grassland_center,
			fork_in_road,
		},
		radius = 2,
		noise = {scale = 20, spread = vector.new(50,50,50)},
	},
	{ -- Path from fork to npc house
		points = {
			fork_in_road,
			npc_house,
		},
		radius = 2,
		noise = {scale = 20, spread = vector.new(50,50,50)},
	},
	{ -- Path from npc house to backyard forest
		points = {
			npc_house,
			backyardforest_center,
		},
		radius = 2,
		noise = {scale = 20, spread = vector.new(50,50,50)},
	},
	{ -- Path from backyard forest to redforest
		points = {
			backyardforest_center,
			redforest_center,
		},
		radius = 2,
		noise = {scale = 20, spread = vector.new(50,50,50)},
	},
	{ -- Path from redforest to drygrassland
		points = {
			redforest_center,
			drygrassland_center,
		},
		radius = 2,
		noise = {scale = 20, spread = vector.new(50,50,50)},
	},
	{ -- Path from drygrassland to in front of fireflyforest
		points = {
			drygrassland_center,
			in_front_of_fireflyforest,
		},
		radius = 2,
		noise = {scale = 20, spread = vector.new(50,50,50)},
	},
	{ -- Path from in front of fireflyforest to fireflyforest
		points = {
			in_front_of_fireflyforest,
			fireflyforest_center,
		},
		radius = 2,
		noise = {scale = 20, spread = vector.new(50,50,50)},
	},
}
for _, path in pairs(pathdefs) do
	for i = 1, #path.points - 1 do
		table.insert(map_parameters.paths, {
			radius = path.radius,
			node = path.node or "tf_nodes:path",
			halfheight_node = path.halfheight_node or "tf_nodes:path_slab",
			noise = path.noise,
			startpos = path.points[i],
			endpos = path.points[i+1],
		})
	end
end



-- Flat, circular areas around the map that are guaranteed to exist at that position
-- For use in story-based games which require stable areas for important locations
map_parameters.level_grounds = {
	{ -- Starting place
		pos = grassland_center,
		radius = 10,
		interpolation_length = 50,
		node = "tf_nodes:dirt_with_grass1"
	},
	{ -- Fork in the road
		pos = fork_in_road,
		radius = 10,
		interpolation_length = 50,
		node = "tf_nodes:dirt_with_grass1"
	},
	{ -- Npc house
		pos = npc_house,
		radius = 10,
		interpolation_length = 30,
		node = "tf_nodes:dirt_with_grass1"
	},
	{ -- backyardforest place
		pos = backyardforest_center,
		radius = 10,
		interpolation_length = 50,
		node = "tf_nodes:dirt_with_grass4"
	},
	{ -- redforest place
		pos = redforest_center,
		radius = 10,
		interpolation_length = 50,
		node = "tf_nodes:dirt_with_grass5"
	},
	{ -- drygrassland place
		pos = drygrassland_center,
		radius = 10,
		interpolation_length = 50,
		node = "tf_nodes:dirt_with_grass2"
	},
	{ -- place for npc in front of fireflyforest
		pos = in_front_of_fireflyforest,
		radius = 1,
		interpolation_length = 50,
		node = "tf_nodes:dirt_with_grass2"
	},
	{ -- Fireflyforest place
		pos = fireflyforest_center,
		radius = 10,
		interpolation_length = 50,
		node = "tf_nodes:dirt_with_grass3"
	},
}


local special_nodes = {
	{-- Scarecrow
		name = "tf_npcs:spawner_scarecrow1",
		pos = grassland_center + vector.new(0, 1, 8),
	},
	{ -- Empty barrel near spawn
		name = "tf_potions:vessel_spawner_barrel2_empty",
		pos = grassland_center + vector.new(-4, 1, 8),
	},
	{ -- Mound at fork
		name = "tf_npcs:spawner_npc5",
		pos = fork_in_road + vector.new(0,1,0),
	},
	{ -- Blue flower near npc house
		name = "tf_plants:plant_flower1",
		pos = npc_house + vector.new(-1,1,7),
	},
	{ -- red flower near npc house
		name = "tf_plants:plant_flower2",
		pos = npc_house + vector.new(-2,1,7),
	},
	{ -- yellow flower near npc house
		name = "tf_plants:plant_flower3",
		pos = npc_house + vector.new(-4,1,4),
	},
	{ -- Rock in backyardforest
		name = "tf_npcs:spawner_rock",
		pos = backyardforest_center + vector.new(0, 1, 0),
	},
	{ -- Tree in redforest
		name = "tf_npcs:spawner_tree",
		pos = redforest_center + vector.new(0, 1, 0),
	},
	{ -- Thistle in drygrassland
		name = "tf_npcs:spawner_thistle",
		pos = drygrassland_center + vector.new(0, 1, 0),
	},
	{ -- Mound near fireflyforest
		name = "tf_npcs:spawner_npc2",
		pos = in_front_of_fireflyforest + vector.new(0, 1, 0),
	},
	{-- Other Scarecrow
		name = "tf_npcs:spawner_npc4",
		pos = fireflyforest_center + vector.new(0, 1, 0),
	},
}


-- Schematics to be spawned at specific locations
map_parameters.schematics = {
	-- Wizard's house
	{
		pos = npc_house + vector.new(2, 1, -5),
		-- Just an upper-bound guess at how large the schematic is. This is used to determine whether it might overlap with the mapblock being generated.
		approx_size = 25,
		schematic = core.get_modpath("rpgmapgen_settings") .. "/schems/house1_v3.mts",
		-- All the flags and options just like normal schematics
		rotation = "0",
		replacements = {},
		force_placement = true,
		flags = "place_center_x,place_center_z",
	}
}
-- Algorithmically populate it based on the npc spawner list
for _, special_node in pairs(special_nodes) do
	table.insert(map_parameters.schematics,
	{
		pos = special_node.pos,
		-- Just an upper-bound guess at how large the schematic is. This is used to determine whether it might overlap with the mapblock being generated.
		approx_size = 5,
		schematic = {
			size = vector.new(1,1,1),
			data = {
				{name = special_node.name},
			}
		},
		force_placement = true,
	})
end

-- You can also modify the terrain generation based on the slope of the noise
-- Inspired by https://www.youtube.com/watch?v=gsJHzBTPG0Y
-- Input is slope squared because it's faster to calcuate and doesn't really matter
map_parameters.slope_adjustment = function(height, slope_squared)
    return height - 10 * slope_squared
end


-- Function for custom biome distribution
-- Takes in the pos, and returns a table containing the biome id {biome = 1}
local biome_positions = nil -- Will be generated once the function is called the first time; it must be called after core is set up, otherwise the biome ids are nil
map_parameters.get_biome_data = function(pos)
	if biome_positions == nil then
		biome_positions = {
			{
				biome_id = core.get_biome_id("grassland"),
				center = grassland_center,
				weight = 1
			},
			{
				biome_id = core.get_biome_id("drygrassland"),
				center = drygrassland_center,
				weight = 1
			},
			{
				biome_id = core.get_biome_id("fireflyforest"),
				center = fireflyforest_center,
				weight = 1
			},
			{
				biome_id = core.get_biome_id("backyardforest"),
				center = backyardforest_center,
				weight = 1
			},
			{
				biome_id = core.get_biome_id("redforest"),
				center = redforest_center,
				weight = 1
			},
		}
	end
	local random_shifted_pos = pos + vector.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))
	-- Find closest biome
	local closest_id = nil
	local closest_dist = math.huge
	for _, biome in pairs(biome_positions) do
		if random_shifted_pos:distance(biome.center) / biome.weight < closest_dist then
			closest_id = biome.biome_id
			closest_dist = random_shifted_pos:distance(biome.center) / biome.weight
		end
	end
	return {biome = closest_id}
end


return map_parameters