minetest.register_craftitem("spawneggs:chicken", {
	description = "Mithril sword",
	inventory_image = "lottores_mithrilsword.png",
	on_use = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "lottmobs:chicken")
		end
		return itemstack
	end,
})

