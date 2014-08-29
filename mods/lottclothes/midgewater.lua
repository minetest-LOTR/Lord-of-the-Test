-- the simplest outfit available.
-- made from green felt & wood (just cut down the nearest tree).

local level=1

-- cap (head)
minetest.register_tool("lottclothes:cap_midgewater", {
	description = "Midgewater Cap",
	inventory_image = "lottclothes_inv_cap_midgewater.png",
	groups = {armor_head=0, armor_heal=0, armor_use=WEAR_BASE_HEAD-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:cap_midgewater",
	recipe = {
		{"lottclothes:felt_green", "lottclothes:felt_green", "lottclothes:felt_green"},
		{"lottclothes:felt_green", "", "lottclothes:felt_green"},
		{"", "",""}
	}
})

-- jacket (torso)
minetest.register_tool("lottclothes:jacket_midgewater", {
	description = "Midgewater Jacket",
	inventory_image = "lottclothes_inv_jacket_midgewater.png",
	groups = {armor_torso=0, armor_heal=0, armor_use=WEAR_BASE_TORSO-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:jacket_midgewater",
	recipe = {
		{"lottclothes:felt_green", "", "lottclothes:felt_green"},
		{"lottclothes:felt_green", "lottclothes:felt_green", "lottclothes:felt_green"},
		{"lottclothes:felt_green", "lottclothes:felt_green", "lottclothes:felt_green"}
	}
})

-- pants (legs)
minetest.register_tool("lottclothes:pants_midgewater", {
	description = "Midgewater Pants",
	inventory_image = "lottclothes_inv_pants_midgewater.png",
	groups = {armor_legs=0, armor_heal=0, armor_use=WEAR_BASE_LEGS-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:pants_midgewater",
	recipe = {
		{"lottclothes:felt_green", "lottclothes:felt_green", "lottclothes:felt_green"},
		{"lottclothes:felt_green", "" , "lottclothes:felt_green"},
		{"lottclothes:felt_green", "" , "lottclothes:felt_green"}
	}
})

-- boots (feet)
minetest.register_tool("lottclothes:boots_midgewater", {
	description = "Midgewater Boots",
	inventory_image = "lottclothes_inv_boots_midgewater.png",
	groups = {armor_feet=0, armor_heal=0, armor_use=WEAR_BASE_FEET-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:boots_midgewater",
	recipe = {
		{"lottclothes:flax_brown", "", "lottclothes:flax_brown"},
		{"group:wood", "", "group:wood"}
	}
})
