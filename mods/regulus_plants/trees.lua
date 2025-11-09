

-- Simple Pine-like tree
core.register_decoration({
	deco_type = "lsystem",
	place_on = "regulus_nodes:dirt_with_grass1",
	biomes = {"grassland"},
	fill_ratio = 0.001,
	treedef = {
		axiom = "TTTdATdATdATBTBTC",
		rules_a = "[&&&Gf][&&&+Gf][&&&++Gf][&&&+++Gf][&&&++++Gf][&&&+++++Gf][&&&++++++Gf][&&&-Gf][&&&--Gf][&&&---Gf][&&&----Gf][&&&-----Gf]",
		rules_b = "[&&&Gf][&&&+++Gf][&&&++++++Gf][&&&---Gf]",
		rules_c = "[ffff]",
		rules_d = "[&&&GGf][&&&+++GGf][&&&++++++GGf][&&&---GGf]",
		trunk = "regulus_nodes:tree1",
		leaves = "regulus_nodes:leaves1",
		angle = 30,
		iterations = 1,
		random_level = 0,
		trunk_type = "single",
		thin_branches = true,
	},
})


-- Dense dark canopy tree
core.register_decoration({
	deco_type = "lsystem",
	place_on = "regulus_nodes:dirt_with_grass3",
	biomes = {"fireflyforest"},
	fill_ratio = 0.02,
	treedef = {
		axiom = "[d***d***d***d]T[d***d***d***d]TTTTbTTTTbTTTTbTTTTba",
		rules_a = "[&&&FFFF[--FFFF][++FFFF]]",
		rules_b = "[c****c****c****]",
		rules_c = "[&&&FFF[--FF][++FF]]",
		rules_d = "[&&&G^^^T]",
		trunk = "regulus_nodes:tree2",
		leaves = "regulus_nodes:leaves2",
		leaves2 = "air",
		leaves2_chance = 30,
		angle = 30,
		iterations = 1,
		random_level = 0,
		trunk_type = "single",
		thin_branches = true,
	},
})



-- Backyard forest tree
core.register_decoration({
	deco_type = "lsystem",
	place_on = "regulus_nodes:dirt_with_grass4",
	biomes = {"backyardforest"},
	fill_ratio = 0.01,
	treedef = {
		axiom = "TTTT*dTT*dTT*dTT*cTT*cTT*cTT*bTT*bTT*aTT*a",
		rules_a = "[&&&GfFf[++fFf][--fFf]][****&&&GfFf[++fFf][--fFf]][////&&&GfFf[++fFf][--fFf]]",
		rules_b = "[&&Gfff[++fff][--fff]][****&&Gfff[++fff][--fff]][////&&Gfff[++fff][--fff]]",
		rules_c = "[-&&Gfff[++fff][--fff]][-****&&Gfff[++fff][--fff]][-////&&Gfff[++fff][--fff]]",
		rules_d = "[+&&Gf[++ff][--ff]][+****&&Gf[++ff][--ff]][+////&&Gf[++ff][--ff]]",
		trunk = "regulus_nodes:tree3",
		leaves = "regulus_nodes:leaves3",
		angle = 30,
		iterations = 1,
		random_level = 0,
		trunk_type = "single",
		thin_branches = true,
	},
})



-- Red forest tree
core.register_decoration({
	deco_type = "lsystem",
	place_on = "regulus_nodes:dirt_with_grass5",
	biomes = {"redforest"},
	fill_ratio = 0.005,
	treedef = {
		axiom = "Taab****d****d****dbab****d****ad****adbb****d****d****ad**b****cb****cab****c",
		rules_a = "T",
		rules_b = "[&&&Gf][&&&+++Gf][&&&++++++Gf][&&&---Gf]",
		rules_c = "[&&fffF]",
		rules_d = "[+*&&Gff&ff&ff]",
		trunk = "regulus_nodes:tree4",
		leaves = "regulus_nodes:leaves4",
		angle = 30,
		iterations = 1,
		random_level = 0,
		trunk_type = "single",
		thin_branches = true,
	},
})