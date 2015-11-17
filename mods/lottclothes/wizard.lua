-- Clothes made for wizards


-- big black dwarf boots
minetest.register_tool("lottclothes:boots_dwarf", {
	description = "Dwarven Boots",
	inventory_image = "lottclothes_inv_boots_dwarf.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_feet=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:boots_dwarf",
	recipe = {
		{"lottclothes:felt_black", "", "lottclothes:felt_black"},
		{"default:steel_ingot", "", "default:steel_ingot"}
	}
})

-- cloak
minetest.register_tool("lottclothes:cloak_wizard", {
	description = "Wizard Cloak",
	inventory_image = "lottclothes_inv_cloak_wizard",
	groups = {armor_heal=0, clothes=1, no_preview=1, clothes_cloak=1},
	wear = 0
})

-- cap
minetest.register_tool("lottclothes:cap_wizard", {
	description = "Wizard Cap",
	inventory_image = "lottclothes_inv_cap_wizard",
	groups = {armor_heal=0, clothes=1, no_preview=1, clothes_head=1},
	wear = 0
})

-- robe
minetest.register_tool("lottclothes:robewizard", {
	description = "Wizard Robe",
	inventory_image = "lottclothes_inv_robe_wizard",
	groups = {armor_heal=0, clothes=1, no_preview=1, clothes_torso=1},
	wear = 0
})
