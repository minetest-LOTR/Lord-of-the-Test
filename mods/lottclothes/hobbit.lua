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
		groups = {armor_torso=0, armor_heal=0, clothes=1, clothes_torso=1},
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
		groups = {armor_legs=0, armor_heal=0, clothes=1, clothes_legs=1},
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
		groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_feet=1},
		wear = 0
	})

	minetest.register_craft({
		output = "lottclothes:shoes_hobbit_"..color,
		recipe = {
			{fabric, "", fabric},
			{"lottclothes:flax_black","" , "lottclothes:flax_black"}
		}
	})

	-- cloak
	minetest.register_tool("lottclothes:cloak_hobbit_"..color, {
		description = color:gsub("^%l", string.upper).." Hobbit Cloak",
		inventory_image = "lottclothes_inv_cloak_hobbit_"..color..".png",
		groups = {armor_heal=0, clothes=1, no_preview = 1, clothes_cloak=1},
		wear = 0
	})

	minetest.register_craft({
		output = "lottclothes:cloak_hobbit_"..color,
		recipe = {
			{fabric, fabric},
			{fabric, fabric},
			{fabric, fabric}
		}
	})

end
