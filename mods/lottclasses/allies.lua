lottclasses.allies = {
        elves = {
                men = true,
                orcs = false,
                hobbits = true,
                dwarves = true
        },
        men = {
                elves = true,
                orcs = false,
                hobbits = true,
                dwarves = true
        },
        orcs = {
                elves = false,
                men = false,
                hobbits = false,
                dwarves = false
        },
        hobbits = {
                elves = true,
                men = true,
                orcs = false,
                dwarves = true
        },
        dwarves = {
                elves = true,
                men = true,
                orcs = false,
                hobbits = true
        }
}

lottclasses.races = {
	"elves",
	"men",
	"orcs",
	"hobbits",
	"dwarves"
}

lottclasses.player_races = {
        "GAMEelf",
        "GAMEman",
        "GAMEorc",
        "GAMEhobbit",
        "GAMEdwarf"
}

lottclasses.races_pretty = {
        "Elven",
        "Human",
        "Orc",
        "Hobbit",
        "Dwarven"
}

lottclasses.same_race_or_ally = function(self, other)
        local is_race, player_race = nil, nil
        if other:is_player() then
                local player_privs = minetest.get_player_privs(other)
                for i = 1, 5, 1 do
                        player_race = nil
                        if player_privs[lottclasses.player_races[i]] then
                                player_race = lottclasses.races[i]
                        end
                        if player_race == self.race or lottclasses.allies[self.race][player_race] then
                                return true
                        end
                end
        else
                local lua_ent = other:get_luaentity()
                if lua_ent.type == "npc" and (self.race == lua_ent.race or lottclasses.allies[self.race][lua_ent.race]) then
                        return true
                end
        end

        return false
end

local file = io.open(minetest.get_worldpath().."/allies.txt", "r")
if file then
	lottclasses.allies = minetest.deserialize(file:read("*all"))
	file:close()
end

minetest.register_privilege("allies", {
                description = "Can change the allies",
})

minetest.register_chatcommand("allies", {
	params = "",
	description = "Change Allies",
	func = function(name, param)
		lottclasses.show_allies_formspec(name)
	end,
})

lottclasses.show_allies_formspec = function(player)
        local x, y = nil
        local player_privs = minetest.get_player_privs(player)
        if not player_privs.allies then return end
        local formspec = "size[8,12]label[0,0;Allies:]"
        y = 1
        for i = 1, 5, 1 do
                if player_privs.server or player_privs[lottclasses.player_races[i]] then
                        formspec = formspec.."label[0,"..y..";"..lottclasses.races[i]..":]"
                        x = 0
                        for j = 1, 5, 1 do
                                if lottclasses.races[i] ~= lottclasses.races[j] then
                                        formspec = formspec..
                                                "checkbox["..x..","..(y + 1)..";"..lottclasses.races[i].."_"..
                                                lottclasses.races[j]..";"..lottclasses.races[j]..";"..
                                                tostring(lottclasses.allies[lottclasses.races[i]][lottclasses.races[j]]).."]"
                                        x = x + 2
                                end
                        end
                        y = y + 2
                end
        end
        formspec = formspec.."button_exit[0,11;2,1;exit_button;Proceed]"

        minetest.show_formspec(player, "ally_settings", formspec)
end

lottclasses.change_ally_settings = function(fields)
        local race1, race2, field_name = nil, nil, nil
        for i = 1, 5, 1 do
                for j = 1, 5, 1 do
                        race1 = lottclasses.races[i]
                        race2 = lottclasses.races[j]
                        field_name = race1.."_"..race2
                        if fields[field_name] == "true" then
                                lottclasses.allies[race1][race2] = true
                        elseif fields[field_name] == "false" then
                                lottclasses.allies[race1][race2] = false
                        end
                end
        end
        lottclasses.save_allies()
end

minetest.register_on_player_receive_fields(
        function(player, formname, fields)
                if formname == "ally_settings" then
                        lottclasses.change_ally_settings(fields)
                end
        end
)

lottclasses.save_allies = function()
	local file = io.open(minetest.get_worldpath().."/allies.txt", "w")
	if (file) then
		file:write(minetest.serialize(lottclasses.allies))
		file:close()
	end
end
