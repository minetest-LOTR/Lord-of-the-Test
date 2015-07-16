--Do not allow players to have all privs.
--They may however, have fast, fly, and noclip.

local cheater_on_join = "size[4,4.5]" ..
"button_exit[0,0;2,0.5;dwarf;Dwarf]" ..
"button_exit[2,0;2,0.5;elf;Elf]" ..
"button_exit[0,1;2,0.5;man;Man]" ..
"button_exit[2,1;2,0.5;orc;Orc]" ..
"button_exit[1,2;2,0.5;hobbit;Hobbit]" ..
"dropdown[1,2.85;2;gender;Male,Female;1]"

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    if minetest.check_player_privs(name, {male = true, female = true})
    or minetest.check_player_privs(name, {dwarf = true, elf = true})
    or minetest.check_player_privs(name, {dwarf = true, man = true})
    or minetest.check_player_privs(name, {dwarf = true, orc = true})
    or minetest.check_player_privs(name, {dwarf = true, hobbit = true})
    or minetest.check_player_privs(name, {elf = true, man = true})
    or minetest.check_player_privs(name, {elf = true, orc = true})
    or minetest.check_player_privs(name, {elf = true, hobbit = true})
    or minetest.check_player_privs(name, {man = true, orc = true})
    or minetest.check_player_privs(name, {man = true, hobbit = true})
    or minetest.check_player_privs(name, {orc = true, hobbit = true})
    or minetest.check_player_privs(name, {cra=true}) then
        minetest.after(1, function()
            minetest.chat_send_player(name, "Sorry, you were detected with all privs. For your benefit, they have been removed, and you must choose your race again. (You won't get the stuff again!)")
            minetest.set_player_privs(name, {interact=true,shout=true,cra=true})
            if minetest.is_singleplayer() then
                minetest.show_formspec(name, "cheater-race-selection", cheater_on_join ..
                    "button[0,4;4,0.5;fast_fly_noclip;Fast, Fly & Noclip?]")
            else
                minetest.show_formspec(name, "cheater-race-selection", cheater_on_join)
            end
        end)
    end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cheater-race-selection" then return end
	local name = player:get_player_name()
    local privs = minetest.get_player_privs(name)
    if fields.gender == "Male" then
        if fields.dwarf then
            privs.dwarf, privs.male, privs.cra = true, true, false
            minetest.set_player_privs(name, privs)
			armor.textures[name].skin = "dwarf_skin.png"
            return
        elseif fields.elf then
            privs.elf, privs.male, privs.cra = true, true, false
            minetest.set_player_privs(name, privs)
			armor.textures[name].skin = "elf_skin.png"
            return
        elseif fields.man then
            privs.man, privs.male, privs.cra = true, true, false
            minetest.set_player_privs(name, privs)
            armor.textures[name].skin = "man_skin.png"
            return
        elseif fields.orc then
            privs.orc, privs.male, privs.cra = true, true, false
            minetest.set_player_privs(name, privs)
            armor.textures[name].skin = "orc_skin.png"
            return
        elseif fields.hobbit then
            privs.hobbit, privs.male, privs.cra = true, true, false
            minetest.set_player_privs(name, privs)
            armor.textures[name].skin = "hobbit_skin.png"
            return
        end
    elseif fields.gender == "Female" then
        if fields.dwarf then
            privs.dwarf, privs.female, privs.cra = true, true, false
            minetest.set_player_privs(name, privs)
            armor.textures[name].skin = "dwarf_skinf.png"
            return
        elseif fields.elf then
            privs.elf, privs.female, privs.cra = true, true, false
            minetest.set_player_privs(name, privs)
            armor.textures[name].skin = "elf_skinf.png"
            return
        elseif fields.man then
            privs.man, privs.female, privs.cra = true, true, false
            minetest.set_player_privs(name, privs)
            armor.textures[name].skin = "man_skinf.png"
            return
        elseif fields.orc then
            privs.orc, privs.female, privs.cra = true, true, false
            minetest.set_player_privs(name, privs)
            armor.textures[name].skin = "orc_skin.png"
            return
        elseif fields.hobbit then
            privs.hobbit, privs.female, privs.cra = true, true, false
            minetest.set_player_privs(name, privs)
            armor.textures[name].skin = "hobbit_skin.png"
            return
        end
    end
    if fields.fast_fly_noclip then
        privs.fly, privs.fast, privs.noclip = true, true, true
        minetest.set_player_privs(name, privs)
        return
    end
end)
