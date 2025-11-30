
tf_nodes = {}

tf_nodes.num_boulders = 5



for i = 1, 5 do
	core.register_node("tf_nodes:dirt_with_grass" .. i,{
		description = "Dirt with Grass",
		tiles = {"tf_grass" .. i .. ".png"},
		groups = {dirt = 1}
	})
end



for i = 1, 5 do
	core.register_node("tf_nodes:stone" .. i,{
		description = "Stone",
		tiles = {"tf_stone" .. i .. ".png"},
		drop = {
			max_items = 1,
			items = {
				{rarity = 4, items = {"tf_nodes:stones" .. i .. " 4"}},
				{rarity = 3, items = {"tf_nodes:stones" .. i .. " 3"}},
				{rarity = 2, items = {"tf_nodes:stones" .. i .. " 2"}},
				{rarity = 1, items = {"tf_nodes:stones" .. i .. " 1"}},
			}
		},
		groups = {stone = 1, generate_stairs = 1}
	})
	core.register_node("tf_nodes:stone" .. i .. "_brick",{
		description = "Stone Brick",
		tiles = {"tf_stone" .. i .. "_brick.png"},
		groups = {stone = 1, generate_stairs = 1}
	})
	core.register_craft({
		type = "shapeless",
		output = "tf_nodes:stone" .. i .. "_brick 4",
		recipe = {"tf_nodes:stone" .. i, "tf_nodes:stone" .. i, "tf_nodes:stone" .. i, "tf_nodes:stone" .. i},
	})
	-- Make boulders
	math.randomseed(i)
	local randrange = function(a,b) return math.round(16 * (math.random() * (b-a) + a)) / 16 end
	for k = 1, tf_nodes.num_boulders do
		core.register_node("tf_nodes:stone" .. i .. "_boulder" .. k,{
			description = "Stone",
			tiles = {"tf_stone" .. i .. ".png"},
			groups = {stone = 1},
			drop = "tf_nodes:stones" .. i,
			drawtype = "nodebox",
			paramtype = "light",
			node_box = {
				type = "fixed",
				fixed = {
					{-randrange(0.1, 0.3), -0.5, -randrange(0.1, 0.3), randrange(0.1, 0.3), randrange(-0.2, 0.1), randrange(0.1, 0.3)},
					{-randrange(0.2, 0.5), -0.5, -randrange(0.2, 0.5), randrange(0.2, 0.5), randrange(-0.3, -0.2), randrange(0.2, 0.5)},
					{-randrange(0.2, 0.5), -0.5, -randrange(0.2, 0.5), randrange(0.2, 0.5), randrange(-0.4, -0.3), randrange(0.2, 0.5)},
				}
			}
		})
	end
	math.randomseed(os.time())
end




for i = 1, 3 do
	core.register_node("tf_nodes:dirt" .. i,{
		description = "Dirt",
		tiles = {"tf_dirt" .. i .. ".png"},
		groups = {dirt = 2, generate_stairs = 1}
	})
end


for i = 1, 4 do
	core.register_node("tf_nodes:tree" .. i,{
		description = "Tree",
		tiles = {
			"tf_tree" .. i .. "_top.png",
			"tf_tree" .. i .. "_top.png",
			"tf_tree" .. i .. ".png",
			"tf_tree" .. i .. ".png",
			"tf_tree" .. i .. ".png",
			"tf_tree" .. i .. ".png",
		},
		paramtype2 = "facedir",
		on_place = core.rotate_node,
		groups = {tree = 1, generate_stairs = 1}
	})
	core.register_craft({
		type = "shapeless",
		output = "tf_nodes:wood" .. i .. " 4",
		recipe = {"tf_nodes:tree" .. i},
	})
end

for i = 1, 4 do
	core.register_node("tf_nodes:wood" .. i,{
		description = "Wood",
		tiles = {"tf_wood" .. i .. ".png"},
		groups = {wood = 1, generate_stairs = 1}
	})
	core.register_craft({
		type = "shapeless",
		output = "tf_nodes:stick" .. i .. " 4",
		recipe = {"tf_nodes:wood" .. i},
	})
end

for i = 1, 4 do
	core.register_node("tf_nodes:leaves" .. i,{
		description = "Leaves",
		tiles = {"tf_leaves" .. i .. ".png"},
		use_texture_alpha = "blend",
		drawtype = "allfaces_optional",
		paramtype = "light",
		groups = {plant = 1}
	})
end




core.register_node("tf_nodes:sand",{
	description = "Sand",
	tiles = {"tf_sand1.png"},
	groups = {dirt = 1}
})

core.register_node("tf_nodes:glass",{
	description = "Glass",
	tiles = {"tf_glass.png"},
	use_texture_alpha = "blend",
	drawtype = "glasslike",
	paramtype = "light",
	groups = {glass = 1, generate_stairs = 1}
})





core.register_node("tf_nodes:path",{
	description = "Path",
	tiles = {"tf_path1.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
	},
	groups = {dirt = 3}
})
core.register_node("tf_nodes:path_slab",{
	description = "Path",
	tiles = {"tf_path1.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5}
	},
	groups = {dirt = 3}
})




core.register_node("tf_nodes:water_source", {
	description = "water source",
	drawtype = "liquid",
	waving = 1,
	tiles = {"tf_water_source.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	buildable_to = true,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "tf_nodes:water_flowing",
	liquid_alternative_source = "tf_nodes:water_source",
	liquid_viscosity = 1,
	post_effect_colot = {a = 100, r = 20, g = 30, b = 80},
	groups = {water = 1},
})

core.register_node("tf_nodes:water_flowing", {
	description = "water flowing",
	drawtype = "flowingliquid",
	waving = 1,
	tiles = {"tf_water_flowing.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	buildable_to = true,
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "tf_nodes:water_flowing",
	liquid_alternative_source = "tf_nodes:water_source",
	liquid_viscosity = 1,
	post_effect_colot = {a = 100, r = 20, g = 30, b = 80},
	groups = {water = 1},
})



for i = 1,1 do
	core.register_node("tf_nodes:fire" .. i, {
		description = "Fire",
		drawtype = "plantlike",
		tiles = {{
			name = "tf_fire" .. i .. ".png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.2,
			},
		}},
		paramtype = "light",
		paramtype2 = "meshoptions",
		place_param2 = 0,
		light_source = 8,
		drop = "",
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.1, -0.5, -0.1, 0.1, -0.1, 0.1},
		},
		damage_per_second = 1,
		buildable_to = true,
		groups = {dig_immediate = 3, fire = 1},
	})
end


-- should this go in another file? in ores? idk
core.register_node("tf_nodes:livingstone", {
	description = "Living Stone",
	tiles = {"tf_stone4.png^tf_livingstone.png"},
	groups = {stone = 1},
	on_dig = function(pos, node, digger)
		local potion_levels = core.deserialize(digger:get_meta():get_string("potion_levels"))
		potion_levels["fear_hormone"] = (potion_levels["fear_hormone"] or 0) + 1
		digger:get_meta():set_string("potion_levels", core.serialize(potion_levels))
		return core.node_dig(pos, node, digger)
	end,
})



core.register_node("tf_nodes:torch", {
	description = "Torch",
	drawtype = "torchlike",
	tiles = {
		{
			name = "tf_torch.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.2,
			},
		},
		{
			name = "tf_torch_ceiling.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.2,
			},
		},
		{
			name = "tf_torch_wall.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.2,
			},
		},
	},
	inventory_image = "tf_torch.png^[verticalframe:4:1",
	wield_image = "tf_torch.png^[verticalframe:4:1",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 10,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.2, -0.1, -0.2, 0.2, 0.5, 0.2},
		wall_bottom = {-0.2, -0.5, -0.2, 0.2, 0.1, 0.2},
		wall_side = {-0.5, -0.4, -0.2, 0.0, 0.2, 0.2},
	},
	buildable_to = true,
	groups = {dig_immediate = 3, fire = 1},
})
core.register_craft({
	type = "shaped",
	output = "tf_nodes:torch 4",
	recipe = {
		{"group:coal"},
		{"group:stick"},
	},
})




dofile(core.get_modpath("tf_nodes") .. "/craftitems.lua")
dofile(core.get_modpath("tf_nodes") .. "/tools.lua")
dofile(core.get_modpath("tf_nodes") .. "/stairs.lua")