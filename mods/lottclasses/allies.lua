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

lottclasses.same_race_or_ally = function(self, other)
        local is_race, player_race = nil, nil
        if other:is_player() then
                for i = 1, 5, 1 do
                        is_race = minetest.check_player_privs(other, lottclasses.player_races[i])
                        player_race = nil
                        if is_race then
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
