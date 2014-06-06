minetest.register_craftitem("lottother:ringsilver_lump", {
	description = "Unrefined Ring Silver",
	inventory_image = "lottother_ringsilver_lump.png",
})
minetest.register_craftitem("lottother:ringsilver_ingot", {
	description = "Refined Ring Silver",
	inventory_image = "lottother_ringsilver_ingot.png",
})
minetest.register_craftitem("lottother:ring", {
	description = "Plain Ring",
	inventory_image = "lottother_ring.png",
})

--ELF RINGS
--FUNCTION = Sets your health to max every 30 seconds.
minetest.register_craftitem("lottother:blue_gem_ring", {
	description = "Blue Gem Ring.",
	inventory_image = "lottother_bluegem_ring.png",
})
minetest.register_craftitem("lottother:blue_am_ring", {
	description = "Blue Almost Magic Ring",
	inventory_image = "lottother_bluegem_am_ring.png",
})
minetest.register_craftitem("lottother:vilya", {
	description = "Vilya",
	inventory_image = "lottother_vilya.png",
})
minetest.register_globalstep(function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		if math.random() < 0.1 then
			if player:get_inventory():get_stack("main", player:get_wield_index()):get_name() == "lottother:vilya"
			and player:get_hp() < 19 then
				player:set_hp(20)
			end

		end
	end

end)

--FUNCTION = Makes (good) mobs follow you.
minetest.register_craftitem("lottother:red_gem_ring", {
	description = "Red Gem Ring",
	inventory_image = "lottother_redgem_ring.png",
})
minetest.register_craftitem("lottother:red_am_ring", {
	description = "Red Almost Magic Ring",
	inventory_image = "lottother_redgem_am_ring.png",
})
minetest.register_craftitem("lottother:narya", {
	description = "Narya",
	inventory_image = "lottother_narya.png",
})
--follow = "lottother:narya",

--FUNCTION = Same armor stats as a full set of mithril. 
minetest.register_craftitem("lottother:white_gem_ring", {
	description = "White Gem Ring",
	inventory_image = "lottother_whitegem_ring.png",
})
minetest.register_craftitem("lottother:white_am_ring", {
	description = "White Almost Magic Ring",
	inventory_image = "lottother_whitegem_am_ring.png",
})
minetest.register_tool("lottother:nenya", {
	description = "Nenya",
	inventory_image = "lottother_nenya_inv.png",
	groups = {armor_head=15, armor_torso=20, armor_legs=20, armor_feet=15, armor_shield=25},
	wear = 0,
})

minetest.register_craft({
	type = "shapeless",
	output = "lottother:ringsilver_lump",
	recipe = {"lottores:mithril_lump", "default:gold_lump", "lottores:silver_lump", "lottores:silver_lump"},
})
minetest.register_craft({
	type = "cooking",
	output = "lottother:ringsilver_ingot",
	recipe = "lottother:ringsilver_lump",
	cooktime = 35,
})
minetest.register_craft({
	output = "lottother:ring",
	recipe = {
	{"lottother:ringsilver_ingot", "lottother:ringsilver_ingot", "lottother:ringsilver_ingot"},
	{"lottother:ringsilver_ingot", "", "lottother:ringsilver_ingot"},
	{"lottother:ringsilver_ingot", "lottother:ringsilver_ingot", "lottother:ringsilver_ingot"},
	},
})

minetest.register_craft({
	output = "lottother:blue_gem_ring",
	recipe = {
	{"lottores:blue_gem"},
	{"lottother:ring"},
	},
})
minetest.register_craft({
	output = "lottother:blue_am_ring",
	recipe = {
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottother:blue_gem_ring", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	},
})
minetest.register_craft({
	type = "cooking",
	output = "lottother:vilya",
	recipe = "lottother:blue_am_ring",
	cooktime = 1000,
})

minetest.register_craft({
	output = "lottother:red_gem_ring",
	recipe = {
	{"lottores:red_gem"},
	{"lottother:ring"},
	},
})
minetest.register_craft({
	output = "lottother:red_am_ring",
	recipe = {
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottother:red_gem_ring", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	},
})
minetest.register_craft({
	type = "cooking",
	output = "lottother:narya",
	recipe = "lottother:red_am_ring",
	cooktime = 1000,
})

minetest.register_craft({
	output = "lottother:white_gem_ring",
	recipe = {
	{"lottores:white_gem"},
	{"lottother:ring"},
	},
})
minetest.register_craft({
	output = "lottother:white_am_ring",
	recipe = {
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottother:white_gem_ring", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	},
})
minetest.register_craft({
	type = "cooking",
	output = "lottother:nenya",
	recipe = "lottother:white_am_ring",
	cooktime = 1000,
})

--[[OTHER RINGS
--Mithril ring (base for Dwarf ring)
minetest.register_craftitem("lottother:mithril_ring", {
	description = "Mithril Ring",
	inventory_image = "lottother_mithril_ring.png",
})
minetest.register_craftitem("lottother:mithril_am_ring", {
	description = "Mithril Almost Magic Ring",
	inventory_image = "lottother_mithril_am_ring.png",
})
minetest.register_craftitem("lottother:dwarf_ring", {
	description = "Dwarf Ring",
	inventory_image = "lottother_mithril_am_ring.png",
})
]]--

