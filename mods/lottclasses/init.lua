minetest.register_privilege("GAMEmale", {
	description = "A male player",
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEfemale", {
	description = "A female player",
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEdwarf", {
	description = "A dwarf player",
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEelf", {
	description = "An elf player",
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEman", {
	description = "A human player",
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEorc", {
	description = "An orc player",
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEhobbit", {
	description = "A hobbit player",
	give_to_singleplayer = false,
})

dofile(minetest.get_modpath("lottclasses").."/change-privs.lua")

local race_chooser = "size[8,6]"..
	"background[8,6;1,1;gui_formbg.png;true]"..
	"tablecolumns[color;text]"..
	"tableoptions[background=#00000000;highlight=#00000000;border=false]"..
	"table[0,0;6,0.5;race_message;#A52A2A,Please select the race you wish to be:;1]"..
	"image[0.25,1.4;0.75,0.75;dwarf.png]"..
	"button_exit[1,1.5;2,0.5;dwarf;Dwarf]"..
	"image[4.75,1.4;0.75,0.75;elf.png]"..
	"button_exit[5.5,1.5;2,0.5;elf;Elf]"..
	"image[0.25,2.4;0.75,0.75;man.png]"..
	"button_exit[1,2.5;2,0.5;man;Man]"..
	"image[4.75,2.4;0.75,0.75;orc.png]"..
	"button_exit[5.5,2.5;2,0.5;orc;Orc]"..
	"image[0.25,3.4;0.75,0.75;hobbit.png]"..
	"button_exit[1,3.5;2,0.5;hobbit;Hobbit]"..
	"dropdown[5.5,3.4;2;gender;Male,Female;1]"

local function give_stuff_dwarf(player)
	player:get_inventory():add_item('main', 'lottores:mithrilpick')
	player:get_inventory():add_item('main', 'lottweapons:mithril_battleaxe')
	player:get_inventory():add_item('main', 'lottores:mithrilaxe')
	player:get_inventory():add_item('main', 'default:shovel_steel')
	player:get_inventory():add_item('main', 'lottarmor:chestplate_mithril')
	player:get_inventory():add_item('main', 'lottinventory:crafts_book')
end

local function give_stuff_elf(player)
	player:get_inventory():add_item('main', 'default:pick_steel')
	player:get_inventory():add_item('main', 'default:axe_steel')
	player:get_inventory():add_item('main', 'default:shovel_steel')
	player:get_inventory():add_item('main', 'lottthrowing:bow_wood_mallorn')
	player:get_inventory():add_item('main', 'lottthrowing:arrow 99')
	player:get_inventory():add_item('main', 'lottinventory:potions_book')
	player:get_inventory():add_item('main', 'lottinventory:crafts_book')
end

local function give_stuff_man(player)
	player:get_inventory():add_item('main', 'default:pick_steel')
	player:get_inventory():add_item('main', 'default:axe_steel')
	player:get_inventory():add_item('main', 'default:shovel_steel')
	player:get_inventory():add_item('main', 'default:cobble 99')
	player:get_inventory():add_item('main', 'default:stonebrick 99')
	player:get_inventory():add_item('main', 'lottmobs:horseh1')
	player:get_inventory():add_item('main', 'lottinventory:crafts_book')
end

local function give_stuff_orc(player)
   player:get_inventory():add_item('main', 'lottweapons:orc_sword')
   player:get_inventory():add_item('main', 'default:axe_steel')
   player:get_inventory():add_item('main', 'default:shovel_steel')
   player:get_inventory():add_item('main', 'default:cobble 99')
   player:get_inventory():add_item('main', 'lottblocks:orc_brick 99')
   player:get_inventory():add_item('main', 'lottother:orc_torch 99')
   player:get_inventory():add_item('main', 'lottinventory:crafts_book')
end

local function give_stuff_hobbit(player)
	player:get_inventory():add_item('main', 'default:pick_stone')
	player:get_inventory():add_item('main', 'default:axe_stone')
	player:get_inventory():add_item('main', 'default:shovel_steel')
	player:get_inventory():add_item('main', 'farming:hoe_bronze')
	player:get_inventory():add_item('main', 'lottfarming:pipeweed_seed 14')
	player:get_inventory():add_item('main', 'lottfarming:tomatoes_seed 21')
	player:get_inventory():add_item('main', 'lottfarming:potato_seed 5')
	player:get_inventory():add_item('main', 'lottfarming:pipe')
	player:get_inventory():add_item('main', 'lottfarming:pipeweed_cooked')
	player:get_inventory():add_item('main', 'lottinventory:cooking_book')
	player:get_inventory():add_item('main', 'lottinventory:brewing_book')
	player:get_inventory():add_item('main', 'lottinventory:crafts_book')
	player:get_inventory():add_item('main', 'lottinventory:small')
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if minetest.get_player_privs(name).GAMEmale then
		if minetest.get_player_privs(name).GAMEdwarf then
			multiskin[name].skin = "dwarf_skin.png"
			return
		elseif minetest.get_player_privs(name).GAMEelf then
			multiskin[name].skin = "elf_skin.png"
			return
		elseif minetest.get_player_privs(name).GAMEman then
			multiskin[name].skin = "man_skin.png"
			return
		elseif minetest.get_player_privs(name).GAMEorc then
			multiskin[name].skin = "orc_skin.png"
			return
		elseif minetest.get_player_privs(name).GAMEhobbit then
			multiskin[name].skin = "hobbit_skin.png"
			return
		end
	elseif minetest.get_player_privs(name).GAMEfemale then
		if minetest.get_player_privs(name).GAMEdwarf then
			multiskin[name].skin = "dwarf_skinf.png"
			return
		elseif minetest.get_player_privs(name).GAMEelf then
			multiskin[name].skin = "elf_skinf.png"
			return
		elseif minetest.get_player_privs(name).GAMEman then
			multiskin[name].skin = "man_skinf.png"
			return
		elseif minetest.get_player_privs(name).GAMEorc then
			multiskin[name].skin = "orc_skin.png"
			return
		elseif minetest.get_player_privs(name).GAMEhobbit then
			multiskin[name].skin = "hobbit_skinf.png"
			return
		end
	else
		minetest.after(1, function()
			if minetest.is_singleplayer() then
				minetest.show_formspec(name, "race_selector", race_chooser ..
				"button[1,4.75;2,0.5;fast;Fast]" ..
				"button[3,4.75;2,0.5;fly;Fly]" ..
				"button[5,4.75;2,0.5;noclip;Noclip]" ..
				"button[2.5,5.5;3,0.5;fast_fly_noclip;Fast, Fly & Noclip]")
			else
				minetest.show_formspec(name, "race_selector", race_chooser)
			end
		end)
	end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "race_selector" then return end
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if fields.gender == "Male" then
		if fields.dwarf then
			minetest.chat_send_player(name, "You are now a member of the race of dwarves, go forth into the world.")
			privs.GAMEdwarf = true
			privs.GAMEmale = true
			minetest.set_player_privs(name, privs)
			give_stuff_dwarf(player)
			default.player_set_textures(player, {"dwarf_skin.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
			multiskin[name].skin = "dwarf_skin.png"
			minetest.log("action", name.. " chose to be a dwarf")
			return
		elseif fields.elf then
			minetest.chat_send_player(name, "You are now a member of the race of elves, go forth into the world.")
			privs.GAMEelf = true
			privs.GAMEmale = true
			minetest.set_player_privs(name, privs)
			give_stuff_elf(player)
			default.player_set_textures(player, {"elf_skin.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
			multiskin[name].skin = "elf_skin.png"
			minetest.log("action", name.. " chose to be an elf")
			return
		elseif fields.man then
			minetest.chat_send_player(name, "You are now a member of the race of men, go forth into the world.")
			privs.GAMEman = true
			privs.GAMEmale = true
			minetest.set_player_privs(name, privs)
			give_stuff_man(player)
			default.player_set_textures(player, {"man_skin.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
			multiskin[name].skin = "man_skin.png"
			minetest.log("action", name.. " chose to be a man")
			return
		elseif fields.orc then
			minetest.chat_send_player(name, "You are now a member of the race of orcs, go forth into the world.")
			privs.GAMEorc = true
			privs.GAMEmale = true
			minetest.set_player_privs(name, privs)
			give_stuff_orc(player)
			default.player_set_textures(player, {"orc_skin.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
			multiskin[name].skin = "orc_skin.png"
			minetest.log("action", name.. " chose to be a orc")
			return
		elseif fields.hobbit then
			minetest.chat_send_player(name, "You are now a member of the race of hobbits, go forth into the world.")
			privs.GAMEhobbit = true
			privs.GAMEmale = true
			minetest.set_player_privs(name, privs)
			give_stuff_hobbit(player)
			default.player_set_textures(player, {"hobbit_skin.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
			multiskin[name].skin = "hobbit_skin.png"
			minetest.log("action", name.. " chose to be a hobbit.")
			return
		end
	elseif fields.gender == "Female" then
		if fields.dwarf then
			minetest.chat_send_player(name, "You are now a member of the race of dwarves, go forth into the world.")
			privs.GAMEdwarf = true
			privs.GAMEfemale = true
			minetest.set_player_privs(name, privs)
			give_stuff_dwarf(player)
			default.player_set_textures(player, {"dwarf_skinf.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
			multiskin[name].skin = "dwarf_skinf.png"
			minetest.log("action", name.. " chose to be a dwarf")
			return
		elseif fields.elf then
			minetest.chat_send_player(name, "You are now a member of the race of elves, go forth into the world.")
			privs.GAMEelf = true
			privs.GAMEfemale = true
			minetest.set_player_privs(name, privs)
			give_stuff_elf(player)
			default.player_set_textures(player, {"elf_skinf.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
			multiskin[name].skin = "elf_skinf.png"
			minetest.log("action", name.. " chose to be an elf")
			return
		elseif fields.man then
			minetest.chat_send_player(name, "You are now a member of the race of men, go forth into the world.")
			privs.GAMEman = true
			privs.GAMEfemale = true
			minetest.set_player_privs(name, privs)
			give_stuff_man(player)
			default.player_set_textures(player, {"man_skinf.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
			multiskin[name].skin = "man_skinf.png"
			minetest.log("action", name.. " chose to be a woman")
			return
		elseif fields.orc then
			minetest.chat_send_player(name, "You are now a member of the race of orcs, go forth into the world.")
			privs.GAMEorc = true
			privs.GAMEfemale = true
			minetest.set_player_privs(name, privs)
			give_stuff_orc(player)
			default.player_set_textures(player, {"orc_skin.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
			multiskin[name].skin = "orc_skin.png"
			minetest.log("action", name.. " chose to be a orc")
			return
		elseif fields.hobbit then
			minetest.chat_send_player(name, "You are now a member of the race of hobbits, go forth into the world.")
			privs.GAMEhobbit = true
			privs.GAMEfemale = true
			minetest.set_player_privs(name, privs)
			give_stuff_hobbit(player)
			default.player_set_textures(player, {"hobbit_skinf.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
			multiskin[name].skin = "hobbit_skinf.png"
			minetest.log("action", name.. " chose to be a hobbit.")
			return
		end
	end
	if fields.fast then
		privs.fast = true
        minetest.set_player_privs(name, privs)
        return
	elseif fields.fly then
		privs.fly = true
        minetest.set_player_privs(name, privs)
        return
	elseif fields.noclip then
		privs.noclip = true
        minetest.set_player_privs(name, privs)
        return
	elseif fields.fast_fly_noclip then
		privs.fly, privs.fast, privs.noclip = true, true, true
        minetest.set_player_privs(name, privs)
        return
	end
end)
