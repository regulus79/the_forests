

regulus_hud = {}

local elements = {}


regulus_hud.add_hud_element = function(player, name, elem)
	if not elements[player:get_player_name()] then
		elements[player:get_player_name()] = {}
	end
	elements[player:get_player_name()][name] = player:hud_add(elem)
end

regulus_hud.change_hud_element = function(player, name, stat, value)
	player:hud_change(elements[player:get_player_name()][name], stat, value)
end



local player_captions = {}

core.register_on_joinplayer(function(player)
	regulus_hud.add_hud_element(player, "info_captions", {
		type = "text",
		number = 0xFFFFFF,
		position = {x = 0.5, y = 0.2},
		scale = {x = 100, y = 100},
		alignment = {x = 0, y = 1},
		offset = {x = 0, y = 0},
		size = {x = 6},
		style = 0*1 + 0*2 + 0*4,
	})
end)


regulus_hud.update_captions = function(player)
	local captions = player_captions[player:get_player_name()] or {}
	local texts = {}
	for id, text in pairs(captions) do
		if #text > 0 then
			table.insert(texts, text)
		end
	end
	regulus_hud.change_hud_element(player, "info_captions", "text", table.concat(texts, "\n"))
end

regulus_hud.set_caption = function(player, captionid, text)
	if not player_captions[player:get_player_name()] then
		player_captions[player:get_player_name()] = {}
	end
	player_captions[player:get_player_name()][captionid] = text
	regulus_hud.update_captions(player)
end