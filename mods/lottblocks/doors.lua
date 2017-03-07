doors:register_door("lottblocks:dwarf_door", {
                            description = "Dwarf Door",
                            inventory_image = "lottblocks_dwarf_door.png",
                            groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
                            tiles_bottom = {"lottblocks_dwarf_door_side_top.png", "lottblocks_dwarf_door_side_bottom.png",
                                            "lottblocks_dwarf_door_side_right.png", "lottblocks_dwarf_door_side_left.png",
                                            "lottblocks_dwarf_door_b.png", "lottblocks_dwarf_door_b.png"},
                            tiles_top = {"lottblocks_dwarf_door_side_top.png", "lottblocks_dwarf_door_side_bottom.png",
                                         "lottblocks_dwarf_door_side_right.png", "lottblocks_dwarf_door_side_left.png",
                                         "lottblocks_dwarf_door_a.png", "lottblocks_dwarf_door_a.png"},
                            races = {GAMEdwarf = true}
})

doors:register_door("lottblocks:elven_door", {
                            description = "Elven Door",
                            inventory_image = "lottblocks_elven_door.png",
                            groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
                            tiles_bottom = {"lottblocks_dwarf_door_side_top.png", "lottblocks_dwarf_door_side_bottom.png",
                                            "lottblocks_dwarf_door_side_right.png", "lottblocks_dwarf_door_side_left.png",
                                            "lottblocks_elven_door_b.png", "lottblocks_elven_door_b.png"},
                            tiles_top = {"lottblocks_dwarf_door_side_top.png", "lottblocks_dwarf_door_side_bottom.png",
                                         "lottblocks_dwarf_door_side_right.png", "lottblocks_dwarf_door_side_left.png",
                                         "lottblocks_elven_door_a.png", "lottblocks_elven_door_a.png"},
                            races = {GAMEelf = true}
})

doors:register_door("lottblocks:hobbit_door", {
                            description = "Hobbit Door",
                            inventory_image = "lottblocks_hobbit_door.png",
                            groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
                            tiles_bottom = {"lottblocks_hobbit_door_side_top.png", "lottblocks_hobbit_door_side_bottom.png",
                                            "lottblocks_hobbit_door_side_right.png", "lottblocks_hobbit_door_side_left.png",
                                            "lottblocks_hobbit_door_b.png", "lottblocks_hobbit_door_b.png"},
                            tiles_top = {"lottblocks_hobbit_door_side_top.png", "lottblocks_hobbit_door_side_bottom.png",
                                         "lottblocks_hobbit_door_side_right.png", "lottblocks_hobbit_door_side_left.png",
                                         "lottblocks_hobbit_door_a.png", "lottblocks_hobbit_door_a.png"},
                            races = {GAMEhobbit = true}
})

doors:register_door("lottblocks:orc_door", {
                            description = "Orc Door",
                            inventory_image = "lottblocks_orc_door.png",
                            groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
                            tiles_bottom = {"lottblocks_orc_door_side_top.png", "lottblocks_orc_door_side_bottom.png",
                                            "lottblocks_orc_door_side_right.png", "lottblocks_orc_door_side_left.png",
                                            "lottblocks_orc_door_b.png", "lottblocks_orc_door_b.png"},
                            tiles_top = {"lottblocks_orc_door_side_top.png", "lottblocks_orc_door_side_bottom.png",
                                         "lottblocks_orc_door_side_right.png", "lottblocks_orc_door_side_left.png",
                                         "lottblocks_orc_door_a.png", "lottblocks_orc_door_a.png"},
                            races = {GAMEorc = true}
})

doors:register_door("lottblocks:human_door", {
                            description = "Human Door",
                            inventory_image = "lottblocks_human_door.png",
                            groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
                            tiles_bottom = {"lottblocks_human_door_side_top.png", "lottblocks_human_door_side_bottom.png",
                                            "lottblocks_human_door_side_right.png", "lottblocks_human_door_side_left.png",
                                            "lottblocks_human_door_b.png", "lottblocks_human_door_b.png"},
                            tiles_top = {"lottblocks_human_door_side_top.png", "lottblocks_human_door_side_bottom.png",
                                         "lottblocks_human_door_side_right.png", "lottblocks_human_door_side_left.png",
                                         "lottblocks_human_door_a.png", "lottblocks_human_door_a.png"},
                            races = {GAMEman = true}
})

minetest.register_craft({
	output = "lottblocks:hobbit_door",
	recipe = {
		{"lottplants:birchwood", "lottplants:birchwood"},
		{"lottplants:birchwood", "lottores:silver_ingot"},
		{"lottplants:birchwood", "lottplants:birchwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:human_door",
	recipe = {
		{"lottplants:alderwood", "lottplants:alderwood"},
		{"lottplants:alderwood", "lottores:silver_ingot"},
		{"lottplants:alderwood", "lottplants:alderwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:elven_door",
	recipe = {
		{"lottplants:mallornwood", "lottplants:mallornwood"},
		{"lottplants:mallornwood", "lottores:silver_ingot"},
		{"lottplants:mallornwood", "lottplants:mallornwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:orc_door",
	recipe = {
		{"lottmapgen:mordor_stone", "lottmapgen:mordor_stone"},
		{"lottmapgen:mordor_stone", "lottores:silver_ingot"},
		{"lottmapgen:mordor_stone", "lottmapgen:mordor_stone"},
	}
})

minetest.register_craft({
	output = "lottblocks:dwarf_door",
	recipe = {
		{"default:stone", "default:stone"},
		{"default:stone", "lottores:silver_ingot"},
		{"default:stone", "default:stone"},
	}
})
