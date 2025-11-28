

tf_quests = {}

dofile(core.get_modpath("tf_quests") .. "/quests.lua")


tf_quests.is_quest_active = function(player, questid)
	local active_quests = core.deserialize(player:get_meta():get_string("active_quests")) or {}
	return active_quests[questid] ~= nil
end



tf_quests.start_quest = function(player, questid)
	local active_quests = core.deserialize(player:get_meta():get_string("active_quests")) or {}
	active_quests[questid] = true
	player:get_meta():set_string("active_quests", core.serialize(active_quests))
end

tf_quests.finish_quest = function(player, questid)
	local active_quests = core.deserialize(player:get_meta():get_string("active_quests")) or {}
	active_quests[questid] = nil
	player:get_meta():set_string("active_quests", core.serialize(active_quests))
	local completed_quests = core.deserialize(player:get_meta():get_string("completed_quests")) or {}
	completed_quests[questid] = true
	player:get_meta():set_string("completed_quests", core.serialize(completed_quests))
end

tf_quests.completed_quest = function(player, questid)
	local completed_quests = core.deserialize(player:get_meta():get_string("completed_quests")) or {}
	return completed_quests[questid] ~= nil
end