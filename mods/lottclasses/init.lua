lottclasses = {}
lottclasses.race = {}
lottclasses.race["wizard"] = {"GAMEwizard", "wizards", "Wizard"}
lottclasses.race["dwarf"] = {"GAMEdwarf", "dwarves", "Dwarf"}
lottclasses.race["elf"] = {"GAMEelf", "elves", "Elf"}
lottclasses.race["man"] = {"GAMEman", "men", "Man"}
lottclasses.race["hobbit"] = {"GAMEhobbit", "hobbits", "Hobbit"}
lottclasses.race["orc"] = {"GAMEorc", "orcs", "Orc"}

-- create race privileges
for races, rdata in pairs(lottclasses.race) do
	minetest.register_privilege(rdata[1], {
		description = races.."-race player",
		give_to_singleplayer = false,
		give_to_admin = false,
	})
end

-- gender privileges
minetest.register_privilege("GAMEmale", {
	description = "A male player",
	give_to_singleplayer = false,
	give_to_admin = false,
})
minetest.register_privilege("GAMEfemale", {
	description = "A female player",
	give_to_singleplayer = false,
	give_to_admin = false,
})

dofile(minetest.get_modpath("lottclasses").."/change-privs.lua")
dofile(minetest.get_modpath("lottclasses").."/allies.lua")
dofile(minetest.get_modpath("lottclasses").."/immunity.lua")

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

local function add_item(player, item)
	local inv = player:get_inventory()
	inv:add_item("main", item)
end

local function give_initial_stuff(player, race)
	local inv = player:get_inventory()
	if race == "dwarf" then
		add_item(player, 'default:pick_steel')
		add_item(player, 'lottweapons:steel_warhammer')
		add_item(player, 'farming:bread 5')
		add_item(player, 'default:torch 8')
		add_item(player, 'lottinventory:crafts_book')
		add_item(player, 'lottachievements:achievement_book')
	elseif race == "elf" then
		add_item(player, 'default:pick_steel')
		add_item(player, 'lottthrowing:bow_wood')
		add_item(player, 'lottthrowing:arrow 25')
		add_item(player, 'farming:bread 5')
		add_item(player, 'lottblocks:elf_torch 8')
		add_item(player, 'lottinventory:crafts_book')
		add_item(player, 'lottachievements:achievement_book')
	elseif race == "man" then
		add_item(player, 'default:pick_bronze')
		add_item(player, 'default:sword_bronze')
		add_item(player, 'farming:bread 5')
		add_item(player, 'default:torch 8')
		add_item(player, 'lottinventory:crafts_book')
		add_item(player, 'lottachievements:achievement_book')
	elseif race == "orc" then
		add_item(player, 'lottweapons:orc_sword')
		add_item(player, 'default:pick_steel')
		add_item(player, 'lottfarming:orc_food 5')
		add_item(player, 'lottblocks:orc_torch 8')
		add_item(player, 'lottinventory:crafts_book')
		add_item(player, 'lottachievements:achievement_book')
	elseif race == "hobbit" then
		add_item(player, 'default:pick_stone')
		add_item(player, 'farming:hoe_steel')
		add_item(player, 'lottfarming:tomatoes_seed 2')
		add_item(player, 'lottfarming:potato_seed 3')
		add_item(player, 'lottfarming:pipe')
		add_item(player, 'lottfarming:pipeweed_cooked 8')
		add_item(player, 'lottinventory:crafts_book')
		add_item(player, 'lottachievements:achievement_book')
	elseif race == "wizard" then
		add_item(player, 'default:pick_steel')
		add_item(player, 'default:axe_steel')
		add_item(player, 'default:shovel_steel')
		add_item(player, 'default:sword_steel')
		add_item(player, 'lottinventory:master_book')
		add_item(player, 'lottachievements:achievement_book')
	end
end

local function update_skin(player)
	if not player then
		return
	end
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	local meta = player:get_meta()
	if privs.GAMEmale then
		for races in pairs(lottclasses.race) do
			if privs["GAME"..races] then
				multiskin[name].skin = races.."_skin.png"
				multiskin:update_player_visuals(player)
			end
		end
	elseif privs.GAMEfemale then
		for races in pairs(lottclasses.race) do
			if privs["GAME"..races] then
				multiskin[name].skin = races.."_skinf.png"
				multiskin:update_player_visuals(player)
			end
		end
	end
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if privs.GAMEmale or privs.GAMEfemale then
		update_skin(player)
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

local function set_gender(player, gender)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	privs["GAME"..gender] = true
	minetest.set_player_privs(name, privs)
	update_skin(player)
end

local function set_race(name, race)
	local privs = minetest.get_player_privs(name)
	privs["GAME"..race] = true
	minetest.set_player_privs(name, privs)
	minetest.chat_send_player(name, "You are now a member of the race of "..lottclasses.race[race][2]..", go forth into the world.")
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "race_selector" then return end
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if fields.gender == "Male" then
		for races in pairs(lottclasses.race) do
			if fields[races] then
				set_gender(player, "male")
				set_race(name, races)
				update_skin(player)
				give_initial_stuff(player, races)
				minetest.log("action", name.." chose to be a male "..races)
				return
			end
		end
	elseif fields.gender == "Female" then
		for races in pairs(lottclasses.race) do
			if fields[races] then
				set_gender(player, "female")
				set_race(name, races)
				update_skin(player)
				give_initial_stuff(player, races)
				minetest.log("action", name.. " chose to be a female " .. races)
				return
			end
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
	if fields.quit then
		if not privs.GAMEfemale and not privs.GAMEmale then
			minetest.chat_send_player(name, minetest.colorize("red", "Please select a race!"))
			minetest.after(0.1, function()
				if minetest.is_singleplayer() then
					minetest.show_formspec(name, "race_selector", race_chooser .. fly_stuff)
				else
					minetest.show_formspec(name, "race_selector", race_chooser)
				end
			end)
		end
	end
end)

minetest.register_chatcommand("race", {
	params = "<name> <race>",
	description = "Find/change a player's race",
	func = function(name, param)
		local playername, changerace = string.match(param, "([^ ]+) (.+)")
		if not playername then
			if not param or param == "" then
				playername = name
			else
				playername = param
			end
		end
		local privs = minetest.get_player_privs(playername)
		
		if minetest.player_exists(playername) == false then
			return true, playername.." does not exists!"
		end
		
		if not changerace then
			for races, rdata in pairs(lottclasses.race) do
				if privs[rdata[1]] then
					return true, "Race of "..playername..": "..rdata[3]
				end
			end
			if name == playername then
				if minetest.is_singleplayer() then
					minetest.show_formspec(name, "race_selector", race_chooser .. fly_stuff)
				else
					minetest.show_formspec(name, "race_selector", race_chooser)
				end
			else
				return true, playername.." has not chosen a race!"
			end
		elseif changerace then
			if not minetest.get_player_privs(name).privs then
				return true, "You have insufficient privilege to change player races!"
			end
		
			if lottclasses.race[changerace] then
				if privs.GAMEfemale or privs.GAMEmale then
					local player = minetest.get_player_by_name(playername)
					for races, rdata in pairs(lottclasses.race) do
						privs[rdata[1]] = nil
						minetest.set_player_privs(playername, privs)
					end
					set_race(playername, changerace)
					update_skin(player)
					minetest.log("action", name.." changed "..playername.."'s race to "..changerace)
					return true, "Race of "..playername.." has been changed to "..changerace
				else
					return true, playername.." has not chosen a race!"
				end
			else
				return true, changerace.." is not valid race. Select between: wizard dwarf elf man orc hobbit"
			end
		end
	end
})