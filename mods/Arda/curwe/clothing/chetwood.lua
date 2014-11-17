-- basic outfit from the chetwood forest.
-- made from green and brown felt & tin ingot.

local level=2

-- cap (head)
minetest.register_tool("curwe:cap_chetwood", {
	description = "Chetwood Cap",
	inventory_image = "curwe_inv_cap_chetwood.png",
	groups = {armor_head=0, armor_heal=0, armor_use=WEAR_BASE_HEAD-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:cap_chetwood",
	recipe = {
		{"curwe:felt_green", "curwe:felt_green", "curwe:felt_green"},
		{"cemen:tin_ingot", "", "cemen:tin_ingot"},
		{"", "",""}
	}
})

-- jacket (torso)
minetest.register_tool("curwe:jacket_chetwood", {
	description = "Chetwood Jacket",
	inventory_image = "curwe_inv_jacket_chetwood.png",
	groups = {armor_torso=0, armor_heal=0, armor_use=WEAR_BASE_TORSO-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:jacket_chetwood",
	recipe = {
		{"curwe:felt_green", "", "curwe:felt_green"},
		{"cemen:tin_ingot", "curwe:felt_green", "cemen:tin_ingot"},
		{"cemen:tin_ingot", "curwe:felt_green", "cemen:tin_ingot"}
	}
})

-- pants (legs)
minetest.register_tool("curwe:pants_chetwood", {
	description = "Chetwood Pants",
	inventory_image = "curwe_inv_pants_chetwood.png",
	groups = {armor_legs=0, armor_heal=0, armor_use=WEAR_BASE_LEGS-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:pants_chetwood",
	recipe = {
		{"curwe:felt_green", "curwe:felt_green", "curwe:felt_green"},
		{"cemen:tin_ingot", "" , "cemen:tin_ingot"},
		{"cemen:tin_ingot", "" , "cemen:tin_ingot"}
	}
})

-- boots (feet)
minetest.register_tool("curwe:boots_chetwood", {
	description = "Chetwood Boots",
	inventory_image = "curwe_inv_boots_chetwood.png",
	groups = {armor_feet=0, armor_heal=0, armor_use=WEAR_BASE_FEET-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:boots_chetwood",
	recipe = {
		{"curwe:felt_brown", "", "curwe:felt_brown"},
		{"cemen:tin_ingot", "", "cemen:tin_ingot"}
	}
})
