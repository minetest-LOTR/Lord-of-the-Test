minetest.register_tool("lottblocks:lockpick", {
    description = "Lockpick",
    inventory_image = "lottblocks_steel_lockpick.png", --Made by HeroOfTheWinds
        --https://github.com/HeroOfTheWinds/lockpicks/blob/master/textures/steel_lockpick.png
    max_stack = 1,
})

minetest.register_craft({
	output = "lottblocks:lockpick",
	recipe = {
		{"", "default:steel_ingot", "default:steel_ingot"},
		{"", "default:steel_ingot", ""},
		{"", "group:stick", ""}
	}
})

local function lockpick(itemstack, pos, race, player)
	if math.random(1, 4) ~= 3 then
		itemstack:add_wear(65535/20)
		minetest.chat_send_player(player, "Lockpick failed")
	else
		itemstack:add_wear(65535/18)
		minetest.show_formspec(player,
			"lottblocks:" .. race .. "_chest",
			default.get_chest_formspec(pos, "gui_" .. race .. "bg.png"))
		lottachievements.unlock(player, "thief")
	end
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
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
            local item = itemstack:get_name()
			if minetest.check_player_privs(player, {GAMEhobbit=true})
			or minetest.check_player_privs(player, {GAMEwizard=true}) then
				minetest.show_formspec(
					player, "lottblocks:hobbit_chest", default.get_chest_formspec(pos, "gui_hobbitbg.png")
				)
            elseif item == "lottblocks:lockpick" then
				lockpick(itemstack, pos, "hobbit", player)
			else
				minetest.chat_send_player(player, "Only Hobbits can open this kind of chest!")
			end
		end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos)
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
		on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Hobbit Chest")
			meta:set_string("formspec", "")
        end,
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
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
            local item = itemstack:get_name()
			if minetest.check_player_privs(player, {GAMEman=true})
			or minetest.check_player_privs(player, {GAMEwizard=true}) then
				minetest.show_formspec(
					player,
					"lottblocks:gondor_chest",
					default.get_chest_formspec(pos, "gui_gondorbg.png")
				)
            elseif item == "lottblocks:lockpick" then
                lockpick(itemstack, pos, "gondor", player)
			else
				minetest.chat_send_player(player, "Only Humans can open this kind of chest!")
			end
		end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
		on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Gondorian Chest")
			meta:set_string("formspec", "")
        end,
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
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
            local item = itemstack:get_name()
			if minetest.check_player_privs(player, {GAMEman=true})
			or minetest.check_player_privs(player, {GAMEwizard=true}) then
				minetest.show_formspec(
					player,
					"lottblocks:rohan_chest",
					default.get_chest_formspec(pos, "gui_rohanbg.png")
				)
            elseif item == "lottblocks:lockpick" then
                lockpick(itemstack, pos, "rohan", player)
			else
				minetest.chat_send_player(player, "Only Humans can open this kind of chest!")
			end
		end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
		on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Rohirrim Chest")
			meta:set_string("formspec", "")
        end,
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
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
            local item = itemstack:get_name()
			if minetest.check_player_privs(player, {GAMEelf=true})
			or minetest.check_player_privs(player, {GAMEwizard=true}) then
				minetest.show_formspec(
					player,
					"lottblocks:elfloth_chest",
					default.get_chest_formspec(pos, "gui_elfbg.png")
				)
            elseif item == "lottblocks:lockpick" then
                lockpick(itemstack, pos, "elf", player)
			else
				minetest.chat_send_player(player, "Only Elves can open this kind of chest!")
			end
		end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
		on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Elven (Lorien) Chest")
			meta:set_string("formspec", "")
        end,
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
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
            local item = itemstack:get_name()
			if minetest.check_player_privs(player, {GAMEelf=true})
			or minetest.check_player_privs(player, {GAMEwizard=true}) then
				minetest.show_formspec(
					player,
					"lottblocks:elfmirk_chest",
					default.get_chest_formspec(pos, "gui_elfbg.png")
				)
            elseif item == "lottblocks:lockpick" then
                lockpick(itemstack, pos, "elf", player)
			else
				minetest.chat_send_player(player, "Only Elves can open this kind of chest!")
			end
		end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
		on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Elven (Mirkwood) Chest")
			meta:set_string("formspec", "")
        end,
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
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
            local item = itemstack:get_name()
			if minetest.check_player_privs(player, {GAMEorc=true})
			or minetest.check_player_privs(player, {GAMEwizard=true}) then
				minetest.show_formspec(
					player,
					"lottblocks:mordor_chest",
					default.get_chest_formspec(pos, "gui_mordorbg.png")
				)
            elseif item == "lottblocks:lockpick" then
                lockpick(itemstack, pos, "mordor", player)
			else
				minetest.chat_send_player(player, "Only Orcs can open this kind of chest!")
			end
		end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
		on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Mordor Chest")
			meta:set_string("formspec", "")
        end,
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
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
            local item = itemstack:get_name()
			if minetest.check_player_privs(player, {GAMEorc=true})
			or minetest.check_player_privs(player, {GAMEwizard=true}) then
				minetest.show_formspec(
					player,
					"lottblocks:angmar_chest",
					default.get_chest_formspec(pos, "gui_angmarbg.png")
				)
            elseif item == "lottblocks:lockpick" then
                lockpick(itemstack, pos, "angmar", player)
			else
				minetest.chat_send_player(player, "Only Orcs can open this kind of chest!")
			end
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
			meta:set_string("formspec", "")
        end,
})

minetest.register_node("lottblocks:dwarf_chest", {
        description = "Dwarf Chest",
        tiles = {"lottblocks_dwarf_chest_top.png", "lottblocks_dwarf_chest_top.png", "lottblocks_dwarf_chest_side.png",
                "lottblocks_dwarf_chest_side.png", "lottblocks_dwarf_chest_side.png", "lottblocks_dwarf_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2},
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Dwarf Chest")
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
        end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
            local item = itemstack:get_name()
			if minetest.check_player_privs(player, {GAMEdwarf=true})
			or minetest.check_player_privs(player, {GAMEwizard=true}) then
				minetest.show_formspec(
					player,
					"lottblocks:dwarf_chest",
					default.get_chest_formspec(pos, "gui_dwarfbg.png")
				)
            elseif item == "lottblocks:lockpick" then
                lockpick(itemstack, pos, "dwarf", player)
			else
				minetest.chat_send_player(player, "Only Dwarfs can open this kind of chest!")
			end
		end,
    	can_dig = function(pos,player)
    		local meta = minetest.get_meta(pos);
    		local inv = meta:get_inventory()
    		return inv:is_empty("main")
    	end,
    	--backwards compatibility: punch to set formspec
    	on_punch = function(pos,player)
    	    local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Dwarf Chest")
			meta:set_string("formspec", "")
        end,
})

minetest.register_craft({
	output = "lottblocks:hobbit_chest",
	recipe = {
		{"lottplants:birchwood", "lottplants:birchwood", "lottplants:birchwood"},
		{"lottplants:birchwood", "default:chest", "lottplants:birchwood"},
		{"lottplants:birchwood", "lottplants:birchwood", "lottplants:birchwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:gondor_chest",
	recipe = {
		{"lottplants:alderwood", "lottplants:alderwood", "lottplants:alderwood"},
		{"lottplants:alderwood", "default:chest", "lottplants:alderwood"},
		{"lottplants:alderwood", "lottplants:alderwood", "lottplants:alderwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:rohan_chest",
	recipe = {
		{"lottplants:lebethronwood", "lottplants:lebethronwood", "lottplants:lebethronwood"},
		{"lottplants:lebethronwood", "default:chest", "lottplants:lebethronwood"},
		{"lottplants:lebethronwood", "lottplants:lebethronwood", "lottplants:lebethronwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:elfloth_chest",
	recipe = {
		{"lottplants:mallornwood", "lottplants:mallornwood", "lottplants:mallornwood"},
		{"lottplants:mallornwood", "default:chest", "lottplants:mallornwood"},
		{"lottplants:mallornwood", "lottplants:mallornwood", "lottplants:mallornwood"},
	}
})

minetest.register_craft({
	output = "lottblocks:elfmirk_chest",
	recipe = {
		{"default:junglewood", "default:junglewood", "default:junglewood"},
		{"default:junglewood", "default:chest", "default:junglewood"},
		{"default:junglewood", "default:junglewood", "default:junglewood"},
	}
})

minetest.register_craft({
	output = "lottblocks:mordor_chest",
	recipe = {
		{"lottmapgen:mordor_stone", "lottmapgen:mordor_stone", "lottmapgen:mordor_stone"},
		{"lottmapgen:mordor_stone", "default:chest", "lottmapgen:mordor_stone"},
		{"lottmapgen:mordor_stone", "lottmapgen:mordor_stone", "lottmapgen:mordor_stone"},
	}
})

minetest.register_craft({
	output = "lottblocks:angmar_chest",
	recipe = {
		{"lottplants:pinewood", "lottplants:pinewood", "lottplants:pinewood"},
		{"lottplants:pinewood", "default:chest", "lottplants:pinewood"},
		{"lottplants:pinewood", "lottplants:pinewood", "lottplants:pinewood"},
	}
})

minetest.register_craft({
	output = "lottblocks:dwarf_chest",
	recipe = {
		{"default:stone", "default:stone", "default:stone"},
		{"default:stone", "default:chest", "default:stone"},
		{"default:stone", "default:stone", "default:stone"},
	}
})


minetest.register_alias("lottmapgen:hobbit_chest", "lottblocks:hobbit_chest")
minetest.register_alias("lottmapgen:gondor_chest", "lottblocks:gondor_chest")
minetest.register_alias("lottmapgen:rohan_chest", "lottblocks:rohan_chest")
minetest.register_alias("lottmapgen:elfloth_chest", "lottblocks:elfloth_chest")
minetest.register_alias("lottmapgen:elfmirk_chest", "lottblocks:elfmirk_chest")
minetest.register_alias("lottmapgen:mordor_chest", "lottblocks:mordor_chest")
minetest.register_alias("lottmapgen:angmar_chest", "lottblocks:angmar_chest")
