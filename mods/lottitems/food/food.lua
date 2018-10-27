minetest.register_node("lottitems:apple", {
	description = "Apple",
	drawtype = "plantlike",
	tiles = {"lottitems_apple.png"},
	inventory_image = "lottitems_apple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {hand = 3},
	on_use = minetest.item_eat(2),	

	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name = "lottitems:apple", param2 = 1})
		end
	end,
})