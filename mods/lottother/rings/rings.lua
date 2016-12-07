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
--FUNCTION = Sets your health to max every 10 seconds.

minetest.register_craftitem("lottother:vilya", {
	description = "Vilya",
	inventory_image = "lottother_vilya.png",
     groups = {forbidden=1},
})
local time = 0
minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > 10 then
		time = 0
		for _, player in ipairs(minetest.get_connected_players()) do
			if player:get_inventory():get_stack("main", player:get_wield_index()):get_name() == "lottother:vilya"
			and player:get_hp() < 19 then
				player:set_hp(20)
			end
		end
	end
end)

--FUNCTION = Makes (good) mobs follow you.

minetest.register_craftitem("lottother:narya", {
	description = "Narya",
	inventory_image = "lottother_narya.png",
     groups = {forbidden=1},
})
--In mob def:
--follow = "lottother:narya",

--FUNCTION = Same armor stats as a full set of mithril.

minetest.register_tool("lottother:nenya", {
	description = "Nenya",
	inventory_image = "lottother_nenya_inv.png",
	groups = {armor_head=15, armor_torso=20, armor_legs=20, armor_feet=15, armor_shield=25,forbidden=1},
	wear = 0,
})

--------------------------------------------------------

--Dwarf Ring:

minetest.register_craftitem("lottother:dwarf_ring", {
	description = "Dwarf Ring",
	inventory_image = "lottother_dwarf_ring.png",
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
