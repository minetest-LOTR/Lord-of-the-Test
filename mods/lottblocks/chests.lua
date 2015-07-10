local function chest_formspec(image)
	local formspec =
		"size[8,9]"..
		"list[current_name;main;0,0;8,4;]"..
		"list[current_player;main;0,5;8,4;]"..
    	"background[-0.5,-0.65;9,10.35;"..image.."]"..
    	"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"
	return formspec
end

minetest.register_node("lottblocks:hobbit_chest", {
        description = "Hobbit Chest",
        tiles = {"lottblocks_hobbit_chest_top.png", "lottblocks_hobbit_chest_top.png", "lottblocks_hobbit_chest_side.png",
                "lottblocks_hobbit_chest_side.png", "lottblocks_hobbit_chest_side.png", "lottblocks_hobbit_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2},
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Hobbit Chest")
           		meta:set_string("formspec",chest_folottblocks_rmspec("gui_hobbitbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos)
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
    	--backwards compatibility: punch to set formspec
    	on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Hobbit Chest")
           	meta:set_string("formspec",chest_formspec("gui_hobbitbg.png"))
        end
})

minetest.register_node("lottblocks:gondor_chest", {
        description = "Gondorian Chest",
        tiles = {"lottblocks_gondor_chest_top.png", "lottblocks_gondor_chest_bottom.png", "lottblocks_gondor_chest_side.png",
                "lottblocks_gondor_chest_side.png", "lottblocks_gondor_chest_side.png", "lottblocks_gondor_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2},
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Gondorian Chest")
           		meta:set_string("formspec",chest_formspec("gui_gondorbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
    	--backwards compatibility: punch to set formspec
    	on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Gondorian Chest")
           	meta:set_string("formspec",chest_formspec("gui_gondorbg.png"))
        end
})

minetest.register_node("lottblocks:rohan_chest", {
        description = "Rohirrim Chest",
        tiles = {"lottblocks_rohan_chest_top.png", "lottblocks_rohan_chest_bottom.png", "lottblocks_rohan_chest_side.png",
                "lottblocks_rohan_chest_side.png", "lottblocks_rohan_chest_side.png", "lottblocks_rohan_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2},
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Rohirrim Chest")
           		meta:set_string("formspec",chest_formspec("gui_rohanbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
    	--backwards compatibility: punch to set formspec
    	on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Rohirrim Chest")
           	meta:set_string("formspec",chest_formspec("gui_rohanbg.png"))
        end
})

minetest.register_node("lottblocks:elfloth_chest", {
        description = "Elven (Lorien) Chest",
        tiles = {"lottblocks_elf_chest_top.png", "lottblocks_elf_chest_bottom.png", "lottblocks_elf_chest_side.png",
                "lottblocks_elf_chest_side.png", "lottblocks_elf_chest_side.png", "lottblocks_elf_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2},
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Elven (Lorien) Chest")
           		meta:set_string("formspec",chest_formspec("gui_elfbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
    	--backwards compatibility: punch to set formspec
    	on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Elven (Lorien) Chest")
           	meta:set_string("formspec",chest_formspec("gui_elfbg.png"))
        end
})

minetest.register_node("lottblocks:elfmirk_chest", {
        description = "Elven (Mirkwood) Chest",
        tiles = {"lottblocks_elf_chest_top.png", "lottblocks_elf_chest_bottom.png", "lottblocks_elf_chest_side.png",
                "lottblocks_elf_chest_side.png", "lottblocks_elf_chest_side.png", "lottblocks_elf_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2},
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Elven (Mirkwood) Chest")
           		meta:set_string("formspec",chest_formspec("gui_elfbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
    	--backwards compatibility: punch to set formspec
    	on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Elven (Mirkwood) Chest")
           	meta:set_string("formspec",chest_formspec("gui_elfbg.png"))
        end
})

minetest.register_node("lottblocks:mordor_chest", {
        description = "Mordor Chest",
        tiles = {"lottblocks_mordor_chest_top.png", "lottblocks_mordor_chest_top.png", "lottblocks_mordor_chest_side.png",
                "lottblocks_mordor_chest_side.png", "lottblocks_mordor_chest_side.png", "lottblocks_mordor_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2},
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Mordor Chest")
           		meta:set_string("formspec",chest_formspec("gui_mordorbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
    	--backwards compatibility: punch to set formspec
    	on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Mordor Chest")
           	meta:set_string("formspec",chest_formspec("gui_mordorbg.png"))
        end
})

minetest.register_node("lottblocks:angmar_chest", {
        description = "Angmar Chest",
        tiles = {"lottblocks_angmar_chest_top.png", "lottblocks_angmar_chest_top.png", "lottblocks_angmar_chest_side.png",
                "lottblocks_angmar_chest_side.png", "lottblocks_angmar_chest_side.png", "lottblocks_angmar_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2},
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Angmar Chest")
           		meta:set_string("formspec",chest_formspec("gui_angmarbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
    	--backwards compatibility: punch to set formspec
    	on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Angmar Chest")
           	meta:set_string("formspec",chest_formspec("gui_angmarbg.png"))
        end
})

minetest.register_craft({
	output = "lottblocks:hobbit_chest",
	recipe = {
		{"lottplants:birchwood", "lottplants:birchwood", "lottplants:birchwood"},
		{"lottplants:birchwood", "", "lottplants:birchwood"},
		{"lottplants:birchwood", "lottplants:birchwood", "lottplants:birchwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:gondor_chest",
	recipe = {
		{"lottplants:alderwood", "lottplants:alderwood", "lottplants:alderwood"},
		{"lottplants:alderwood", "", "lottplants:alderwood"},
		{"lottplants:alderwood", "lottplants:alderwood", "lottplants:alderwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:rohan_chest",
	recipe = {
		{"lottplants:lebethronwood", "lottplants:lebethronwood", "lottplants:lebethronwood"},
		{"lottplants:lebethronwood", "", "lottplants:lebethronwood"},
		{"lottplants:lebethronwood", "lottplants:lebethronwood", "lottplants:lebethronwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:elfloth_chest",
	recipe = {
		{"lottplants:mallornwood", "lottplants:mallornwood", "lottplants:mallornwood"},
		{"lottplants:mallornwood", "", "lottplants:mallornwood"},
		{"lottplants:mallornwood", "lottplants:mallornwood", "lottplants:mallornwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:elfmirk_chest",
	recipe = {
		{"default:junglewood", "default:junglewood", "default:junglewood"},
		{"default:junglewood", "", "default:junglewood"},
		{"default:junglewood", "default:junglewood", "default:junglewood"},
	}
})

minetest.register_craft({
	output = "lottblocks:mordor_chest",
	recipe = {
		{"lottmapgen:mordor_stone", "lottmapgen:mordor_stone", "lottmapgen:mordor_stone"},
		{"lottmapgen:mordor_stone", "", "lottmapgen:mordor_stone"},
		{"lottmapgen:mordor_stone", "lottmapgen:mordor_stone", "lottmapgen:mordor_stone"},
	}
})

minetest.register_craft({
	output = "lottblocks:angmar_chest",
	recipe = {
		{"lottplants:pinewood", "lottplants:pinewood", "lottplants:pinewood"},
		{"lottplants:pinewood", "", "lottplants:pinewood"},
		{"lottplants:pinewood", "lottplants:pinewood", "lottplants:pinewood"},
	}
})

minetest.register_alias("lottmapgen:hobbit_chest", "lottblocks:hobbit_chest")
minetest.register_alias("lottmapgen:gondor_chest", "lottblocks:gondor_chest")
minetest.register_alias("lottmapgen:rohan_chest", "lottblocks:rohan_chest")
minetest.register_alias("lottmapgen:elfloth_chest", "lottblocks:elfloth_chest")
minetest.register_alias("lottmapgen:elfmirk_chest", "lottblocks:elfmirk_chest")
minetest.register_alias("lottmapgen:mordor_chest", "lottblocks:mordor_chest")
minetest.register_alias("lottmapgen:angmar_chest", "lottblocks:angmar_chest")
