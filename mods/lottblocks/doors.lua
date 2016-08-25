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

doors:register_door("lottblocks:ilmadris_door", {
                            description = "Ilmadris Door",
                            inventory_image = "lottblocks_ilmadris_door.png",
                            groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
                            tiles_bottom = {"lottblocks_ilmadris_door_b.png", "lottblocks_door_black.png"},
                            tiles_top = {"lottblocks_ilmadris_door_a.png", "lottblocks_door_black.png"},
                            only_placer_can_open = true,
                            custom_on_place = function(itemstack, placer, pointed_thing, def)
                                    lottblocks.set_door_races = function(fields)
                                            for i = 1, 5, 1 do
                                                    local race = lottclasses.races[i]
                                                    if fields[race] == "true" then
                                                            def.races[race] = true
                                                    end
                                            end
                                    end
                                    local formspec = "size[5.5,5.5]"..
                                            "label[0.5,0.5;Races: ]"..
                                            "checkbox[0.5,1.5;GAMEelf;Elves;false]"..
                                            "checkbox[0.5,2.5;GAMEman;Men;false]"..
                                            "checkbox[0.5,3.5;GAMEorc;Orcs;false]"..
                                            "checkbox[3.5,1.5;GAMEhobbit;Hobbits;false]"..
                                            "checkbox[3.5,2.5;GAMEdwarf;Dwarves;false]"..
                                            "button_exit[0.5,4.5;2,1;exit_button;Proceed]"
                                                    
                                            minetest.show_formspec(placer:get_player_name(), "door_races", formspec)
                            end,
                            races = {}
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
                if formname == "door_races" then
                        lottblocks.set_door_races(fields)
                end
end)

minetest.register_craft({
	output = "lottblocks:hobbit_door",
	recipe = {
		{"lottplants:birchwood", "lottplants:birchwood"},
		{"lottplants:birchwood", "lottplants:birchwood"},
		{"lottplants:birchwood", "lottplants:birchwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:human_door",
	recipe = {
		{"lottplants:alderwood", "lottplants:alderwood"},
		{"lottplants:alderwood", "lottplants:alderwood"},
		{"lottplants:alderwood", "lottplants:alderwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:elven_door",
	recipe = {
		{"lottplants:mallornwood", "lottplants:mallornwood"},
		{"lottplants:mallornwood", "lottplants:mallornwood"},
		{"lottplants:mallornwood", "lottplants:mallornwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:orc_door",
	recipe = {
		{"lottmapgen:mordor_stone", "lottmapgen:mordor_stone"},
		{"lottmapgen:mordor_stone", "lottmapgen:mordor_stone"},
		{"lottmapgen:mordor_stone", "lottmapgen:mordor_stone"},
	}
})

minetest.register_craft({
	output = "lottblocks:dwarf_door",
	recipe = {
		{"default:stone", "default:stone"},
		{"default:stone", "default:stone"},
		{"default:stone", "default:stone"},
	}
})
