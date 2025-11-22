
-- Barrel1
local barrel1_nodeboxes = {}
for i = 0, regulus_vessels.max_fullness_level do
	barrel1_nodeboxes[i] = {
		type = "fixed",
		fixed = {
			{-6/16,-8/16,-5/16, -5/16, 5/16, 5/16},
			{-5/16,-8/16,-6/16, 5/16, 5/16, -5/16},
			{5/16,-8/16,-5/16, 6/16, 5/16, 5/16},
			{-5/16,-8/16,5/16, 5/16, 5/16, 6/16},
			{-5/16,-8/16,-5/16, 5/16, -7/16 + i/regulus_vessels.max_fullness_level * 12/16, 5/16},
		}
	}
end
regulus_vessels.register_vessel("barrel1", {
	description = "Large Barrel",
	capacity = 10,
	node_boxes = barrel1_nodeboxes,
	texture = "regulus_vessels_barrel1.png",
	rim_texture = "regulus_vessels_barrel1_rim.png",
})


-- Barrel2
local barrel2_nodeboxes = {}
for i = 0, regulus_vessels.max_fullness_level do
	barrel2_nodeboxes[i] = {
		type = "fixed",
		fixed = {
			{-5/16,-8/16,-4/16, -4/16, 3/16, 4/16},
			{-4/16,-8/16,-5/16, 4/16, 3/16, -4/16},
			{4/16,-8/16,-4/16, 5/16, 3/16, 4/16},
			{-4/16,-8/16,4/16, 4/16, 3/16, 5/16},
			{-4/16,-8/16,-4/16, 4/16, -7/16 + i/regulus_vessels.max_fullness_level * 10/16, 4/16},
		}
	}
end
regulus_vessels.register_vessel("barrel2", {
	description = "Medium Barrel",
	capacity = 6,
	node_boxes = barrel2_nodeboxes,
	texture = "regulus_vessels_barrel2.png",
	rim_texture = "regulus_vessels_barrel2_rim.png",
})


-- Barrel3
local barrel3_nodeboxes = {}
for i = 0, regulus_vessels.max_fullness_level do
	barrel3_nodeboxes[i] = {
		type = "fixed",
		fixed = {
			{-4/16,-8/16,-3/16, -3/16, 1/16, 3/16},
			{-3/16,-8/16,-4/16, 3/16, 1/16, -3/16},
			{3/16,-8/16,-3/16, 4/16, 1/16, 3/16},
			{-3/16,-8/16,3/16, 3/16, 1/16, 4/16},
			{-3/16,-8/16,-3/16, 3/16, -7/16 + i/regulus_vessels.max_fullness_level * 8/16, 3/16},
		}
	}
end
regulus_vessels.register_vessel("barrel3", {
	description = "Small Barrel",
	capacity = 3,
	node_boxes = barrel3_nodeboxes,
	texture = "regulus_vessels_barrel3.png",
	rim_texture = "regulus_vessels_barrel3_rim.png",
})
