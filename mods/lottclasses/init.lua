lottclasses = {}

minetest.register_privilege("GAMEwizard", {
	description = "A wizard player",
	give_to_singleplayer = false,
	give_to_admin = true,
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
	"label[0,0;" .. minetest.colorize("#A52A2A", "Please select the race you wish to be") .. "]"..
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

local function give_stuff_dwarf(player)
	local inv = player:get_inventory()
	inv:add_item('main', 'default:pick_steel')
	inv:add_item('main', 'lottweapons:steel_warhammer')
	inv:add_item('main', 'farming:bread 5')
	inv:add_item('main', 'default:torch 8')
	inv:add_item('main', 'lottinventory:crafts_book')
	inv:add_item('main', 'lottachievements:achievement_book')
end

local function give_stuff_elf(player)
	local inv = player:get_inventory()
	inv:add_item('main', 'default:pick_steel')
	inv:add_item('main', 'lottthrowing:bow_wood')
	inv:add_item('main', 'lottthrowing:arrow 25')
	inv:add_item('main', 'farming:bread 5')
	inv:add_item('main', 'lottblocks:elf_torch 8')
	inv:add_item('main', 'lottinventory:crafts_book')
	inv:add_item('main', 'lottachievements:achievement_book')
end

local function give_stuff_man(player)
	local inv = player:get_inventory()
	inv:add_item('main', 'default:pick_bronze')
	inv:add_item('main', 'default:sword_bronze')
	inv:add_item('main', 'farming:bread 5')
	inv:add_item('main', 'default:torch 8')
	inv:add_item('main', 'lottinventory:crafts_book')
	inv:add_item('main', 'lottachievements:achievement_book')
end

local function give_stuff_orc(player)
	local inv = player:get_inventory()
	inv:add_item('main', 'lottweapons:orc_sword')
	inv:add_item('main', 'default:pick_steel')
	inv:add_item('main', 'lottfarming:orc_food 5')
	inv:add_item('main', 'lottblocks:orc_torch 8')
	inv:add_item('main', 'lottinventory:crafts_book')
	inv:add_item('main', 'lottachievements:achievement_book')
end

local function give_stuff_hobbit(player)
	local inv = player:get_inventory()
	inv:add_item('main', 'default:pick_stone')
	inv:add_item('main', 'farming:hoe_steel')
	inv:add_item('main', 'lottfarming:tomatoes_seed 2')
	inv:add_item('main', 'lottfarming:potato_seed 3')
	inv:add_item('main', 'lottfarming:pipe')
	inv:add_item('main', 'lottfarming:pipeweed_cooked 8')
	inv:add_item('main', 'lottinventory:crafts_book')
	inv:add_item('main', 'lottachievements:achievement_book')
end

local function give_stuff_wizard(player)
	local inv = player:get_inventory()
	inv:add_item('main', 'default:pick_steel')
	inv:add_item('main', 'default:axe_steel')
	inv:add_item('main', 'default:shovel_steel')
	inv:add_item('main', 'default:sword_steel')
	inv:add_item('main', 'lottinventory:master_book')
	inv:add_item('main', 'lottachievements:achievement_book')
end

local immune_spawn_amt = tonumber(minetest.settings:get("immune_spawn")) or 300
minetest.settings:set("immune_spawn", immune_spawn_amt)
local immune_amt = tonumber(minetest.settings:get("immune_spawn"))

minetest.register_on_newplayer(function(player)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if minetest.get_player_privs(name).GAMEwizard then
		give_stuff_wizard(player)
	end
	
	-- Starter mob immunity to counter unfavourable spawns
	if minetest.setting_getbool("disable_immune_spawn") then
		return
	end
	
	if minetest.setting_getbool("enable_damage") then
		
		player:set_attribute("lott:immunity", immune_amt)
		armor:set_player_armor(player)
		
		minetest.after(5, function()
			if player == nil then return end
			minetest.chat_send_player(name, minetest.colorize("green", "Starter mob immunity granted for "..immune_amt/ 60 .." minutes! Travel to a safe area!"))
		end)
		
		for i = 1, immune_amt do
			minetest.after(i, function()
				if player == nil then return end
				if not player:get_attribute("lott:immunity") then return end
				player:set_attribute("lott:immunity", tonumber(player:get_attribute("lott:immunity")) - 1)
			end)
		end
	
		minetest.after(immune_amt+1, function()
			player:set_attribute("lott:immunity", nil)
			minetest.chat_send_player(name, minetest.colorize("orange", "Your starter mob immunity has expired!"))
			armor:set_player_armor(player)
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
	
	-- Resume starter mob immunity
	if player:get_attribute("lott:immunity") ~= nil then
		if not tonumber(player:get_attribute("lott:immunity")) then
			player:set_attribute("lott:immunity", nil)
			return
		end
		if tonumber(player:get_attribute("lott:immunity")) >= immune_amt then
			return
		end
	
		minetest.chat_send_player(name, minetest.colorize("green", "Your starter mob immunity has resumed!"))
		minetest.chat_send_player(name, minetest.colorize("green", "You still have "..tonumber(player:get_attribute("lott:immunity")) / 60 .." minutes left!"))
	
		for i = 1, tonumber(player:get_attribute("lott:immunity")) do
			if not tonumber(player:get_attribute("lott:immunity")) then
				player:set_attribute("lott:immunity", nil)
				return
			end
			minetest.after(i, function()
				if player == nil then return end
				if not player:get_attribute("lott:immunity") then return end
				player:set_attribute("lott:immunity", tonumber(player:get_attribute("lott:immunity")) - 1)
			end)
		end
		
		minetest.after(player:get_attribute("lott:immunity")+1, function()
			if player == nil then return end
			player:set_attribute("lott:immunity", nil)
			armor:set_player_armor(player)
		
			minetest.chat_send_player(name, minetest.colorize("orange", "Your starter mob immunity has expired!"))
		end)
	end
end)

local function player_race_stuff(race, text, mf, func, name, privs, player)
	minetest.chat_send_player(name, "You are now a member of the race of " .. text ..", go forth into the world.")
	privs["GAME" .. race] = true
	privs["GAME" .. mf] = true
	minetest.set_player_privs(name, privs)
	if minetest.settings:get_bool("lott_give_initial_stuff", true) == true then
		func(player)
	end
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
