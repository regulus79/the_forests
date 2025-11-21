

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