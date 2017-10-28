minetest.register_node("lottmapgen:hobbit_chest_spawner", {
	description = "HCS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:gondor_chest_spawner", {
	description = "GCS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:rohan_chest_spawner", {
	description = "RCS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:elfloth_chest_spawner", {
	description = "ELCS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:elfmirk_chest_spawner", {
	description = "EMCS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:mordor_chest_spawner", {
	description = "MCS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:angmar_chest_spawner", {
	description = "ACS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:dwarf_chest_spawner", {
	description = "DCS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:furnace_spawner", {
	description = "FURNS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("lottmapgen:dual_furnace_spawner", {
	description = "DFURNS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("lottmapgen:ringsilver_furnace_spawner", {
	description = "RSFURNS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("lottmapgen:ring_chest_spawner", {
	description = "RCS",
	tiles = {"lottother_air.png"},
	drop = "",
	drawtype = "airlike",
	groups = {not_in_creative_inventory=1},
})

local r = math.random

minetest.register_abm({
	nodenames = {"lottmapgen:hobbit_chest_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name="lottblocks:hobbit_chest", param2 = node.param2})
		local item_count = r(2, 13)
		local items_available = {
			[0] = "lottfarming:barley_seed 2",
			[1] = "lottfarming:barley_cooked",
			[2] = "lottfarming:berries_seed",
			[3] = "lottfarming:berries 3",
			[4] = "lottfarming:brown_mushroom_spore 3",
			[5] = "lottfarming:brown_mushroom 6",
			[6] = "lottfarming:corn_seed 4",
			[7] = "lottfarming:corn 4",
			[8] = "lottfarming:pipeweed_seed 2",
			[9] = "lottfarming:pipeweed 5",
			[10] = "lottfarming:pipeweed_cooked 5",
			[11] = "lottfarming:pipe",
			[12] = "lottfarming:potato_seed 2",
			[13] = "lottfarming:potato",
			[14] = "lottfarming:potato_cooked 7",
			[15] = "lottfarming:turnips_seed 3",
			[16] = "lottfarming:turnips",
			[17] = "lottfarming:turnips_cooked 7",
			[18] = "lottplants:plum",
			[19] = "lottweapons:bronze_dagger",
			[20] = "lottweapons:steel_dagger",
			[21] = "lottweapons:copper_spear",
			[22] = "lottweapons:tin_battleaxe",
			[23] = "vessels:glass_bottle 3",
			[24] = "farming:hoe_steel",
			[25] = "lottblocks:lore_scroll3"
		}
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for i = 0, item_count do
			local stack = r(0, 36)
			local item = items_available[r(0, 36)]
			if inv:get_stack("main", stack) ~= "" then
				stack = stack + 1
			end
			if item ~= nil then
				inv:set_stack("main", stack, item)
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:gondor_chest_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name="lottblocks:gondor_chest", param2 = node.param2})
		local item_count = r(2,13)
		local items_available = {
			[0] = "lottores:marble 6",
			[1] = "lottblocks:marble_brick 10",
			[2] = "lottarmor:helmet_silver",
			[3] = "lottarmor:chestplate_steel",
			[4] = "lottarmor:leggings_tin",
			[5] = "lottarmor:boots_bronze",
			[10] = "lottarmor:shield_copper",
			[11] = "lottores:goldsword",
			[12] = "default:sword_bronze",
			[13] = "farming:bread 5",
			[14] = "lottmobs:meat 2",
			[15] = "lottfarming:potato_cooked 4",
			[16] = "lottfarming:melon 3",
			[17] = "lottfarming:tomatoes_cooked 2",
			[18] = "lottfarming:corn 6",
			[19] = "lottfarming:turnips_cooked 3",
			[20] = "lottweapons:bronze_warhammer",
			[21] = "lottweapons:gold_spear",
			[22] = "lottweapons:copper_battleaxe",
			[23] = "lottweapons:galvorn_dagger",
			[24] = "lottpotion:beer 10",
			[25] = "lottpotion:cider 10",
			[26] = "lottpotion:wine 5",
			[27] = "lottpotion:wine 2",
			[29] = "lottthrowing:bow_wood_alder",
			[30] = "lottblocks:lore_scroll2"
		}
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for i = 0, item_count do
			local stack = r(0, 36)
			local item = items_available[r(0, 36)]
			if inv:get_stack("main", stack) ~= "" then
				stack = stack + 1
			end
			if item ~= nil then
				inv:set_stack("main", stack, item)
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:rohan_chest_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name="lottblocks:rohan_chest", param2 = node.param2})
		local item_count = r(2,13)
		local items_available = {
			[0] = "lottores:lead_block",
			[1] = "lottores:pearl 3",
			[2]="lottarmor:helmet_tin",
			[3]="lottarmor:chestplate_copper",
			[4]="lottarmor:leggings_bronze",
			[5]="lottarmor:boots_steel",
			[10]="lottarmor:shield_silver",
			[11]="lottores:silversword",
			[12]="lottweapons:bronze_spear",
			[13]="farming:bread 4",
			[14]="lottmobs:meat 6",
			[15]="lottfarming:potato_cooked 2",
			[16]="lottfarming:brown_mushroom 4",
			[17]="lottfarming:red_mushroom 3",
			[18]="lottfarming:corn 7",
			[19]="lottweapons:gold_spear",
			[20]="lottweapons:bronze_battleaxe",
			[21]="lottweapons:tin_spear",
			[22]="lottweapons:steel_spear",
			[23]="lottweapons:tin_dagger",
			[24]="lottpotion:ale 7",
			[25]="lottpotion:mead 7",
			[26]="lottpotion:wine 5",
			[27]="lottpotion:cider 2",
			[29]="lottmobs:horseh1",
			[30]="lottmobs:horsepegh1",
			[31]="lottmobs:horsepegh1",
			[32]="lottthrowing:crossbow_tin",
			[33]="lottthrowing:bolt 5"
		}
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for i = 0, item_count do
			local stack = r(0, 36)
			local item = items_available[r(0, 36)]
			if inv:get_stack("main", stack) ~= "" then
				stack = stack + 1
			end
			if item ~= nil then
				inv:set_stack("main", stack, item)
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:elfloth_chest_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name="lottblocks:elfloth_chest", param2 = node.param2})
		local item_count = r(2,13)
		local items_available = {
			[0] = "lottores:mithril_ingot",
			[1] = "default:gold_ingot 3",
			[2]="lottweapons:elven_sword",
			[3]="lottblocks:door_mallorn",
			[4]="lottblocks:bed_blue",
			[5]="lottblocks:fence_mallorn 3",
			[6]="lottblocks:mallorn_table",
			[9]="lottarmor:helmet_gold",
			[10]="lottblocks:mallorn_chair",
			[11]="lottores:silversword",
			[12]="lottweapons:silver_spear",
			[13]="lottweapons:silver_dagger",
			[14]="lottweapons:silver_warhammer",
			[15]="lottweapons:silver_battleaxe",
			[16]="lottores:silveraxe",
			[17]="lottores:silverpick",
			[18]="lottores:silvershovel",
			[19]="lottfarming:tomato_soup",
			[20]="lottfarming:mushroom_soup",
			[21]="lottfarming:salad",
			[22]="lottfarming:athelas_seed",
			[23]="lottfarming:athelas",
			[24]="lottplants:mallornsapling",
			[25]="lottpotion:mead 6",
			[26]="lottplants:honey 5",
			[27]="lottpotion:athelasbrew_power1",
			[29]="lottmobs:horsepegh1",
			[30]="lottpotion:athelasbrew_power1",
			[31]="lottthrowing:bow_wood_mallorn",
			[32]="lottthrowing:arrow 20",
			[34]="lottthrowing:arrow_fire_blue",
			[35]="lottthrowing:arrow_fire 3",
			[36]="lottblocks:elf_torch 10",
			[37]="lottores:white_gem", .. r(10, 41)
			[38] = "lottblocks:elven_rope "
		}
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for i = 0, item_count do
			local stack = r(0, 36)
			local item = items_available[r(0, 50)]
			if inv:get_stack("main", stack) ~= "" then
				stack = stack + 1
			end
			if item ~= nil then
				inv:set_stack("main", stack, item)
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:elfmirk_chest_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name="lottblocks:elfmirk_chest", param2 = node.param2})
		local item_count = r(2,13)
		local items_available = {
			[0] = "lottores:galvorn_ingot 3",
			[1] = "lottores:tin_ingot 5",
			[2] = "lottweapons:elven_sword",
			[3] = "lottblocks:door_alder",
			[4] = "lottblocks:bed_green",
			[5] = "lottblocks:fence_alder 5",
			[6] = "lottblocks:lebethron_table",
			[7] = "lottarmor:helmet_gold",
			[8] = "lottblocks:lebethron_chair",
			[9] = "lottores:galvornsword",
			[10] = "lottweapons:galvorn_spear",
			[11] = "lottweapons:galvorn_dagger",
			[12] = "bucket:bucket_water",
			[14] = "lottfarming:tomatoes_seed 3",
			[15] = "lottfarming:barley_seed 2",
			[16] = "lottfarming:berries_seed 6",
			[17] = "lottfarming:cabbage_seed 4",
			[18] = "lottfarming:mushroom_soup",
			[19] = "lottfarming:salad",
			[20] = "lottfarming:corn_seed",
			[21] = "lottfarming:melon_seed 2",
			[22] = "lottfarming:potato_seed 4",
			[23] = "lottfarming:turnips_seed 2",
			[24] = "lottfarming:blue_mushroom_spore 5",
			[27] = "lottfarming:brown_mushroom_spore 5",
			[29] = "lottmobs:horseh1",
			[30] = "lottfarming:green_mushroom_spore",
			[31] = "lottfarming:red_mushroom_spore",
			[32] = "lottthrowing:arrow 7",
			[34] = "lottthrowing:arrow_fire_blue",
			[35] = "lottthrowing:arrow_fire 3",
			[36] = "lottthrowing:bow_wood_lebethron",
			[37] = "lottores:blue_gem",
			[38] = "farming:hoe_bronze",
			[39] = "lottblocks:elven_rope", 
			[40] = "lottblocks:lore_scroll1 1" .. r(10, 41)
		}
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for i = 0, item_count do
			local stack = r(0, 36)
			local item = items_available[r(0, 50)]
			if inv:get_stack("main", stack) ~= "" then
				stack = stack + 1
			end
			if item ~= nil then
				inv:set_stack("main", stack, item)
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:mordor_chest_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name="lottblocks:mordor_chest", param2 = node.param2})
		local item_count = r(2,13)
		local items_available = {
			[0] = "lottmapgen:mordor_stone 6",
			[1] = "lottblocks:orc_brick 7",
			[2] = "lottblocks:orc_torch 4",
			[3] = "lottmobs:meat 5",
			[4] = "lottfarming:blue_mushroom",
			[5] = "lottfarming:green_mushroom",
			[6] = "lottthrowing:crossbow_steel",
			[7] = "lottthrowing:bolt 15",
			[8] = "lottthrowing:bolt_fire 2",
			[11] = "lottpotion:wine",
			[12] = "lottpotion:orcdraught_power1 2",
			[13] = "lottpotion:orcdraught_power2",
			[14] = "lottweapons:orc_sword",
			[15] = "bones:bone 3",
			[16] = "lottarmor:helmet_bronze",
			[17] = "lottarmor:chestplate_bronze",
			[18] = "lottarmor:leggings_bronze",
			[19] = "lottarmor:boots_bronze",
			[20] = "lottpotion:beer",
			[21] = "lottmobs:meat_raw",
			[22] = "bones:skeleton_body",
			[23] = "lottweapons:steel_warhammer",
			[24] = "lottfarming:blue_mushroom_spore 2",
			[25] = "lottmobs:horsearah1",
			[26] = "lottores:red_gem",
			[27] = "lottfarming:orc_food 4",
			[28] = "lottfarming:orc_medicine 2"
		}
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for i = 0, item_count do
			local stack = r(0, 36)
			local item = items_available[r(0, 36)]
			if inv:get_stack("main", stack) ~= "" then
				stack = stack + 1
			end
			if item ~= nil then
				inv:set_stack("main", stack, item)
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:angmar_chest_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name="lottblocks:angmar_chest", param2 = node.param2})
		local item_count = r(2, 13)
		local items_available = {
			[0] = "lottmapgen:angsnowblock 3",
			[1] = "lottblocks:orc_brick 7",
			[2] = "lottblocks:orc_torch 4",
			[3] = "lottmobs:meat 5",
			[4] = "lottfarming:blue_mushroom",
			[5] = "lottfarming:green_mushroom",
			[6] = "lottthrowing:bow_wood_birch",
			[7] = "lottthrowing:arrow 15",
			[8] = "lottthrowing:arrow_fire 2",
			[10] = "lottweapons:steel_battleaxe",
			[11] = "lottpotion:wine",
			[12] = "lottpotion:orcdraught_power1 2",
			[13] = "lottweapons:steel_battleaxe",
			[14] = "lottweapons:orc_sword",
			[15] = "bones:bone 3",
			[16] = "lottarmor:helmet_steel",
			[17] = "lottarmor:chestplate_steel",
			[18] = "lottarmor:leggings_steel",
			[19] = "lottarmor:boots_steel",
			[20] = "lottpotion:beer",
			[21] = "lottmobs:meat_raw",
			[22] = "bones:skeleton_body",
			[23] = "lottweapons:steel_warhammer",
			[24] = "default:sword_steel",
			[25] = "lottmobs:horsepegh1",
			[26] = "bones:bones",
			[27] = "lottfarming:orc_food 4",
			[28] = "lottfarming:orc_medicine 2"
		}
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for i = 0, item_count do
			local stack = r(0, 36)
			local item = items_available[r(0, 36)]
			if inv:get_stack("main", stack) ~= "" then
				stack = stack + 1
			end
			if item ~= nil then
				inv:set_stack("main", stack, item)
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:dwarf_chest_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name="lottblocks:dwarf_chest", param2 = node.param2})
		local item_count = r(1,9)
		local items_available = {
			[0] = "lottpotion:beer " .. r(1,10),
			[1] = "lottpotion:wine " .. r(2,6),
			[2] = "lottpotion:mead " .. r(2, 4),
			[3] = "lottpotion:ale " .. r(1, 15),
			[4] = "lottores:mithril_lump 2",
			[5] = "lottores:galvorn_ingot 3",
			[6] = "default:iron_lump " .. r(10, 20),
			[7] = "default:steel_ingot " .. r(5, 15),
			[8] = "lottores:tin_lump " .. r(5, 10),
			[9] = "default:copper_lump " .. r(5, 10),
			[10] = "lottplants:alderwood 13",
			[11] = "lottores:ithildin_stone_1 4",
			[12] = "lottores:ithildin_stonelamp_1 6",
			[13] = "lottthrowing:axe_dwarf " .. r(1, 4),
			[14] = "lottthrowing:axe_steel " .. r(1, 6),
			[15] = "lottthrowing:bow_wood_alder",
			[16] = "lottthrowing:arrow " .. r(5, 20),
			[17] = "lottores:goldsword",
			[18] = "lottweapons:gold_spear",
			[19] = "lottarmor:chestplate_gold",
			[20] = "lottarmor:helmet_gold",
			[21] = "lottarmor:leggings_gold",
			[22] = "lottarmor:boots_gold",
			[23] = "lottarmor:shield_gold",
			[24] = "default:gold_lump " .. r(6, 16),
			[25] = "default:gold_ingot " .. r(3, 9),
			[26] = "lottthrowing:crossbow_gold",
			[27] = "lottthrowing:bolt " .. r(5, 20),
			[28] = "lottblocks:dwarfstone_black " .. r(10, 20),
			[29] = "lottblocks:dwarfstone_white " .. r(10, 20),
			[30] = "lottmobs:meat " .. r(1, 7),
			[31] = "farming:bread " .. r(2, 10)
		}
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for i = 0, item_count do
			local stack = r(0, 36)
			local item = items_available[r(0, 36)]
			if inv:get_stack("main", stack) ~= "" then
				stack = stack + 1
			end
			if item ~= nil then
				inv:set_stack("main", stack, item)
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:ring_chest_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name="lottblocks:elfloth_chest", param2 = node.param2})
		local item_count = r(1,7)
		local items_available = {
			[0] = "default:gold_ingot " .. r(1, 10),
			[1] = "lottores:silver_ingot " .. r(1, 10),
			[2] = "lottother:pure_gold " .. r(1, 8),
			[3] = "lottother:pure_silver " .. r(1, 8),
			[4] = "lottother:goldsilver " .. r(1, 7),
			[5] = "lottores:rough_rock_lump " .. r(1, 8),
			[6] = "lottores:mithril_ingot " .. r(1, 5),
			[7] = "default:gold_lump " .. r(3, 7),
			[8] = "lottores:silver_lump " .. r(3, 7),
			[9] = "default:coalblock " .. r(1, 3),
			[10] = "lottother:ringsilver " .. r(1, 4),
			[11] = "lottother:stony_red_gem " .. r(1, 3),
			[12] = "lottother:stony_blue_gem " .. r(1, 3),
			[13] = "lottother:stony_white_gem " .. r(1, 3),
			[14] = "lottother:stony_purple_gem " .. r(1, 3),
			[15] = "lottother:unpolished_blue_gem",
			[16] = "lottother:unpolished_purple_gem",
			[17] = "lottother:uncut_red_gem",
			[18] = "lottother:uncut_white_gem",
			[19] = "lottother:quarter_ring " .. r(1, 4),
			[20] = "lottother:half_ring " .. r(1, 2),
			[21] = "lottother:ring",
			[22] = "lottother:pin " .. r(2, 10),
			[23] = "lottother:prepared_ring",
			[24] = "lottother:ring_furnace_inactive",
			[25] = "lottother:ringsilver_furnace_inactive",
			[26] = "lottfarming:corn " .. r(2, 10)
		}
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_stack("main", 1, "lottblocks:ring_guide")
		for i = 0, item_count do
			local stack = r(0, 36)
			local item = items_available[r(0, 36)]
			if inv:get_stack("main", stack) ~= "" then
				stack = stack + 1
			end
			if item ~= nil then
				inv:set_stack("main", stack, item)
			end
		end
    end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:furnace_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos)
		local p2 = minetest.get_node(pos).param2
		minetest.set_node(pos, {name = "default:furnace", param2 = p2})
	end
})

minetest.register_abm({
	nodenames = {"lottmapgen:dual_furnace_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos)
		local p2 = minetest.get_node(pos).param2
		minetest.set_node(pos, {name = "lottblocks:dual_furnace_inactive", param2 = p2})
	end
})

minetest.register_abm({
	nodenames = {"lottmapgen:ringsilver_furnace_spawner"},
	interval = 9,
	chance = 1,
	action = function(pos)
		local p2 = minetest.get_node(pos).param2
		minetest.set_node(pos, {name = "lottother:ringsilver_furnace_inactive", param2 = p2})
	end
})
