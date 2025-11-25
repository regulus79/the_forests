


-- TODO make a loop to do this stuff, like with plants

core.register_node("regulus_nodes:ore1", {
	description = "Living Stone",
	tiles = {"regulus_stone4.png^regulus_ore1.png"},
	groups = {stone = 1, ore = 1},
	on_dig = function(pos, node, digger)
		local potion_levels = core.deserialize(digger:get_meta():get_string("potion_levels"))
		potion_levels["fear_hormone"] = (potion_levels["fear_hormone"] or 0) + 1
		digger:get_meta():set_string("potion_levels", core.serialize(potion_levels))
		return core.node_dig(pos, node, digger)
	end,
})


