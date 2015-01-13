-- basic hobbit outfit.
-- made from varios flax (multi-color).
-- hasn't got headwear.

local fabric_colors = {
	blue   = "lottclothes:flax_blue",
	brown  = "lottclothes:flax_brown",
	green  = "lottclothes:flax_green",
	grey   = "lottclothes:flax_grey",
	pink   = "lottclothes:flax_pink",
	red    = "lottclothes:flax_red",
	white  = "lottclothes:flax_white",
	yellow = "lottclothes:flax_yellow"	
}

local level=2

--per color crafting :)
for color, fabric in pairs(fabric_colors) do

	-- shirt (torso)
	minetest.register_tool("lottclothes:shirt_hobbit_"..color, {
		description = color:gsub("^%l", string.upper).." Hobbit Shirt",
		inventory_image = "lottclothes_inv_shirt_hobbit_"..color..".png",
		groups = {armor_torso=0, armor_heal=0, armor_use=WEAR_BASE_TORSO-(WEAR_DECREASE*level)},
		wear = 0
	})

	minetest.register_craft({
		output = "lottclothes:shirt_hobbit_"..color,
		recipe = {
			{"lottclothes:flax_white", "", "lottclothes:flax_white"},
			{fabric, "lottclothes:flax_white", fabric},
			{fabric, fabric, fabric}
		}
	})	
	
	-- shorts(legs)
	minetest.register_tool("lottclothes:shorts_hobbit_"..color, {
		description = color:gsub("^%l", string.upper).." Hobbit Shorts",
		inventory_image = "lottclothes_inv_shorts_hobbit_"..color..".png",
		groups = {armor_legs=0, armor_heal=0, armor_use=WEAR_BASE_LEGS-(WEAR_DECREASE*level)},
		wear = 0
	})

	minetest.register_craft({
		output = "lottclothes:shorts_hobbit_"..color,
		recipe = {
			{fabric, fabric, fabric},
			{fabric, "", fabric},
			{"lottclothes:flax_white","" , "lottclothes:flax_white"}
		}
	})	
	
	-- shoes(feet)
	minetest.register_tool("lottclothes:shoes_hobbit_"..color, {
		description = color:gsub("^%l", string.upper).." Hobbit Shoes",
		inventory_image = "lottclothes_inv_shoes_hobbit_"..color..".png",
		groups = {armor_feet=0, armor_heal=0, armor_use=WEAR_BASE_FEET-(WEAR_DECREASE*level)},
		wear = 0
	})

	minetest.register_craft({
		output = "lottclothes:shoes_hobbit_"..color,
		recipe = {
			{fabric, "", fabric},
			{"lottclothes:flax_black","" , "lottclothes:flax_black"}
		}
	})	
		
end
