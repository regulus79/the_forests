
regulus_npcs = {}

regulus_npcs.npcs = {}

dofile(core.get_modpath("regulus_npcs") .. "/npcs.lua")



-- Dialogue info icon hover thing
core.register_entity("regulus_npcs:info", {
	initial_properties = {
		visual = "sprite",
		physical = false,
		collide_with_objects = false,
		pointable = false,
		visual_size = vector.new(1,1,1),
		textures = {"regulus_npcs_info.png"},
		use_texture_alpha = true,
		static_save = false,
	},
})





for name, npcdef in pairs(regulus_npcs.npcs) do
	core.register_entity("regulus_npcs:" .. name, {
		initial_properties = {
			visual = "upright_sprite",
			physical = true,
			collide_with_objects = true,
			collisionbox = {-0.3, -1, -0.3, 0.3, 0.8, 0.3},
			selectionbox = {-0.3, -1, -0.3, 0.3, 0.8, 0.3},
			pointable = true,
			visual_size = vector.new(2,2,2),
			textures = npcdef.textures or {
				"regulus_npcs_" .. name .. "_front.png", "regulus_npcs_" .. name .. "_back.png",
			},
			use_texture_alpha = true,
		},

		_notice_distance = npcdef._notice_distance or 5,
		_turn_on_rightclick = npcdef._turn_on_rightclick or true,
		_notice_prob = npcdef._notice_prob or 0.5,

		-- Return the dialogue id, along with true/false whether to have the info icon above
		get_next_dialogue = npcdef.get_next_dialogue or function(self, player) return nil, false end,

		on_activate = function(self)
			if #self.object:get_children() == 0 then
				core.debug("no kids")
				local infoicon = core.add_entity(self.object:get_pos() + vector.new(0, 4, 0), "regulus_npcs:info")
				infoicon:set_attach(self.object, nil, vector.new(0, 15, 0))
			end
		end,
		on_deactivate = function(self)
			for _, child in pairs(self.object:get_children()) do
				child:remove()
			end
		end,

		on_step = function(self, dtime)
			-- Every second or so, turn to look at the player if they are nearby
			-- (1-r)*(1-r)*(1-r)*(1-r)*(1-r) ... 1/dtime many times = prob that it doesn't happen in 1 sec = 1 - prob it happens in 1 sec
			-- (1-r)^(1/dtime) = 1 - prob
			-- 1-r = (1-prob)^(dtime)
			-- r = 1 - (1-prob)^(dtime)
			local probPerSec = self._notice_prob
			local frameProb = 1 - (1 - probPerSec) ^ dtime
			if math.random() < frameProb then
				for _, player in pairs(core.get_connected_players()) do
					if self.object:get_pos():distance(player:get_pos()) < self._notice_distance then
						self.object:set_yaw(vector.dir_to_rotation(player:get_pos() - self.object:get_pos()).y)
					end
				end
			end
			-- If there is important dialogue ready, show the info icon
			local info_icon_visible = false
			for _, player in pairs(core.get_connected_players()) do
				local next_dialogue_id, show_info_icon = self.get_next_dialogue(self, player)
				info_icon_visible = info_icon_visible or show_info_icon
			end
			local infoicon = self.object:get_children()[1]
			local props = infoicon:get_properties()
			props.is_visible = info_icon_visible
			infoicon:set_properties(props)
		end,
		on_rightclick = function(self, clicker)
			-- Look at player
			if self._turn_on_rightclick then
				self.object:set_yaw(vector.dir_to_rotation(clicker:get_pos() - self.object:get_pos()).y)
			end
			-- If there is dialogue available, run it
			-- on_step will handle the info icon
			local next_dialogue_id, show_info_icon = self.get_next_dialogue(self, clicker)
			if next_dialogue_id then
				regulus_dialogue.start_dialogue(clicker, next_dialogue_id)
			end
			-- Call custom on_rightclick callback
			if npcdef.on_rightclick then
				npcdef.on_rightclick(self, clicker)
			end
		end,
	})
	core.register_node("regulus_npcs:spawner_" .. name, {
		description = "Spawner for " .. name,
		drawtype = "airlike",
	})
	core.register_abm({
		label = "Spawn " .. name,
		nodenames = {"regulus_npcs:spawner_" .. name},
		interval = 1,
		chance = 1,
		action = function(pos)
			core.add_entity(pos + vector.new(0, 0.5, 0), "regulus_npcs:" .. name)
			core.set_node(pos, {name = "air"})
		end
	})
end

