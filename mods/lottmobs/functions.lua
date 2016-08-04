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

lottmobs.do_custom_guard = function(guard)
	if guard.owner and guard.owner ~= "" then
		local player, entity_type, obj, min_player = nil, nil, nil, nil
		local min_dist = guard.view_range + 1
		local objs = minetest.get_objects_inside_radius(guard.object:getpos(), guard.view_range)
		for n = 1, #objs do

			if objs[n]:is_player() then
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

				local x, y, z = p.x - s.x, p.y - s.y, p.z - s.z
				dist = math.sqrt(x * x + y * y + z * z)

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
		end

	                -- attack player
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
	            guard.state = "attack"
	            guard.attack = min_player
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
    if order == "stand" then selected_idx = 2 end
    return "size[10,9]"..
        "label[1,1;Name:\t"..self.game_name.."]"..
        "dropdown[1,2;2;order;follow,stand;"..selected_idx.."]"..
        "checkbox[1,3;attack_elves;Attack Elves;"..tostring(self.attack_elves).."]"..
        "checkbox[1,4;attack_men;Attack Men;"..tostring(self.attack_men).."]"..
        "checkbox[4,2;attack_orcs;Attack Orcs;"..tostring(self.attack_orcs).."]"..
        "checkbox[4,3;attack_hobbits;Attack Hobbits;"..tostring(self.attack_hobbits).."]"..
        "checkbox[4,4;attack_dwarves;Attack Dwarves;"..tostring(self.attack_dwarves).."]"..
        "checkbox[7,2;attack_monsters;Attack Monsters;"..tostring(self.attack_monsters).."]"..
        "field[1,6;9,1;whitelist;Whitelist;"..
		minetest.formspec_escape(table.concat(self.whitelist, ";")).."]"..
        "field[1,7;9,1;blacklist;Blacklist;"..
		minetest.formspec_escape(table.concat(self.blacklist, ";")).."]"..
        "button_exit[1,8;2,1;exit_button; Proceed]"
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
	elseif item:get_name() == payment and self.tamed == false then
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
					self.state = "attack"
					self.attack = clicker
				elseif rand == 3 then
					minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> Your joking, right? Oh, you're serious? Well, to let you know, I won't be working for you for that pitiful amount.")
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
