minetest.register_node("lottblocks:dwarf_harp", {
	description = "Dwarvern Harp",
	tiles = {"lottblocks_harp1.png", "lottblocks_harp2.png", "lottblocks_harp3.png", "lottblocks_harp4.png", "lottblocks_harp5.png", "lottblocks_harp6.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	on_punch = function(pos)
		minetest.sound_play("lottblocks_harp", {
			pos=pos,
			max_hear_distance = 12,
			gain = 1,
		})
	end,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.0625, 0.125, -0.375, 0.125}, -- NodeBox1
			{-0.1875, -0.375, -0.0625, 0.1875, -0.25, 0.125}, -- NodeBox2
			{-0.0625, -0.25, -0.0625, 0.25, -0.125, 0.125}, -- NodeBox3
			{0.0625, -0.125, -0.0625, 0.3125, 0, 0.125}, -- NodeBox4
			{0.1875, -0.0625, -0.0625, 0.375, 0.125, 0.125}, -- NodeBox5
			{0.3125, 0.0625, -0.0625, 0.4375, 0.25, 0.125}, -- NodeBox6
			{0.4375, 0.25, -0.0625, 0.5, 0.375, 0.125}, -- NodeBox7
			{0.375, 0.375, -0.0625, 0.4375, 0.4375, 0.125}, -- NodeBox8
			{-0.1875, 0.4375, -0.0625, 0.375, 0.5, 0.125}, -- NodeBox9
			{-0.375, -0.375, -0.0625, -0.3125, -0.3125, 0.125}, -- NodeBox10
			{-0.4375, -0.3125, -0.0625, -0.375, 0.25, 0.125}, -- NodeBox11
			{-0.375, 0.25, -0.0625, -0.3125, 0.3125, 0.125}, -- NodeBox12
			{-0.3125, 0.3125, -0.0625, -0.25, 0.375, 0.125}, -- NodeBox13
			{-0.25, 0.375, -0.0625, -0.1875, 0.4375, 0.125}, -- NodeBox14
			{-0.3125, -0.375, 0, -0.25, 0.3125, 0.0625}, -- NodeBox15
			{-0.1875, -0.25, 0, -0.125, 0.4375, 0.0625}, -- NodeBox16
			{-0.0625, -0.125, 0, 0, 0.4375, 0.0625}, -- NodeBox17
			{0.0625, 0, 0, 0.125, 0.4375, 0.0625}, -- NodeBox18
			{0.1875, 0.09375, 0, 0.25, 0.4375, 0.0625}, -- NodeBox19
			{0.3125, 0.25, 0, 0.375, 0.4375, 0.0625}, -- NodeBox20
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.0625, 0.5, 0.5, 0.125}, -- NodeBox1
		}
	},
	groups = {instrument=1, cracky=1}
})

minetest.register_craftitem("lottblocks:dwarf_harp_strings", {
	description = "Dwarvern Harp Strings",
	inventory_image = "lottblocks_harp_strings.png",
})

minetest.register_craft({
	output = "lottblocks:dwarf_harp_strings",
	recipe = {
		{"farming:string", "lottores:silver_ingot", "farming:string"},
		{"farming:string", "lottores:silver_ingot", "farming:string"},
		{"farming:string", "lottores:silver_ingot", "farming:string"}
	}
})

minetest.register_craft({
	output = "lottblocks:dwarf_harp",
	recipe = {
		{"", "default:gold_ingot", ""},
		{"default:gold_ingot", "lottblocks:dwarf_harp_strings", "default:gold_ingot"},
		{"default:gold_ingot", "default:gold_ingot", ""}
	}
})
