local invisibility = invisibility or {}
local damage_enabled = minetest.setting_getbool("enable_damage")

local get_distance = function(a, b)

	local x, y, z = a.x - b.x, a.y - b.y, a.z - b.z

	return math.sqrt(x * x + y * y + z * z)
end

local split = function(str, sep)
        local fields = {}
        local str = str or ""
        local sep = sep or ";"
        for word in string.gmatch(str, '([^'..sep..']+)') do
                fields[#fields + 1] = word
        end
        return fields
end

local value_in_table = function(tab, val)
        for index, value in ipairs(tab) do
                if value == val then
                        return true
                end
        end
        return false
end

local guard_attack_evil = function(guard)
        if not damage_enabled or guard.state == "attack" or day_docile(guard) then
                return
        end
        local player, entity_type, obj, min_player, npc_race = nil, nil, nil, nil, nil
        local min_dist = guard.view_range + 1
        local objs = minetest.get_objects_inside_radius(guard.object:getpos(), guard.view_range)
        for n = 1, #objs do
                if invisibility[ objs[n]:get_player_name() ] then
                        entity_type = ""
                elseif objs[n]:is_player() then
                        player = objs[n]
                        entity_type = "player"
                else
                        obj = objs[n]:get_luaentity()
                        if obj then
                                player = obj.object
                                entity_type = obj.type
                                npc_race = obj.race
                        end
                end
                
                if entity_type == "player" or entity_type == "npc" then
                        
                        s = guard.object:getpos()
                        p = player:getpos()
                        sp = s
                        
                        -- aim higher to make looking up hills more realistic
                        p.y = p.y + 1
                        sp.y = sp.y + 1
                        
                        dist = get_distance(p, s)
                        
                        if dist < guard.view_range then
                                
                                -- choose closest player to attack
                                if line_of_sight_water(guard, sp, p, 2) == true
                                and dist < min_dist then
                                        if (entity_type == "player" and player:get_player_name() ~= guard.owner) then
                                                min_dist = dist
                                                min_player = player
                                        else
                                                min_dist = dist
                                                min_player = player
                                        end
                                end
                        end
                end
        end
        
        -- attack player
        if min_player then
                if entity_type == "player" and guard.whitelist
                and not value_in_table(guard.whitelist, min_player:get_player_name()) then
                        local is_elf = minetest.check_player_privs(min_player, "GAMEelf")
                        local is_man = minetest.check_player_privs(min_player, "GAMEman")
                        local is_orc = minetest.check_player_privs(min_player, "GAMEorc")
                        local is_hobbit = minetest.check_player_privs(min_player, "GAMEhobbit")
                        local is_dwarf = minetest.check_player_privs(min_player, "GAMEdwarf")
                        if (guard.attack_elves and is_elf)
                                or (guard.attack_men and is_man)
                                or (guard.attack_orcs and is_orc)
                                or (guard.attack_hobbits and is_hobbit)
                                or (guard.attack_dwarves and is_dwarf)
                                or (guard.blacklist
                                and value_in_table(guard.blacklist, min_player:get_player_name())) then
                                        do_attack(guard, min_player)
                        end
                elseif entity_type == "npc" then
                        if (guard.attack_men and npc_race == "men")
                        or (guard.attack_hobbits and npc_race == "hobbits")
                        or (guard.attack_dwarves and npc_race == "dwarves")
                        or (guard.attack_elves and npc_race == "elves") then
                                do_attack(guard, min_player)
                        end
                end
        end
end

local monster_attack = function(self)

	if not damage_enabled
	or self.state == "attack"
	or day_docile(self) then
		return
	end
	local s = self.object:getpos()
	local p, sp, dist
	local player, type, obj, min_player = nil, nil, nil, nil
	local min_dist = self.view_range + 1
	local objs = minetest.get_objects_inside_radius(s, self.view_range)

	for n = 1, #objs do

		if objs[n]:is_player() then

			if invisibility[ objs[n]:get_player_name() ] or minetest.check_player_privs(objs[n], "GAMEorc") then
				type = ""
			else
				player = objs[n]
				type = "player"
			end
		else
			obj = objs[n]:get_luaentity()

			if obj then
				player = obj.object
				type = obj.type
			end
		end

		if type == "player"
		or type == "npc" then

			s = self.object:getpos()
			p = player:getpos()
			sp = s

			-- aim higher to make looking up hills more realistic
			p.y = p.y + 1
			sp.y = sp.y + 1

                        dist = get_distance(p, s)                       

			if dist < self.view_range then
			-- field of view check goes here

				-- choose closest player to attack
				if line_of_sight_water(self, sp, p, 2) == true
				and dist < min_dist then
					min_dist = dist
					min_player = player
				end
			end
		end
	end

	-- attack player
	if min_player then
		do_attack(self, min_player)
        end
end

lottmobs.do_custom_guard_evil = function(guard, dtime)
	-- attack timer
	guard.timer = guard.timer + dtime

	if guard.state ~= "attack" then

		if guard.timer < 1 then
			return false
		end

		guard.timer = 0
	end

	-- never go over 100
	if guard.timer > 100 then
		guard.timer = 1
	end

	-- node replace check (cow eats grass etc.)
        local pos = guard.object:getpos()
	replace(guard, pos)

	-- mob plays random sound at times
	if guard.sounds.random
	and random(1, 100) == 1 then

		minetest.sound_play(guard.sounds.random, {
			object = guard.object,
			max_hear_distance = guard.sounds.distance
		})
	end

	-- environmental damage timer (every 1 second)
	guard.env_damage_timer = guard.env_damage_timer + dtime

	if (guard.state == "attack" and guard.env_damage_timer > 1)
	or guard.state ~= "attack" then

		guard.env_damage_timer = 0

		do_env_damage(guard)
	end
	if guard.owner and guard.owner ~= "" then
                guard_attack_evil(guard)
        else
                monster_attack(guard)
	end
        
	mobs.follow_flop(guard)
	mobs.do_states(guard, dtime)
        
        return false
end

lottmobs.do_custom_guard = function(guard, dtime)
        if not damage_enabled or guard.state == "attack" then
                return
        end
        local player, entity_type, obj, min_player = nil, nil, nil, nil
        local min_dist = guard.view_range + 1
        local objs = minetest.get_objects_inside_radius(guard.object:getpos(), guard.view_range)
        for n = 1, #objs do
                if invisibility[ objs[n]:get_player_name() ] then
                        entity_type = ""
                elseif objs[n]:is_player() then
                        player = objs[n]
                        entity_type = "player"
                end

                if entity_type == "player" then

                        s = guard.object:getpos()
                        p = player:getpos()
                        sp = s

                        -- aim higher to make looking up hills more realistic
                        p.y = p.y + 1
                        sp.y = sp.y + 1

                        dist = get_distance(p, s)

                        if dist < guard.view_range then

                                -- choose closest player to attack
                                if line_of_sight_water(guard, sp, p, 2) == true
					and dist < min_dist
                                and player:get_player_name() ~= guard.owner then
                                        min_dist = dist
                                        min_player = player
                                end
                        end
                end
                
                -- attack player
                if guard.owner and guard.owner ~= "" then
                        if min_player and guard.whitelist
                        and not value_in_table(guard.whitelist, min_player:get_player_name()) then
                                local is_elf = minetest.check_player_privs(min_player, "GAMEelf")
                                local is_man = minetest.check_player_privs(min_player, "GAMEman")
                                local is_orc = minetest.check_player_privs(min_player, "GAMEorc")
                                local is_hobbit = minetest.check_player_privs(min_player, "GAMEhobbit")
                                local is_dwarf = minetest.check_player_privs(min_player, "GAMEdwarf")
                                if (guard.attack_elves and is_elf)
                                        or (guard.attack_men and is_man)
                                        or (guard.attack_orcs and is_orc)
                                        or (guard.attack_hobbits and is_hobbit)
                                        or (guard.attack_dwarves and is_dwarf)
                                        or (guard.blacklist
                                            and value_in_table(guard.blacklist, min_player:get_player_name())) then
                                                do_attack(guard, min_player)
                                end
                        end
                else
                        if min_player
                        and minetest.check_player_privs(min_player, "GAMEorc")
                        and not minetest.check_player_privs(min_player, "GAMEwizard") then
                                do_attack(guard, min_player)
                        end
                end
	end
end

local attacks = {
	"attack_monsters",
	"attack_elves",
	"attack_men",
	"attack_orcs",
	"attack_hobbits",
	"attack_dwarves"
}

local get_guard_formspec = function(self)
        local selected_idx = 1
	if self.whitelist == nil then
		self.whitelist = {}
	end
	if self.blacklist == nil then
		self.blacklist = {}
	end
        local extra = nil
        if self.type == "monster" then
                extra = ""
        else
                extra = "checkbox[4,4;attack_orcs;Attack Orcs;"..tostring(self.attack_orcs).."]"..
                        "checkbox[7,2;attack_monsters;Attack Monsters;"..tostring(self.attack_monsters).."]"
        end
        
        if self.order == "stand" then selected_idx = 2 end
        return "size[10,9]"..
                "label[1,1;Name:\t"..self.game_name.."]"..
                "dropdown[1,2;2;order;follow,stand;"..selected_idx.."]"..
                "checkbox[1,3;attack_elves;Attack Elves;"..tostring(self.attack_elves).."]"..
                "checkbox[1,4;attack_men;Attack Men;"..tostring(self.attack_men).."]"..
                "checkbox[4,2;attack_hobbits;Attack Hobbits;"..tostring(self.attack_hobbits).."]"..
                "checkbox[4,3;attack_dwarves;Attack Dwarves;"..tostring(self.attack_dwarves).."]"..
                extra..
                "field[1,6;9,1;whitelist;Whitelist;"..
		minetest.formspec_escape(table.concat(self.whitelist, ";")).."]"..
                "field[1,7;9,1;blacklist;Blacklist;"..
		minetest.formspec_escape(table.concat(self.blacklist, ";")).."]"..
                "button_exit[1,8;2,1;exit_button; Proceed]"
end

local guard_can_be_hired = function(guard, clicker)
        if guard.type == "npc" and (not minetest.check_player_privs(clicker, "GAMEorc") or minetest.check_player_privs(clicker, "GAMEwizard")) then
                return true
        elseif guard.type == "monster" and minetest.check_player_privs(clicker, "GAMEorc") then
                return true
        else
                return false
        end
end

lottmobs.guard = function(self, clicker, payment, mob_name, race)
        lottmobs.change_settings = function(fields)
                if fields.order then
                        self.order = fields.order
                end
                for i, v in pairs(attacks) do
                        if fields[v] == "true" then
				self[v] = true
                        elseif fields[v] == "false" then
				self[v] = nil
                        end
                end
                if fields.whitelist then
                        self.whitelist = split(fields.whitelist, ";")
                end
                if fields.blacklist then
                        self.blacklist = split(fields.blacklist, ";")
                end
	end
	local item = clicker:get_wielded_item()
	local name = clicker:get_player_name()
	if item:get_name() == "lottfarming:corn"
	or item:get_name() == "farming:bread" then
		local hp = self.object:get_hp()
		if hp >= self.hp_max then
			minetest.chat_send_player(name, "NPC at full health.")
			return
		end
		hp = hp + 4
		if hp > self.hp_max then hp = self.hp_max end
		self.object:set_hp(hp)
		if not minetest.setting_getbool("creative_mode") then
			item:take_item()
			clicker:set_wielded_item(item)
		end
	elseif item:get_name() == payment and self.tamed == false and guard_can_be_hired(self, clicker) then
		lottmobs.face_pos(self, clicker:getpos())
		self.state = "stand"
		minetest.show_formspec(name, "mob_hiring", lottmobs.hiring)
		lottmobs.hire = function(cost)
			if math.random(1, (50/cost)) == 1 then
				minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> Okay, I'll work for you.")
				local count = item:get_count()
				if count > cost or minetest.setting_getbool("creative_mode") then
					if not minetest.setting_getbool("creative_mode") then
						item:take_item(cost)
						clicker:set_wielded_item(item)
					end
					self.tamed = true
					if not self.owner or self.owner == "" then
						self.owner = clicker:get_player_name()
					end
					self.order = "follow"
					self.attack_monsters = true
					minetest.after(1, function()
						minetest.show_formspec(name, "mob_naming", "field[naming;Name your guard:;]")
					end)
				else
					minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> What, you don't have that much money?! Stop wasting my time!")
				end
			else
				local rand = math.random(1, 5)
				if rand == 1 then
					minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> Stop bothering me!")
					self.object:remove()
				elseif rand == 2 then
					minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> Are you mocking me? I don't take kindly to mockers!")
					do_attack(self, clicker)
				elseif rand == 3 then
					minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> You're joking, right? Oh, you're serious? Well, to let you know, I won't be working for you for that pitiful amount.")
				else
					minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> Do you really think I'll work for you for that much?!")
				end
			end
		end
		lottmobs.name = function(name)
			self.game_name = name
			self.nametag = name
			update_tag(self)
		end
	elseif self.owner and self.owner == name then
		minetest.show_formspec(name, "mob_settings", get_guard_formspec(self))
	else
		if self.game_name == "mob" then
			self.game_name = lottmobs[race]["names"][math.random(1, #lottmobs[race]["names"])]
		end
		minetest.chat_send_player(name, "[NPC] <" .. self.game_name .. "> " ..
			lottmobs[race]["messages"][math.random(1, #lottmobs[race]["messages"])])
	end
end

lottmobs.hiring = "size[6,3]" ..
	"label[0,0;Select the amount of gold you want to offer:]" ..
	"dropdown[2,1;2;offer;1,5,10,15,20,25,30,35,40,45,50;1]" ..
	"button_exit[2.25,2;1.5,1;done;Done]"

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "mob_hiring" then
		if fields.done then
			if tonumber(fields.offer) then
				local n = tonumber(fields.offer)
				if n > 50 then
					n = 50
				end
				lottmobs.hire(n)
			else
				minetest.chat_send_player(player:get_player_name(), "Offer must be a number!")
			end
		end
	elseif formname == "mob_naming" then
		lottmobs.name(fields.naming)
	elseif formname == "mob_settings" then
		lottmobs.change_settings(fields)
	end
end)
