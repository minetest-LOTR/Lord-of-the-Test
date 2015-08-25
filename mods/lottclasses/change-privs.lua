--Change old race privs to new GAME privs

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local privs = minetest.get_player_privs(name)
    if minetest.check_player_privs(name, {male = true, dwarf = true}) then
        privs.male, privs.dwarf = nil
        privs.GAMEdwarf, privs.GAMEmale = true, true
        minetest.set_player_privs(name, privs)
    elseif minetest.check_player_privs(name, {male = true, elf = true}) then
        privs.male, privs.elf = nil
        privs.GAMEelf, privs.GAMEmale = true, true
        minetest.set_player_privs(name, privs)
    elseif minetest.check_player_privs(name, {male = true, man = true}) then
        privs.male, privs.man = nil
        privs.GAMEman, privs.GAMEmale = true, true
        minetest.set_player_privs(name, privs)
    elseif minetest.check_player_privs(name, {male = true, orc = true}) then
        privs.male, privs.orc = nil
        privs.GAMEorc, privs.GAMEmale = true, true
        minetest.set_player_privs(name, privs)
    elseif minetest.check_player_privs(name, {male = true, hobbit = true}) then
        privs.male, privs.hobbit = nil
        privs.GAMEhobbit, privs.GAMEmale = true, true
        minetest.set_player_privs(name, privs)
    elseif minetest.check_player_privs(name, {female = true, dwarf = true}) then
        privs.female, privs.dwarf = nil
        privs.GAMEdwarf, privs.GAMEfemale = true, true
        minetest.set_player_privs(name, privs)
    elseif minetest.check_player_privs(name, {female = true, elf = true}) then
        privs.female, privs.elf = nil
        privs.GAMEelf, privs.GAMEfemale = true, true
        minetest.set_player_privs(name, privs)
    elseif minetest.check_player_privs(name, {female = true, man = true}) then
        privs.female, privs.man = nil
        privs.GAMEman, privs.GAMEfemale = true, true
        minetest.set_player_privs(name, privs)
    elseif minetest.check_player_privs(name, {female = true, orc = true}) then
        privs.female, privs.orc = nil
        privs.GAMEorc, privs.GAMEfemale = true, true
        minetest.set_player_privs(name, privs)
    elseif minetest.check_player_privs(name, {female = true, hobbit = true}) then
        privs.female, privs.hobbit = nil
        privs.GAMEhobbit, privs.GAMEfemale = true, true
        minetest.set_player_privs(name, privs)
    end
end)
