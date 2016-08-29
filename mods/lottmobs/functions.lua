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

local npc_guard_attack = function(self)
        if not damage_enabled or self.state == "attack" then
                return
        end
        local player, entity_type, obj, min_player, npc_race = nil, nil, nil, nil, nil
        local min_dist = self.view_range + 1
        local objs = minetest.get_objects_inside_radius(self.object:getpos(), self.view_range)
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
                
                if entity_type == "player" or entity_type == "npc" or entity_type == "monster" then
                        
                        s = self.object:getpos()
                        p = player:getpos()
                        sp = s
                        
                        -- aim higher to make looking up hills more realistic
                        p.y = p.y + 1
                        sp.y = sp.y + 1
                        
                        dist = get_distance(p, s)
                        
                        if dist < self.view_range then
                                
                                -- choose closest player to attack
                                if line_of_sight_water(self, sp, p, 2) == true
                                and dist < min_dist then
                                        if entity_type == "player"
                                        and player:get_player_name() ~= self.owner
                                        and self.whitelist
                                        and not value_in_table(self.whitelist, player:get_player_name()) then
                                                local player_privs = minetest.get_player_privs(player:get_player_name())
                                                if (self.attack_player_GAMEelf and player_privs.GAMEelf)
                                                or (self.attack_player_GAMEman and player_privs.GAMEman)
                                                or (self.attack_player_GAMEorc and player_privs.GAMEorc)
                                                or (self.attack_player_GAMEhobbit and player_privs.GAMEhobbit)
                                                or (self.attack_player_GAMEdwarf and player_privs.GAMEdwarf)
                                                or (self.blacklist
                                                and value_in_table(self.blacklist, player:get_player_name())) then
                                                            min_dist = dist
                                                            min_player = player
                                                end
                                        elseif entity_type == "npc" and npc_race ~= "ents" and self.race ~= npc_race then
                                                if (self["attack_npc_"..npc_race]) then
                                                        min_dist = dist
                                                        min_player = player
                                                end
                                        elseif entity_type == "monster" and self.attacks_monsters then
                                                min_dist = dist
                                                min_player = player
                                        end
                                end
                        end
                end
        end
        
        -- attack player
        if min_player then
                do_attack(self, min_player)
        end
end

local npc_attack = function(self)

	if self.type ~= "npc"
        or not damage_enabled
	or self.state == "attack" then
		return
	end
        local player, entity_type, obj, min_player, npc_race = nil, nil, nil, nil, nil
        local min_dist = self.view_range + 1
        local objs = minetest.get_objects_inside_radius(self.object:getpos(), self.view_range)
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

                if entity_type == "player" or entity_type == "npc" or entity_type == "monster" then

                        s = self.object:getpos()
                        p = player:getpos()
                        sp = s

                        -- aim higher to make looking up hills more realistic
                        p.y = p.y + 1
                        sp.y = sp.y + 1

                        dist = get_distance(p, s)

                        if dist < self.view_range then

                                -- choose closest player to attack
                                if line_of_sight_water(self, sp, p, 2) == true
                                and dist < min_dist then
                                        if entity_type == "player" then
                                                if not lottclasses.player_same_race_or_ally(player, self.race) then
                                                        min_dist = dist
                                                        min_player = player
                                                end
                                        elseif entity_type == "npc" then
                                                if npc_race ~= "ents" and npc_race ~= self.race and not lottclasses.allies[self.race][npc_race] then
                                                        min_dist = dist
                                                        min_player = player
                                                end
                                        elseif entity_type == "monster" and self.attacks_monsters then
                                                min_dist = dist
                                                min_player = player
                                        end
                                end
                        end
                end
        end
        if min_player then
                do_attack(self, min_player)
        end        
end

local guard_foods = {
        ["lottfarming:corn"] = 5,
        ["farming:bread"] = 10
}

lottmobs.save_guard_hunger = function()
        minetest.mkdir(minetest.get_worldpath().."/"..SAVEDIR)
	local file = io.open(minetest.get_worldpath().."/"..SAVEDIR.."/guard_hunger.txt", "w")
	if file then
		file:write(minetest.serialize(lottmobs.player_guards))
		file:close()
	end        
end

lottmobs.do_guard_hunger = function(dtime)
        for player, bool in pairs(lottmobs.connected_player_names) do
                if lottmobs.player_guards[player] then
                        for name, hunger_def in pairs(lottmobs.player_guards[player]) do
                                lottmobs.guard_eat(hunger_def, player, name, dtime)
                        end
                end
        end
end

lottmobs.guard_eat_active = function(self)
        if lottmobs.player_guards[self.owner] then
                local hunger_def = lottmobs.player_guards[self.owner][self.game_name]
                if hunger_def then
                        self.health = self.health + (hunger_def.health - hunger_def.last_active_health)
                        hunger_def.last_active_health = self.health
                        hunger_def.health = self.health
                        self.object:set_hp(self.health)
                        return
                end
        end
        self.health = 0
        self.object:set_hp(self.health)
end

lottmobs.guard_eat = function(self, owner, name, dtime)
        if self.health <= 0 then
                lottmobs.player_guards[owner][name] = nil
                lottmobs.save_guard_hunger()
        end
        self.eat_timer = self.eat_timer + dtime
        self.timer = self.timer + dtime
        if self.eat_timer >= 60 then
                self.food_level = self.food_level - 1
                self.eat_timer = 0
        end
        if self.food_level <= 0 and self.timer >= 1 then
                self.timer = 0
                local food_inv = minetest.get_inventory({type="player", name=owner})
                if food_inv then
                        for food, eat_value in pairs(guard_foods) do
                                local taken = food_inv:remove_item("bag4contents", ItemStack(food.." 1"))
                                self.food_level = self.food_level + taken:get_count() * eat_value
                                if self.food_level > 1 then
                                        break
                                end
                        end
                end
                if self.food_level <= 0 then
                        self.health = self.health - 1
                end
        end
end

lottmobs.do_custom_guard = function(self, dtime)
	-- attack timer
	self.timer = self.timer + dtime

	if self.state ~= "attack" then

		if self.timer < 1 then
			return false
		end

		self.timer = 0
	end

	-- never go over 100
	if self.timer > 100 then
		self.timer = 1
	end

	-- node replace check (cow eats grass etc.)
        local pos = self.object:getpos()
	replace(self, pos)

	-- mob plays random sound at times
	if self.sounds.random
	and random(1, 100) == 1 then

		minetest.sound_play(self.sounds.random, {
			object = self.object,
			max_hear_distance = self.sounds.distance
		})
	end

	-- environmental damage timer (every 1 second)
	self.env_damage_timer = self.env_damage_timer + dtime

	if (self.state == "attack" and self.env_damage_timer > 1)
	or self.state ~= "attack" then

		self.env_damage_timer = 0

		do_env_damage(self)
	end
	if self.owner and self.owner ~= "" then
                lottmobs.guard_eat_active(self)
                npc_guard_attack(self)
        else
                npc_attack(self)
	end
        
	mobs.follow_flop(self)
	mobs.do_states(self, dtime)
        return false
end

local checkbox_pos = {
        "1,4",
        "4,4",
        "7,4",
        "1,5",
        "4,5",
        "7,5",
        "1,6",
        "4,6",
        "7,6"
}

local get_guard_formspec = function(self)
        local selected_idx = 1
	if self.whitelist == nil then
		self.whitelist = {}
	end
	if self.blacklist == nil then
		self.blacklist = {}
	end
        
        if self.order == "stand" then selected_idx = 2 end
        local formspec = "size[10,11]"..
                "label[1,1;Name:\t"..self.game_name.."]"..
                "dropdown[1,2;2;order;follow,stand;"..selected_idx.."]"..
                "label[1,3;Attack:]"
        local j = 1
        local attack_race = nil
        for i = 1, 5, 1 do
                if lottclasses.races[i] ~= self.race then
                        attack_race = self["attack_npc_"..lottclasses.races[i]]
                        if attack_race == nil then
                                attack_race = not lottclasses.allies[self.race][lottclasses.races[i]]
                                self["attack_npc_"..lottclasses.races[i]] = attack_race
                        end
                        formspec = formspec..
                                "checkbox["..checkbox_pos[j]..";attack_npc_"..lottclasses.races[i]..";"..
                                lottclasses.races_prefix[i].." NPCs;"..tostring(attack_race).."]"
                        j = j + 1
                end
        end
        for i = 1, 5, 1 do
                attack_race = self["attack_player_"..lottclasses.races[i]]
                if attack_race == nil then
                        attack_race = not lottclasses.allies[self.race][lottclasses.races[i]]
                        self["attack_player_"..lottclasses.races[i]] = attack_race
                end
                formspec = formspec..
                        "checkbox["..checkbox_pos[j]..";attack_player_"..lottclasses.races[i]..";"..
                        lottclasses.races_prefix[i].." Players;"..tostring(attack_race).."]"
                j = j + 1
        end
        formspec = formspec..
                "field[1,8;9,1;whitelist;Whitelist;"..
                minetest.formspec_escape(table.concat(self.whitelist, ";")).."]"..
                "field[1,9;9,1;blacklist;Blacklist;"..
                minetest.formspec_escape(table.concat(self.blacklist, ";")).."]"..
                "button_exit[1,10;2,1;exit_button; Proceed]"

        return formspec
end

lottmobs.get_hiring_formspec = function(price)
        local formspec = "size[6,3]" ..
                "label[0,0;Select the amount of gold you want to offer:]"..
                "dropdown[2,1;2;offer;1"
        for i = 5, price, 5 do
                formspec = formspec..","..i
        end
        formspec = formspec..";1]button_exit[2.25,2;1.5,1;done;Done]"
        return formspec
end

lottmobs.guard = function(self, clicker, payment, mob_name, race, price)
        lottmobs.change_settings = function(fields)
                if fields.order then
                        self.order = fields.order
                end
                for i, v in pairs(lottclasses.races) do
                        local attack_npc = "attack_npc_"..v
                        local attack_player = "attack_player_"..v
                        if fields[attack_npc] == "true" then
				self[attack_npc] = true
                        elseif fields[attack_npc] == "false" then
				self[attack_npc] = false
                        end
                        if fields[attack_player] == "true" then
                                self[attack_player] = true
                        elseif fields[attack_player] == "false" then
                                self[attack_player] = false
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
	elseif item:get_name() == payment and self.tamed == false and lottclasses.player_same_race_or_ally(clicker, self.race) then
		lottmobs.face_pos(self, clicker:getpos())
		self.state = "stand"
                if not price then price = 50 end
		minetest.show_formspec(name, "mob_hiring", lottmobs.get_hiring_formspec(price))
		lottmobs.hire = function(cost)
			if math.random(1, (price/cost)) == 1 then
				minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> Okay, I'll work for you.")
				local count = item:get_count()
				if count > cost or minetest.setting_getbool("creative_mode") then
					if not minetest.setting_getbool("creative_mode") then
						item:take_item(cost)
						clicker:set_wielded_item(item)
					end
                                        clicker:get_inventory():add_item("main", self.name)
                                        self.object:remove()
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
	elseif self.owner and self.owner == name then
                minetest.show_formspec(name, "mob_settings", get_guard_formspec(self))
	else
                if lottclasses.player_same_race_or_ally(clicker, self.race) then
                        if self.game_name == "mob" then
                                self.game_name = lottmobs[race]["names"][math.random(1, #lottmobs[race]["names"])]
                        end
                        minetest.chat_send_player(name, "[NPC] <" .. self.game_name .. "> " ..
                                                          lottmobs[race]["messages"][math.random(1, #lottmobs[race]["messages"])])
                end
	end
end

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

lottmobs.register_guard_craftitem = function(name, description, inventory_image)
        minetest.register_craftitem(name, {
                                            description = description,
                                            inventory_image = inventory_image,
                                            on_place = function(itemstack, placer, pointed_thing)
                                                    if pointed_thing.above then
                                                            local owner = placer:get_player_name()
                                                            local add_guard = function(game_name)
                                                                    local pos = pointed_thing.above
                                                                    pos.y = pos.y + 1
                                                                    if not minetest.setting_getbool("creative_mode") then
                                                                            itemstack:take_item()
                                                                    end
                                                                    local obj = minetest.env:add_entity(pos, name):get_luaentity()
                                                                    obj.game_name = game_name
                                                                    obj.nametag = game_name
                                                                    update_tag(obj)
                                                                    obj.tamed = true
                                                                    obj.owner = owner
                                                                    obj.order = "follow"
                                                                    obj.eat_timer = 0
                                                                    obj.food_level = 20
                                                                    if not lottmobs.player_guards[owner] then
                                                                            lottmobs.player_guards[owner] = {}
                                                                    end
                                                                    return obj
                                                            end
                                                            lottmobs.name = function(name)
                                                                    if name and name ~= "" and not lottmobs.player_guards[owner][name] then
                                                                            local obj = add_guard(name)
                                                                            lottmobs.player_guards[owner][name] = {food_level = 20, health = obj.health, eat_timer = 0, timer = 0, last_active_health = obj.health}
                                                                            lottmobs.save_guard_hunger()
                                                                    else
                                                                            minetest.show_formspec(owner, "mob_naming", "field[naming;Name your guard:;")
                                                                    end
                                                            end
                                                            minetest.show_formspec(owner, "mob_naming", "field[naming;Name your guard:;")
                                                    end
                                                    return itemstack
                                            end
        })
end
