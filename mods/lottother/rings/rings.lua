--Aliases:
minetest.register_alias("lottores:blue_gem_ore", "lottother:blue_gem_ore")
minetest.register_alias("lottores:red_gem_ore", "lottother:red_gem_ore")
minetest.register_alias("lottores:white_gem_ore", "lottother:white_gem_ore")

minetest.register_alias("lottores:blue_gem", "lottother:blue_gem")
minetest.register_alias("lottores:red_gem", "lottother:red_gem")
minetest.register_alias("lottores:white_gem", "lottother:white_gem")

minetest.register_alias("lottother:blue_am_ring", "lottother:blue_rr_ring")
minetest.register_alias("lottother:red_am_ring", "lottother:red_rr_ring")
minetest.register_alias("lottother:white_am_ring", "lottother:white_rr_ring")

minetest.register_alias("lottother:purple_gem_mithril_ring", "lottother:purple_am_ring")
minetest.register_alias("lottother:ringsilver_lump", "lottother:ringsilver")
minetest.register_alias("lottother:ringsilver_ingot", "lottother:ringsilver")

--TODO: Rework ring functions.

--ELF RINGS
--FUNCTION = Fast health regeneration + Breathing underwater

minetest.register_craftitem("lottother:vilya", {
	description = minetest.colorize("skyblue", "Vilya\nElven Ring of Regeneration") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_vilya.png",
	stack_max = 1,
	groups = {forbidden=1},
})

local time = 0
minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > 1 then
		time = 0
		for _, player in ipairs(minetest.get_connected_players()) do
			if player:get_inventory():get_stack("main", player:get_wield_index()):get_name() == "lottother:vilya" then
				if player:get_hp() < 20 and player:get_hp() > 0 then
					player:set_hp(player:get_hp()+2)
				end
				
				if player:get_breath() < 10 then
					player:set_breath(10)
				end
			end
		end
	end
end)

--FUNCTION = Makes (good) mobs follow you + deadly attack

minetest.register_tool("lottother:narya", {
	description = minetest.colorize("crimson", "Narya\nElven Ring of Power") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_narya.png",
	stack_max = 1,
	groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 10.00,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.50, [2]=1.30, [3]=0.45}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=50},
	},
})
--In mob def:
--follow = "lottother:narya",

--FUNCTION = Mob Immunity

minetest.register_tool("lottother:nenya", {
	description = minetest.colorize("silver", "Nenya\nElven Ring of Immunity") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_nenya_inv.png",
	stack_max = 1,
	groups = {armor_head=15, armor_torso=20, armor_legs=20, armor_feet=15, armor_shield=25,forbidden=1},
	wear = 0,
})

local time = 0
minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > 1 then
		time = 0
		for _, player in ipairs(minetest.get_connected_players()) do
			if player:get_attribute("lott:immunity") == "ring" then
				if player:get_inventory():get_stack("main", player:get_wield_index()):get_name() ~= "lottother:nenya" then
					player:set_attribute("lott:immunity", nil)
					armor:set_player_armor(player)
				end
			end
		
			if player:get_inventory():get_stack("main", player:get_wield_index()):get_name() == "lottother:nenya" then
				if player:get_attribute("lott:immunity") == nil then
					player:set_attribute("lott:immunity", "ring")
					armor:set_player_armor(player)
				end
			end
		end
	end
end)

--------------------------------------------------------

--Dwarf Ring:

minetest.register_craftitem("lottother:dwarf_ring", {
	description = minetest.colorize("darkviolet", "Dwarvern Ring of Power") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_dwarf_ring.png",
	stack_max = 1,
	groups = {forbidden=1},
})

--Dwarf ring crafts...
minetest.register_craft({
	type = "shapeless",
	output = "lottores:silver_ingot 2",
	recipe = {"lottores:silver_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottores:tin_ingot 2",
	recipe = {"lottores:tin_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottores:lead_ingot 2",
	recipe = {"lottores:lead_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:steel_ingot 2",
	recipe = {"default:iron_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:copper_ingot 2",
	recipe = {"default:copper_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:gold_ingot 2",
	recipe = {"default:gold_lump", "lottother:dwarf_ring"},
	replacements = {{ "lottother:dwarf_ring", "lottother:dwarf_ring"}},
})
