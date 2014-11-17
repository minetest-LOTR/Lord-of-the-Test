-- the simplest outfit available.
-- made from green felt & wood (just cut down the nearest tree).

local level=1

-- cap (head)
minetest.register_tool("curwe:cap_midgewater", {
	description = "Midgewater Cap",
	inventory_image = "curwe_inv_cap_midgewater.png",
	groups = {armor_head=0, armor_heal=0, armor_use=WEAR_BASE_HEAD-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:cap_midgewater",
	recipe = {
		{"curwe:felt_green", "curwe:felt_green", "curwe:felt_green"},
		{"curwe:felt_green", "", "curwe:felt_green"},
		{"", "",""}
	}
})

-- jacket (torso)
minetest.register_tool("curwe:jacket_midgewater", {
	description = "Midgewater Jacket",
	inventory_image = "curwe_inv_jacket_midgewater.png",
	groups = {armor_torso=0, armor_heal=0, armor_use=WEAR_BASE_TORSO-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:jacket_midgewater",
	recipe = {
		{"curwe:felt_green", "", "curwe:felt_green"},
		{"curwe:felt_green", "curwe:felt_green", "curwe:felt_green"},
		{"curwe:felt_green", "curwe:felt_green", "curwe:felt_green"}
	}
})

-- pants (legs)
minetest.register_tool("curwe:pants_midgewater", {
	description = "Midgewater Pants",
	inventory_image = "curwe_inv_pants_midgewater.png",
	groups = {armor_legs=0, armor_heal=0, armor_use=WEAR_BASE_LEGS-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:pants_midgewater",
	recipe = {
		{"curwe:felt_green", "curwe:felt_green", "curwe:felt_green"},
		{"curwe:felt_green", "" , "curwe:felt_green"},
		{"curwe:felt_green", "" , "curwe:felt_green"}
	}
})

-- boots (feet)
minetest.register_tool("curwe:boots_midgewater", {
	description = "Midgewater Boots",
	inventory_image = "curwe_inv_boots_midgewater.png",
	groups = {armor_feet=0, armor_heal=0, armor_use=WEAR_BASE_FEET-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:boots_midgewater",
	recipe = {
		{"curwe:flax_brown", "", "curwe:flax_brown"},
		{"group:wood", "", "group:wood"}
	}
})
