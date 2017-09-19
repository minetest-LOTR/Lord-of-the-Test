lottclasses = {}

minetest.register_privilege("GAMEwizard", {
	description = "A wizard player",
	give_to_singleplayer = false,
})

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
dofile(minetest.get_modpath("lottclasses").."/allies.lua")

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

local fly_stuff = "button[1,4.75;2,0.5;fast;Fast]" ..
	"button[3,4.75;2,0.5;fly;Fly]" ..
	"button[5,4.75;2,0.5;noclip;Noclip]" ..
	"button[2.5,5.5;3,0.5;fast_fly_noclip;Fast, Fly & Noclip]"

chance = 0

local function regen_chance()
	chance = math.random(1, 6)
end

local function give_stuff_dwarf(player)
	regen_chance()
	if chance == 1 then
		player:get_inventory():add_item('main', 'lottores:mithrilpick')
	elseif chance == 2 or chance == 3 then
		player:get_inventory():add_item('main', 'lottores:tinpick')
	elseif chance == 4 then
		player:get_inventory():add_item('main', 'lottores:galvornpick')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'default:pick_steel')
	end
	regen_chance()
	if chance == 1 then
		player:get_inventory():add_item('main', 'lottores:copperaxe')
		player:get_inventory():add_item('main', 'lottweapons:gold_spear')
	elseif chance == 2 then
		player:get_inventory():add_item('main', 'lottores:mithrilaxe')
		player:get_inventory():add_item('main', 'lottweapons:bronze_warhammer')
	elseif chance == 3 or chance == 4 then
		player:get_inventory():add_item('main', 'default:axe_steel')
		player:get_inventory():add_item('main', 'lottweapons:silver_spear')
	elseif chance == 5 then
		player:get_inventory():add_item('main', 'lottweapons:mithril_battleaxe')
	elseif chance == 6 then
		player:get_inventory():add_item('main', 'default:axe_steel')
		player:get_inventory():add_item('main', 'default:sword_steel')
	end
	regen_chance()
	if chance <= 3 then
		player:get_inventory():add_item('main', 'default:shovel_stone')
	elseif chance == 4 then
		player:get_inventory():add_item('main', 'default:shovel_steel')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'lottores:coppershovel')
	end
	regen_chance()
	if chance == 1 then
		player:get_inventory():add_item('main', 'lottarmor:chestplate_bronze')
	elseif chance == 2 then
		player:get_inventory():add_item('main', 'lottarmor:chestplate_steel')
	elseif chance == 3 then
		player:get_inventory():add_item('main', 'lottarmor:chestplate_mithril')
	elseif chance == 4 then
		player:get_inventory():add_item('main', 'lottarmor:chestplate_tin')
	elseif chance == 5 then
		player:get_inventory():add_item('main', 'lottarmor:chestplate_galvorn')
	elseif chance == 6 then
		player:get_inventory():add_item('main', 'lottarmor:chestplate_gold')
	end
	player:get_inventory():add_item('main', 'lottinventory:crafts_book')
end

local function give_stuff_elf(player)
	regen_chance()
	if chance <= 2 then
		player:get_inventory():add_item('main', 'default:pick_steel')
	elseif chance == 3 or chance == 4 or chance == 5 then
		player:get_inventory():add_item('main', 'lottores:copperpick')
	elseif chance == 6 then
		player:get_inventory():add_item('main', 'lottores:galvornpick')
	end
	regen_chance()
	if chance == 1 then
		player:get_inventory():add_item('main', 'default:axe_steel')
	elseif chance == 2 or chance == 3 then
		player:get_inventory():add_item('main', 'lottores:tinaxe')
	elseif chance == 4 then
		player:get_inventory():add_item('main', 'lottores:galvornaxe')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'lottores:copperaxe')
	end
	regen_chance()
	if chance <= 3 then
		player:get_inventory():add_item('main', 'lottores:coppershovel')
	elseif chance >= 4 then
		player:get_inventory():add_item('main', 'default:shovel_steel')
	end
	regen_chance()
	if chance == 1 then
		player:get_inventory():add_item('main', 'lottthrowing:bow_wood_alder')
	elseif chance == 2 then
		player:get_inventory():add_item('main', 'lottthrowing:bow_wood_lebethron')
	elseif chance == 3 or chance == 4 then
		player:get_inventory():add_item('main', 'lottthrowing:bow_wood')
	elseif chance == 5 then
		player:get_inventory():add_item('main', 'lottthrowing:bow_wood_mallorn')
	elseif chance == 6 then
		player:get_inventory():add_item('main', 'lottthrowing:bow_wood_birch')
	end
	regen_chance()
	if chance <= 2 then
		player:get_inventory():add_item('main', 'lottthrowing:arrow 99')
	elseif chance == 3 or chance == 4 then
		player:get_inventory():add_item('main', 'lottthrowing:arrow 50')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'lottthrowing:arrow 25')
	end
	regen_chance()
	if chance < 5 then
		player:get_inventory():add_item('main', 'lottinventory:potions_book')
	end
	player:get_inventory():add_item('main', 'lottinventory:crafts_book')
end

local function give_stuff_man(player)
	regen_chance()
	if chance <= 2 then
		player:get_inventory():add_item('main', 'default:pick_steel')
	elseif chance == 3 or chance == 4 then
		player:get_inventory():add_item('main', 'default:pick_bronze')
	elseif chance == 5 then
		player:get_inventory():add_item('main', 'lottores:tinpick')
	elseif chance == 6 then
		player:get_inventory():add_item('main', 'lottores:copperpick')
	end
	regen_chance()
	if chance <= 3 then
		player:get_inventory():add_item('main', 'lottores:silveraxe')
	elseif chance == 4 then
		player:get_inventory():add_item('main', 'default:axe_bronze')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'default:axe_steel')
	end
	regen_chance()
	if chance <= 2 then
		player:get_inventory():add_item('main', 'default:shovel_stone')
	elseif chance == 3 or chance == 4 then
		player:get_inventory():add_item('main', 'default:shovel_steel')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'lottores:tinshovel')
	end
	regen_chance()
	if chance <= 2 then
		player:get_inventory():add_item('main', 'default:cobble 99')
		player:get_inventory():add_item('main', 'default:stonebrick 99')
	elseif chance == 3 or chance == 4 then
		player:get_inventory():add_item('main', 'default:desert_cobble 99')
		player:get_inventory():add_item('main', 'default:desert_stonebrick 99')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'default:sandstone 99')
		player:get_inventory():add_item('main', 'default:sandstonebrick 99')
	end
	regen_chance()
	if chance <= 2 then
		player:get_inventory():add_item('main', 'lottmobs:horseh1')
	elseif chance == 3 or chance == 4 then
		player:get_inventory():add_item('main', 'lottmobs:horsepegh1')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'lottmobs:horsearah1')
	end
	player:get_inventory():add_item('main', 'lottinventory:crafts_book')
end

local function give_stuff_orc(player)
	player:get_inventory():add_item('main', 'lottweapons:orc_sword')
	regen_chance()
	if chance <= 2 then
		player:get_inventory():add_item('main', 'default:axe_steel')
	elseif chance == 3 or chance == 4 then
		player:get_inventory():add_item('main', 'lottores:tinaxe')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'lottores:copperaxe')
	end
	regen_chance()
	if chance <= 2 then
		player:get_inventory():add_item('main', 'default:shovel_steel')
	elseif chance == 3 or chance == 4 then
		player:get_inventory():add_item('main', 'lottores:tinshovel')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'lottores:coppershovel')
	end
	regen_chance()
	player:get_inventory():add_item('main', 'lottblocks:orc_brick 99')
	player:get_inventory():add_item('main', 'lottfarming:orc_food 5')
	player:get_inventory():add_item('main', 'lottfarming:orc_medicine 3')
	player:get_inventory():add_item('main', 'lottblocks:orc_torch 50')
	player:get_inventory():add_item('main', 'lottmobs:meat_raw 10')
	player:get_inventory():add_item('main', 'lottinventory:crafts_book')
end

local function give_stuff_hobbit(player)
	regen_chance()
	if chance <= 3 then
		player:get_inventory():add_item('main', 'default:pick_stone')
	elseif chance == 4 then
		player:get_inventory():add_item('main', 'default:pick_wood')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'default:pick_steel')
	end
	regen_chance()
	player:get_inventory():add_item('main', 'default:axe_steel')
	if chance <= 2 then
		player:get_inventory():add_item('main', 'default:shovel_steel')
	elseif chance == 3 or chance == 4 then
		player:get_inventory():add_item('main', 'default:shovel_bronze')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'lottores:silvershovel')
	end
	regen_chance()
	if chance <= 3 then
		player:get_inventory():add_item('main', 'farming:hoe_bronze')
	elseif chance >= 4 then
		player:get_inventory():add_item('main', 'farming:hoe_steel')
	end
	regen_chance()
	player:get_inventory():add_item('main', 'lottfarming:pipe')
	player:get_inventory():add_item('main', 'lottfarming:pipeweed_cooked ' .. math.random(2, 15))
	player:get_inventory():add_item('main', 'lottfarming:pipeweed_seed ' .. math.random(5, 30))
	player:get_inventory():add_item('main', 'lottfarming:tomatoes_seed ' .. math.random(5, 30))
	player:get_inventory():add_item('main', 'lottfarming:potato_seed ' .. math.random(5, 30))
	if chance <= 3 then
		player:get_inventory():add_item('main', 'lottinventory:cooking_book')
	elseif chance >= 4 then
		player:get_inventory():add_item('main', 'lottinventory:brewing_book')
	end
	player:get_inventory():add_item('main', 'lottinventory:crafts_book')
	player:get_inventory():add_item('main', 'lottinventory:small')
end

local function give_stuff_wizard(player)
	regen_chance()
	if chance <= 2 then
		player:get_inventory():add_item('main', 'default:pick_steel')
	elseif chance == 3 or chance == 4 or chance == 5 then
		player:get_inventory():add_item('main', 'lottores:copperpick')
	elseif chance == 6 then
		player:get_inventory():add_item('main', 'lottores:galvornpick')
	end
	regen_chance()
	if chance == 1 then
		player:get_inventory():add_item('main', 'default:axe_steel')
	elseif chance == 2 or chance == 3 then
		player:get_inventory():add_item('main', 'lottores:tinaxe')
	elseif chance == 4 then
		player:get_inventory():add_item('main', 'lottores:galvornaxe')
	elseif chance >= 5 then
		player:get_inventory():add_item('main', 'lottores:copperaxe')
	end
	regen_chance()
	if chance <= 3 then
		player:get_inventory():add_item('main', 'lottores:coppershovel')
	elseif chance >= 4 then
		player:get_inventory():add_item('main', 'default:shovel_steel')
	end
	player:get_inventory():add_item('main', 'default:sword_steel')
	regen_chance()
	if chance < 5 then
		player:get_inventory():add_item('main', 'lottinventory:potions_book')
	end
	player:get_inventory():add_item('main', 'lottinventory:master_book')
end

minetest.register_on_newplayer(function(player)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if minetest.get_player_privs(name).GAMEwizard then
		give_stuff_wizard(player)
	end
	
	if minetest.setting_getbool("disable_immune_spawn") then
		return
	end
	
	if minetest.setting_getbool("enable_damage") then
		for i = 1, 300 do
			minetest.after(i, function()
				player:set_hp(20)
				local name = player:get_player_name()
			end)
		end
		minetest.after(5, function()
			minetest.chat_send_player(name, minetest.colorize("red", "[NOTICE] You are NEARLY IMMUNE to damage for 5 MINUTES. Make use of this time to venture to a safe area!"))
			minetest.chat_send_player(name, minetest.colorize("red", "[NOTICE] You are NEARLY IMMUNE to damage for 5 MINUTES. Make use of this time to venture to a safe area!"))
		end)
	
		minetest.after(300, function()
			minetest.chat_send_player(name, minetest.colorize("red", "[NOTICE] You are NO LONGER immune to damage!"))
			minetest.chat_send_player(name, minetest.colorize("red", "[NOTICE] You are NO LONGER immune to damage!"))
		end)
	end
end)

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if minetest.get_player_privs(name).GAMEwizard then
		multiskin[name].skin = "wizard_skin.png"
	elseif minetest.get_player_privs(name).GAMEmale then
		if minetest.get_player_privs(name).GAMEdwarf then
			multiskin[name].skin = "dwarf_skin.png"
		elseif minetest.get_player_privs(name).GAMEelf then
			multiskin[name].skin = "elf_skin.png"
		elseif minetest.get_player_privs(name).GAMEman then
			multiskin[name].skin = "man_skin.png"
		elseif minetest.get_player_privs(name).GAMEorc then
			multiskin[name].skin = "orc_skin.png"
		elseif minetest.get_player_privs(name).GAMEhobbit then
			multiskin[name].skin = "hobbit_skin.png"
		end
	elseif minetest.get_player_privs(name).GAMEfemale then
		if minetest.get_player_privs(name).GAMEdwarf then
			multiskin[name].skin = "dwarf_skinf.png"
		elseif minetest.get_player_privs(name).GAMEelf then
			multiskin[name].skin = "elf_skinf.png"
		elseif minetest.get_player_privs(name).GAMEman then
			multiskin[name].skin = "man_skinf.png"
		elseif minetest.get_player_privs(name).GAMEorc then
			multiskin[name].skin = "orc_skin.png"
		elseif minetest.get_player_privs(name).GAMEhobbit then
			multiskin[name].skin = "hobbit_skinf.png"
		end
	else
		minetest.after(1, function()
			if minetest.is_singleplayer() then
				minetest.show_formspec(name, "race_selector", race_chooser .. fly_stuff)
			else
				minetest.show_formspec(name, "race_selector", race_chooser)
			end
		end)
	end
end)

local function player_race_stuff(race, text, mf, func, name, privs, player)
	minetest.chat_send_player(name, "You are now a member of the race of " .. text ..", go forth into the world.")
	privs["GAME" .. race] = true
	privs["GAME" .. mf] = true
	minetest.set_player_privs(name, privs)
	func(player)
	if mf == "male" or race == "orc" or race == "wizard" then
		default.player_set_textures(player, {race .. "_skin.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
		multiskin[name].skin = race .. "_skin.png"
	elseif mf == "female" then
		default.player_set_textures(player, {race .. "_skinf.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
		multiskin[name].skin = race .. "_skinf.png"
	end
	minetest.log("action", name.. " chose to be a " .. race)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "race_selector" then return end
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if fields.gender == "Male" then
		if fields.dwarf then
			player_race_stuff("dwarf", "dwarves", "male", give_stuff_dwarf, name, privs, player)
			
		elseif fields.elf then
			player_race_stuff("elf", "elves", "male", give_stuff_elf, name, privs, player)
		elseif fields.man then
			player_race_stuff("man", "men", "male", give_stuff_man, name, privs, player)
		elseif fields.orc then
			player_race_stuff("orc", "orcs", "male", give_stuff_orc, name, privs, player)
		elseif fields.hobbit then
			player_race_stuff("hobbit", "hobbits", "male", give_stuff_hobbit, name, privs, player)
		end
	elseif fields.gender == "Female" then
		if fields.dwarf then
			player_race_stuff("dwarf", "dwarves", "female", give_stuff_dwarf, name, privs, player)
		elseif fields.elf then
			player_race_stuff("elf", "elves", "female", give_stuff_elf, name, privs, player)
		elseif fields.man then
			player_race_stuff("man", "men", "female", give_stuff_man, name, privs, player)
		elseif fields.orc then
			player_race_stuff("orc", "orcs", "female", give_stuff_orc, name, privs, player)
		elseif fields.hobbit then
			player_race_stuff("hobbit", "hobbits", "female", give_stuff_hobbit, name, privs, player)
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

minetest.register_chatcommand("race", {
	params = "<name>",
	description = "print out privileges of player",
	func = function(name, param)
		param = (param ~= "" and param or name)
		if minetest.check_player_privs(param, {GAMEwizard = true}) then
			return true, "Race of " .. param .. ": Wizard"
		elseif minetest.check_player_privs(param, {GAMEdwarf = true}) then
			return true, "Race of " .. param .. ": Dwarf"
		elseif minetest.check_player_privs(param, {GAMEelf = true}) then
			return true, "Race of " .. param .. ": Elf"
		elseif minetest.check_player_privs(param, {GAMEman = true}) then
			return true, "Race of " .. param .. ": Man"
		elseif minetest.check_player_privs(param, {GAMEorc = true}) then
			return true, "Race of " .. param .. ": Orc"
		elseif minetest.check_player_privs(param, {GAMEhobbit = true}) then
			return true, "Race of " .. param .. ": Hobbit"
		elseif minetest.check_player_privs(param, {shout = true}) ~= nil then
			if param == name then
				if minetest.is_singleplayer() then
					minetest.show_formspec(name, "race_selector", race_chooser .. fly_stuff)
				else
					minetest.show_formspec(name, "race_selector", race_chooser)
				end
			else
				return true, param .. " has not chosen a race!"
			end
		else
			return true, param .. " does not exist!"
		end
	end,
})
