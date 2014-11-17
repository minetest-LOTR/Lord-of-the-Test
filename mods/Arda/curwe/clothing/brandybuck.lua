-- basic outfit from the the brandybuck family.
-- made from blue flax and copper ingot.
-- hasn't got headwear.

local level=2

-- shirt (torso)
minetest.register_tool("curwe:shirt_brandybuck", {
	description = "Brandybuck Shirt",
	inventory_image = "curwe_inv_shirt_brandybuck.png",
	groups = {armor_torso=0, armor_heal=0, armor_use=WEAR_BASE_TORSO-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:shirt_brandybuck",
	recipe = {
		{"curwe:flax_blue", "", "curwe:flax_blue"},
		{"curwe:flax_yellow", "curwe:flax_blue", "curwe:flax_yellow"},
		{"curwe:flax_yellow", "curwe:flax_blue", "curwe:flax_yellow"}
	}
})

-- trousers (legs)
minetest.register_tool("curwe:trousers_brandybuck", {
	description = "Brandybuck Trousers",
	inventory_image = "curwe_inv_trousers_brandybuck.png",
	groups = {armor_legs=0, armor_heal=0, armor_use=WEAR_BASE_LEGS-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:trousers_brandybuck",
	recipe = {
		{"curwe:flax_brown", "curwe:flax_brown", "curwe:flax_brown"},
		{"curwe:flax_brown", "" , "curwe:flax_brown"},
		{"curwe:flax_brown", "" , "curwe:flax_brown"}
	}
})

-- shoes (feet)
minetest.register_tool("curwe:shoes_brandybuck", {
	description = "Brandybuck Shoes",
	inventory_image = "curwe_inv_shoes_brandybuck.png",
	groups = {armor_feet=0, armor_heal=0, armor_use=WEAR_BASE_FEET-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:shoes_brandybuck",
	recipe = {
		{"curwe:flax_blue", "", "curwe:flax_blue"},
		{"default:copper_ingot", "", "default:copper_ingot"}
	}
})
