



for i = 1, 5 do
	core.register_node("regulus_nodes:dirt_with_grass" .. i,{
		description = "Dirt with Grass",
		tiles = {"regulus_grass" .. i .. ".png"},
		groups = {dirt = 1}
	})
end

core.register_node("regulus_nodes:stone",{
	description = "yay2",
	tiles = {"regulus_stone1.png"},
	groups = {stone = 1}
})

for i = 1, 3 do
	core.register_node("regulus_nodes:dirt" .. i,{
		description = "Dirt",
		tiles = {"regulus_dirt" .. i .. ".png"},
		groups = {dirt = 2}
	})
end


for i = 1, 4 do
	core.register_node("regulus_nodes:tree" .. i,{
		description = "Tree",
		tiles = {"regulus_tree" .. i .. ".png"},
		groups = {wood = 1}
	})
end

for i = 1, 4 do
	core.register_node("regulus_nodes:leaves" .. i,{
		description = "Leaves",
		tiles = {"regulus_leaves" .. i .. ".png"},
		use_texture_alpha = "blend",
		drawtype = "allfaces_optional",
		paramtype = "light",
		groups = {plant = 1}
	})
end




core.register_node("regulus_nodes:sand",{
	description = "yay3",
	tiles = {"regulus_sand1.png"},
	groups = {dirt = 1}
})


core.register_node("regulus_nodes:path",{
	description = "Path",
	tiles = {"regulus_path1.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
	},
	groups = {dirt = 3}
})
core.register_node("regulus_nodes:path_slab",{
	description = "Path",
	tiles = {"regulus_path1.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5}
	},
	groups = {dirt = 3}
})




core.register_node("regulus_nodes:water_source", {
	description = "water source",
	drawtype = "liquid",
	waving = 1,
	tiles = {"regulus_water_source.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	buildable_to = true,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "regulus_nodes:water_flowing",
	liquid_alternative_source = "regulus_nodes:water_source",
	liquid_viscosity = 1,
	post_effect_colot = {a = 100, r = 20, g = 30, b = 80},
	groups = {water = 1},
})

core.register_node("regulus_nodes:water_flowing", {
	description = "water flowing",
	drawtype = "flowingliquid",
	waving = 1,
	tiles = {"regulus_water_flowing.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	buildable_to = true,
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "regulus_nodes:water_flowing",
	liquid_alternative_source = "regulus_nodes:water_source",
	liquid_viscosity = 1,
	post_effect_colot = {a = 100, r = 20, g = 30, b = 80},
	groups = {water = 1},
})