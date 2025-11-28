
tf_dialogue = {}

tf_dialogue.dialogues = {}


local active_dialogues = {}


tf_dialogue.get_formspec_string = function(dialogue_def, index)
	local width, height = 12, 4
	local formspec = table.concat({
		"formspec_version[9]",
		"size[12,4]",
		"position[0.5,0.75]",
		(index < #dialogue_def and "button" or "button_exit") .. "[" .. tostring(width - 2.25) .. "," .. tostring(height - 1) .. ";2,0.75;next;Continue]",
		"label[1,1;" .. dialogue_def[index].text .. "]"
	}, "\n")
	return formspec
end

tf_dialogue.start_dialogue = function(player, dialogue_id)
	active_dialogues[player:get_player_name()] = dialogue_id
	local index = 1
	core.show_formspec(player:get_player_name(), "dialogue_" .. dialogue_id .. "_line_" .. index, tf_dialogue.get_formspec_string(tf_dialogue.dialogues[dialogue_id], index))
end

core.register_on_player_receive_fields(function(player, formname, fields)
	if not string.sub(formname, 1, #"dialogue_") == "dialogue_" then
		return
	end
	local dialogue_id_and_index = string.sub(formname, #"dialogue_" + 1)
	local dialogue_id, index = unpack(string.split(dialogue_id_and_index, "_line_"))
	index = tonumber(index)
	local dialogue_def = tf_dialogue.dialogues[dialogue_id]
	if not dialogue_def then
		return
	end
	if index < #dialogue_def then
		index = index + 1
		core.show_formspec(player:get_player_name(), "dialogue_" .. dialogue_id .. "_line_" .. index, tf_dialogue.get_formspec_string(tf_dialogue.dialogues[dialogue_id], index))
	elseif index == #dialogue_def then
		local completed_dialogues = core.deserialize(player:get_meta():get_string("completed_dialogues")) or {}
		completed_dialogues[dialogue_id] = true
		player:get_meta():set_string("completed_dialogues", core.serialize(completed_dialogues))
		active_dialogues[player:get_player_name()] = nil
	end
end)


tf_dialogue.had_dialogue = function(player, dialogue_id)
	local completed_dialogues = core.deserialize(player:get_meta():get_string("completed_dialogues"))
	if completed_dialogues then
		return completed_dialogues[dialogue_id] ~= nil
	else
		return false
	end
end

tf_dialogue.is_dialogue_active = function(player, dialogue_id)
	return active_dialogues[player:get_player_name()] == dialogue_id
end