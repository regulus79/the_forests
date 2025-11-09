
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
	return 30
end


-- Procedurally generated paths from one place to another
map_parameters.paths = {}

-- Helper for creating long, segmented paths
local pathdefs = {
	{ -- Path from start to fireflyforest
		points = {
			vector.new(0,0,0),
			vector.new(100,0,-100),
			vector.new(300,0,-100),
			vector.new(500,0,100),
		},
		radius = 2,
		noise = {scale = 20, spread = vector.new(50,50,50)},
	},
	{ -- Path from start to backyardforest
		points = {
			vector.new(0,0,0),
			vector.new(-100,0,100),
		},
		radius = 2,
		noise = {scale = 20, spread = vector.new(50,50,50)},
	},
	{ -- Path from backyardforest to redforest
		points = {
			vector.new(-100,0,100),
			vector.new(200,0,300),
		},
		radius = 2,
		noise = {scale = 20, spread = vector.new(50,50,50)},
	},
	{ -- Path from start down south
		points = {
			vector.new(0,0,0),
			vector.new(0,0,-300),
		},
		radius = 2,
		noise = {scale = 20, spread = vector.new(50,50,50)},
	},
}
for _, path in pairs(pathdefs) do
	for i = 1, #path.points - 1 do
		table.insert(map_parameters.paths, {
			radius = path.radius,
			node = path.node or "regulus_nodes:path",
			halfheight_node = path.halfheight_node or "regulus_nodes:path_slab",
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
		pos = vector.new(0,30,0),
		radius = 10,
		interpolation_length = 50,
		node = "regulus_nodes:dirt_with_grass1"
	},
	{ -- Fireflyforest place
		pos = vector.new(500,30,100),
		radius = 10,
		interpolation_length = 50,
		node = "regulus_nodes:dirt_with_grass2"
	},
	{ -- backyardforest place
		pos = vector.new(-100,30,100),
		radius = 10,
		interpolation_length = 50,
		node = "regulus_nodes:dirt_with_grass4"
	},
	{ -- redforest place
		pos = vector.new(200,30,300),
		radius = 10,
		interpolation_length = 50,
		node = "regulus_nodes:dirt_with_grass5"
	},
}

-- Schematics to be spawned at specific locations
map_parameters.schematics = {
	{
		pos = vector.new(30,10,0),
		-- Just an upper-bound guess at how large the schematic is. This is used to determine whether it might overlap with the mapblock being generated.
		approx_size = 5,
		file = core.get_modpath("regulus_nodes") .. "/schematics/bush.mts",
		-- All the flags and options just like normal schematics
		rotation = "0",
		replacements = {},
		force_placement = true,
		flags = "place_center_x,place_center_z",
	}
}

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
				center = vector.new(0,0,0),
				weight = 1
			},
			{
				biome_id = core.get_biome_id("drygrassland"),
				center = vector.new(-200,0,600),
				weight = 1
			},
			{
				biome_id = core.get_biome_id("fireflyforest"),
				center = vector.new(500,0,100),
				weight = 1
			},
			{
				biome_id = core.get_biome_id("backyardforest"),
				center = vector.new(-100,0,100),
				weight = 1
			},
			{
				biome_id = core.get_biome_id("redforest"),
				center = vector.new(200,0,300),
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