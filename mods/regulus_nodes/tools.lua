

local pickaxe_types = {
	wood = {
		name = "Wooden",
		groupcaps = {times = {2,3,4}, uses = 10, maxlevel = 1},
	},
	stone = {
		name = "Stone",
		groupcaps = {times = {1,2,3}, uses = 10, maxlevel = 2},
	},
}

for i = 1, 4 do
	for material, stats in pairs(pickaxe_types) do
		core.register_tool("regulus_nodes:pickaxe" .. i .. "_" .. material, {
			description = stats.name .. " Pickaxe",
			inventory_image = "regulus_stick" .. i .. ".png^regulus_pickaxe_overlay_" .. material .. ".png",
			wield_image = "regulus_stick" .. i .. ".png^regulus_pickaxe_overlay_" .. material .. ".png^[transformR270",
			tool_capabilities = {
				groupcaps = {
					stone = stats.groupcaps,
				},
			}
		})
		core.register_craft({
			type = "shaped",
			output = "regulus_nodes:pickaxe" .. i .. "_" .. material,
			recipe = {
				{"group:" .. material, "group:" .. material, "group:" .. material},
				{"", "regulus_nodes:stick" .. i, ""},
				{"", "regulus_nodes:stick" .. i, ""},
			}
		})
	end
end