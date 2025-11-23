
regulus_npcs.npcs["wizard"] = {
	_notice_distance = 5,
	_notice_rate = 0.5,
	_turn_on_rightclick = true,
	get_next_dialogue = function(self, player)
		if not regulus_dialogue.had_dialogue(player, "wizard_talk1") then
			return "wizard_talk1", true
		else
			return "wizard_idle", false
		end
	end,
}
regulus_dialogue.dialogues["wizard_talk1"] = {
	{text = "aahahhhghghghhjlllllmm... mhmm"},
	{text = "what are you doing"},
	{text = "you look tired"},
	{text = "come on in"},
	{text = "let me give you something to drink"},
	{text = "see that cup of green stuff?"},
	{text = "that has some good tea in it"},
	{text = "you should drink it"},
}
regulus_dialogue.dialogues["wizard_idle"] = {
	{text = "what is it"},
	{text = "why are you talking to me"},
}




-- Mound in front of fireflyforest
regulus_npcs.npcs["npc2"] = {
	_notice_distance = 20,
	_notice_rate = 0.95,
	_turn_on_rightclick = true,
	get_next_dialogue = function(self, player)
		if not regulus_dialogue.had_dialogue(player, "npc2_idle1") then
			return "npc2_idle1", true
		else
			return "npc2_idle2", false
		end
	end,
}
regulus_dialogue.dialogues["npc2_idle1"] = {
	{text = "do not go into the forest"},
	{text = "I beg you, do not go into the forest"},
	{text = "please, listen to me! do not go"},
	{text = "the forest is dangerous"},
	{text = "no one who enters returns"},
}
regulus_dialogue.dialogues["npc2_idle2"] = {
	{text = "do not enter it!"},
}


-- Scarecrow
regulus_npcs.npcs["scarecrow1"] = {
	_notice_distance = 5,
	_notice_rate = 0.5,
	_turn_on_rightclick = true,
	get_next_dialogue = function(self, player)
		if not regulus_dialogue.had_dialogue(player, "scarecrow1_talk1") then
			return "scarecrow1_talk1", true
		else
			return "scarecrow1_idle1", false
		end
	end,
}
regulus_dialogue.dialogues["scarecrow1_talk1"] = {
	{text = "AAAAAAAAA!!!!"},
	{text = "you scared me\nI thought you were a crow for a moment"},
	{text = "the crows are going to be coming soon this year and I am so scared of them"},
	{text = "have you heard what they do to you?"},
	{text = "it's too terrible to speak of"},
	{text = "I hope you don't run into any crows on your journeys"},
	{text = "wow"},
	{text = "so what are you doing here"},
	{text = "are you a traveller?"},
	{text = "do you want a mission?"},
	{text = "I will tell you a secret"},
	{text = "come closer come closer pssst"},
	{text = "I heard in the wind"},
	{text = "I heard a voice"},
	{text = "in the wind"},
	{text = "it was a wind voice"},
	{text = "it told me something"},
	{text = "it told me Hraugh is alive"},
	{text = "that's impossible"},
	{text = "I don't believe it"},
	{text = "but maybe a tiny bit"},
	{text = "i do really want to see him again"},
	{text = "it's been so many years"},
	{text = "ever since that storm long ago which blew me up from the gardens down south"},
	{text = "Hraugh got blown up too"},
	{text = "uprooted from his stake and sent flying in the whirlwind"},
	{text = "I landed up here"},
	{text = "I don't know where Hraugh fell"},
	{text = "I never saw him again"},
	{text = "i have been waiting for a gust to come and blow me back"},
	{text = "to fly me home to see all the others"},
	{text = "i don't know if it will ever happen"},
	{text = "my straws are starting to fall"},
	{text = ""},
	{text = "but if the wind says he's alive"},
	{text = "I"},
	{text = "I don't know"},
	{text = ""},
	{text = "can you help me?"},
	{text = "can you find out if Hraugh is alive?"},
}
regulus_dialogue.dialogues["scarecrow1_idle1"] = {
	{text = "please"},
	{text = "can you find out if Hraugh is alive?"},
}




--- Hraugh scarecrow
regulus_npcs.npcs["npc4"] = {
	_notice_distance = 5,
	_notice_rate = 0.5,
	_turn_on_rightclick = true,
	get_next_dialogue = function(self, player)
		if not regulus_dialogue.had_dialogue(player, "other_scarecrow1") then
			return "other_scarecrow1", true
		end
	end,
}
regulus_dialogue.dialogues["other_scarecrow1"] = {
	{text = "sigh..."},
	{text = "..."},
	{text = "hello there"},
	{text = "it's been a long time since anyone has come down this path"},
}








regulus_npcs.npcs["rock"] = {
	_notice_distance = 5,
	_notice_rate = 0.5,
	_turn_on_rightclick = true,
	get_next_dialogue = function(self, player)
		if not regulus_dialogue.had_dialogue(player, "rock_idle1") then
			return "rock_idle1", true
		else
			return "rock_idle2", false
		end
	end,
}
regulus_dialogue.dialogues["rock_idle1"] = {
	{text = "I am a rock"},
	{text = "what are you doing here"},
	{text = "are you a miner?"},
	{text = "miners are not welcome here"},
	{text = "the rocks in this land are sacred"},
	{text = "they are living"},
	{text = "they can sense you"},
	{text = "do not touch them"},
	{text = "okay?"},
	{text = "were you planning to mine here?"},
	{text = "I can feel it in your being"},
	{text = "the greed"},
	{text = "the malice"},
	{text = "you want to steal gems and stones and sell them for money"},
	{text = "why do you do this to us"},
	{text = "whyyy"},
	{text = "just go"},
	{text = "just get out"},
	{text = "just"},
	{text = "LEAVE"},
	{text = "okay???"},
	{text = "GET OUT"},
}
regulus_dialogue.dialogues["rock_idle2"] = {
	{text = "do not mine here!"},
}






-- Mound in front of spawn
regulus_npcs.npcs["npc5"] = {
	_notice_distance = 20,
	_notice_rate = 0.95,
	_turn_on_rightclick = true,
	get_next_dialogue = function(self, player)
		if not regulus_dialogue.had_dialogue(player, "npc5_idle1") then
			return "npc5_idle1", true
		else
			return "npc5_idle2", false
		end
	end,
}
regulus_dialogue.dialogues["npc5_idle1"] = {
	{text = "hiiiii!!!!"},
	{text = "are you new here?"},
	{text = "I can show you around!"},
	{text = "actually wait no I can't move"},
	{text = "I have so many friends around here"},
	{text = "do you want to be friends too?"},
	{text = "I wish I could walk"},
	{text = "you can walk"},
	{text = "you look tired"},
	{text = "have you been walking for a long time"},
	{text = "if I could walk, I would never get tired"},
	{text = "I would walk forever"},
	{text = "and visit all my friends"},
	{text = "wait!"},
	{text = "if you are tired you should visit my friend up there"},
	{text = "they have a house where you can rest"},
	{text = "tell them I said hi!!!"},
}
regulus_dialogue.dialogues["npc5_idle2"] = {
	{text = "hi!!!"},
}