minetest.register_craftitem("gul:ringsilver_lump", {
	description = "Unrefined Ring Silver",
	inventory_image = "gul_ringsilver_lump.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("gul:ringsilver_ingot", {
	description = "Refined Ring Silver",
	inventory_image = "gul_ringsilver_ingot.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("gul:ring", {
	description = "Plain Ring",
	inventory_image = "gul_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("gul:purple_gem", {
	description = "Purple Gem",
	inventory_image = "gul_purplegem.png",
     groups = {forbidden=1},
})


--ELF RINGS
--FUNCTION = Sets your health to max every 30 seconds.
minetest.register_craftitem("gul:blue_gem_ring", {
	description = "Blue Gem Ring.",
	inventory_image = "gul_bluegem_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("gul:blue_am_ring", {
	description = "Blue Almost Magic Ring",
	inventory_image = "gul_bluegem_am_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("gul:vilya", {
	description = "Vilya",
	inventory_image = "gul_vilya.png",
     groups = {forbidden=1},
})
minetest.register_globalstep(function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		if math.random() < 0.1 then
			if player:get_inventory():get_stack("main", player:get_wield_index()):get_name() == "gul:vilya"
			and player:get_hp() < 19 then
				player:set_hp(20)
			end

		end
	end

end)

--FUNCTION = Makes (good) mobs follow you.
minetest.register_craftitem("gul:red_gem_ring", {
	description = "Red Gem Ring",
	inventory_image = "gul_redgem_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("gul:red_am_ring", {
	description = "Red Almost Magic Ring",
	inventory_image = "gul_redgem_am_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("gul:narya", {
	description = "Narya",
	inventory_image = "gul_narya.png",
     groups = {forbidden=1},
})
--follow = "gul:narya",

--FUNCTION = Same armor stats as a full set of mithril. 
minetest.register_craftitem("gul:white_gem_ring", {
	description = "White Gem Ring",
	inventory_image = "gul_whitegem_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("gul:white_am_ring", {
	description = "White Almost Magic Ring",
	inventory_image = "gul_whitegem_am_ring.png",
     groups = {forbidden=1},
})
minetest.register_tool("gul:nenya", {
	description = "Nenya",
	inventory_image = "gul_nenya_inv.png",
	groups = {armor_head=15, armor_torso=20, armor_legs=20, armor_feet=15, armor_shield=25,forbidden=1},
	wear = 0,
})

--OTHER RINGS
--Mithril ring (base for Dwarf ring)
minetest.register_craftitem("gul:purple_gem_ring", {
	description = "Purple Gem Ring",
	inventory_image = "gul_purplegem_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("gul:purple_gem_mithril_ring", {
	description = "Purple Gem Mithril Ring",
	inventory_image = "gul_purplegem_mithril_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("gul:purple_am_ring", {
	description = "Mithril Almost Magic Ring",
	inventory_image = "gul_purplegem_am_ring.png",
     groups = {forbidden=1},
})
minetest.register_craftitem("gul:dwarf_ring", {
	description = "Dwarf Ring",
	inventory_image = "gul_dwarf_ring.png",
     groups = {forbidden=1},
})
