-- outfit from the ettenmoor region. wizard style (as possible).
-- made from grey and brown felt & gold ingot. 
-- it's difficult to make because dye:brown, dye:grey and cemen:gold.
-- hasn't got boots.

local level=4

-- hood (head)
minetest.register_tool("curwe:hood_ettenmoor", {
	description = "Ettenmoor Hood",
	inventory_image = "curwe_inv_hood_ettenmoor.png",
	groups = {armor_head=0, armor_heal=0, armor_use=WEAR_BASE_HEAD-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:hood_ettenmoor",
	recipe = {
		{"curwe:felt_grey", "curwe:felt_grey", "curwe:felt_grey"},
		{"curwe:felt_grey", "", "curwe:felt_grey"},
		{"", "",""}
	}
})

-- robe (torso (yeah limitations suck))
minetest.register_tool("curwe:robe_ettenmoor", {
	description = "Ettenmoor Robe",
	inventory_image = "curwe_inv_robe_ettenmoor.png",
	groups = {armor_torso=0, armor_heal=0, armor_use=WEAR_BASE_TORSO-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:robe_ettenmoor",
	recipe = {
		{"curwe:felt_grey", "", "curwe:felt_grey"},
		{"curwe:felt_grey", "curwe:felt_grey", "curwe:felt_grey"},
		{"curwe:felt_brown", "default:gold_ingot", "curwe:felt_brown"}
	}
})

-- trousers (legs)
minetest.register_tool("curwe:trousers_ettenmoor", {
	description = "Ettenmoor Trousers",
	inventory_image = "curwe_inv_trousers_ettenmoor.png",
	groups = {armor_legs=0, armor_heal=0, armor_use=WEAR_BASE_LEGS-(WEAR_DECREASE*level)},
	wear = 0
})

minetest.register_craft({
	output = "curwe:trousers_ettenmoor",
	recipe = {
		{"curwe:felt_grey", "curwe:felt_grey", "curwe:felt_grey"},
		{"curwe:felt_grey", "" , "curwe:felt_grey"},
		{"curwe:felt_grey", "" , "curwe:felt_grey"}
	}
})
