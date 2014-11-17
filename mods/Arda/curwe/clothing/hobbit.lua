-- basic hobbit outfit.
-- made from varios flax (multi-color).
-- hasn't got headwear.

local fabric_colors = {
	blue   = "curwe:flax_blue",
	brown  = "curwe:flax_brown",
	green  = "curwe:flax_green",
	grey   = "curwe:flax_grey",
	pink   = "curwe:flax_pink",
	red    = "curwe:flax_red",
	white  = "curwe:flax_white",
	yellow = "curwe:flax_yellow"	
}

local level=2

--per color crafting :)
for color, fabric in pairs(fabric_colors) do

	-- shirt (torso)
	minetest.register_tool("curwe:shirt_hobbit_"..color, {
		description = color:gsub("^%l", string.upper).." Hobbit Shirt",
		inventory_image = "curwe_inv_shirt_hobbit_"..color..".png",
		groups = {armor_torso=0, armor_heal=0, armor_use=WEAR_BASE_TORSO-(WEAR_DECREASE*level)},
		wear = 0
	})

	minetest.register_craft({
		output = "curwe:shirt_hobbit_"..color,
		recipe = {
			{"curwe:flax_white", "", "curwe:flax_white"},
			{fabric, "curwe:flax_white", fabric},
			{fabric, fabric, fabric}
		}
	})	
	
	-- shorts(legs)
	minetest.register_tool("curwe:shorts_hobbit_"..color, {
		description = color:gsub("^%l", string.upper).." Hobbit Shorts",
		inventory_image = "curwe_inv_shorts_hobbit_"..color..".png",
		groups = {armor_legs=0, armor_heal=0, armor_use=WEAR_BASE_LEGS-(WEAR_DECREASE*level)},
		wear = 0
	})

	minetest.register_craft({
		output = "curwe:shorts_hobbit_"..color,
		recipe = {
			{fabric, fabric, fabric},
			{fabric, "", fabric},
			{"curwe:flax_white","" , "curwe:flax_white"}
		}
	})	
	
	-- shoes(feet)
	minetest.register_tool("curwe:shoes_hobbit_"..color, {
		description = color:gsub("^%l", string.upper).." Hobbit Shoes",
		inventory_image = "curwe_inv_shoes_hobbit_"..color..".png",
		groups = {armor_feet=0, armor_heal=0, armor_use=WEAR_BASE_FEET-(WEAR_DECREASE*level)},
		wear = 0
	})

	minetest.register_craft({
		output = "curwe:shoes_hobbit_"..color,
		recipe = {
			{fabric, "", fabric},
			{"curwe:flax_black","" , "curwe:flax_black"}
		}
	})	
		
end
