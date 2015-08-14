minetest.register_node("lottmapgen:hobbit_chest_spawner", {
	description = "HCS",
	tiles = {"lottblocks_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:gondor_chest_spawner", {
	description = "GCS",
	tiles = {"lottblocks_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:rohan_chest_spawner", {
	description = "RCS",
	tiles = {"lottblocks_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:elfloth_chest_spawner", {
	description = "ELCS",
	tiles = {"lottblocks_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:elfmirk_chest_spawner", {
	description = "EMCS",
	tiles = {"lottblocks_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:mordor_chest_spawner", {
	description = "MCS",
	tiles = {"lottblocks_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:angmar_chest_spawner", {
	description = "ACS",
	tiles = {"lottblocks_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})

minetest.register_abm({
        nodenames = {"lottmapgen:hobbit_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="lottblocks:hobbit_chest"})
				local item_count = math.random(2,13)
                local items_available = { [0] = "lottfarming:barley_seed 2", [1] = "lottfarming:barley_cooked", [2]="lottfarming:berries_seed",[3]="lottfarming:berries 3",[4]="lottfarming:brown_mushroom_spore 3",[5]="lottfarming:brown_mushroom 6",[6]="lottfarming:corn_seed 4",[7]="lottfarming:corn 4",[8]="lottfarming:pipeweed_seed 2",[9]="lottfarming:pipeweed 5",[10]="lottfarming:pipeweed_cooked 5",[11]="lottfarming:pipe",[12]="lottfarming:potato_seed 2",[13]="lottfarming:potato",[14]="lottfarming:potato_cooked 7",[15]="lottfarming:turnips_seed 3",[16]="lottfarming:turnips",[17]="lottfarming:turnips_cooked 7",[18]="lottplants:plum",[19]="lottweapons:bronze_dagger",[20]="lottweapons:steel_dagger",[21]="lottweapons:copper_spear",[22]="lottweapons:tin_battleaxe",[23]="vessels:glass_bottle 3",[24]="farming:hoe_steel"}
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,36)
                        inv:add_item("main",items_available[item_idx])
                end
        end,
})
minetest.register_abm({
        nodenames = {"lottmapgen:gondor_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="lottblocks:gondor_chest"})
				local item_count = math.random(2,13)
                local items_available = { [0] = "lottores:marble 6", [1] = "lottblocks:marble_brick 10", [2]="lottarmor:helmet_silver",[3]="lottarmor:chestplate_steel",[4]="lottarmor:leggings_tin",[5]="lottarmor:boots_bronze",[10]="lottarmor:shield_copper",[11]="lottores:goldsword",[12]="default:sword_bronze",[13]="farming:bread 5",[14]="lottmobs:meat 2",[15]="lottfarming:potato_cooked 4",[16]="lottfarming:melon 3",[17]="lottfarming:tomatoes_cooked 2",[18]="lottfarming:corn 6",[19]="lottfarming:turnips_cooked 3",[20]="lottweapons:bronze_warhammer",[21]="lottweapons:gold_spear",[22]="lottweapons:copper_battleaxe",[23]="lottweapons:galvorn_dagger",[24]="lottpotion:beer 10",[25]="lottpotion:cider 10",[26]="lottpotion:wine 5",[27]="lottpotion:wine 2",[29]="lottthrowing:bow_wood_alder" }
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,42)
                        inv:add_item("main",items_available[item_idx])
                end
        end,
})
minetest.register_abm({
        nodenames = {"lottmapgen:rohan_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="lottblocks:rohan_chest"})
				local item_count = math.random(2,13)
                local items_available = { [0] = "lottores:lead_block", [1] = "lottores:pearl 3", [2]="lottarmor:helmet_tin",[3]="lottarmor:chestplate_copper",[4]="lottarmor:leggings_bronze",[5]="lottarmor:boots_steel",[10]="lottarmor:shield_silver",[11]="lottores:silversword",[12]="lottweapons:bronze_spear",[13]="farming:bread 4",[14]="lottmobs:meat 6",[15]="lottfarming:potato_cooked 2",[16]="lottfarming:brown_mushroom 4",[17]="lottfarming:red_mushroom 3",[18]="lottfarming:corn 7",[19]="lottweapons:gold_spear",[20]="lottweapons:bronze_battleaxe",[21]="lottweapons:tin_spear",[22]="lottweapons:steel_spear",[23]="lottweapons:tin_dagger",[24]="lottpotion:ale 7",[25]="lottpotion:mead 7",[26]="lottpotion:wine 5",[27]="lottpotion:cider 2",[29]="lottmobs:horseh1",[30]="lottmobs:horsepegh1",[31]="lottmobs:horsepegh1",[32]="lottthrowing:crossbow_tin",[33]="lottthrowing:bolt 5" }
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,45)
                        inv:add_item("main",items_available[item_idx])
                end
        end,
})
minetest.register_abm({
        nodenames = {"lottmapgen:elfloth_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="lottblocks:elfloth_chest"})
				local item_count = math.random(2,13)
                local items_available = { [0] = "lottores:mithril_ingot", [1] = "default:gold_ingot 3", [2]="lottweapons:elven_sword",[3]="lottblocks:door_mallorn",[4]="lottblocks:bed_blue",[5]="lottblocks:fence_mallorn 3",[6]="lottblocks:mallorn_table",[9]="lottarmor:helmet_gold",[10]="lottblocks:mallorn_chair",[11]="lottores:silversword",[12]="lottweapons:silver_spear",[13]="lottweapons:silver_dagger",[14]="lottweapons:silver_warhammer",[15]="lottweapons:silver_battleaxe",[16]="lottores:silveraxe",[17]="lottores:silverpick",[18]="lottores:silvershovel",[19]="lottfarming:tomato_soup",[20]="lottfarming:mushroom_soup",[21]="lottfarming:salad",[22]="lottfarming:athelas_seed",[23]="lottfarming:athelas",[24]="lottplants:mallornsapling",[25]="lottpotion:mead 6",[26]="lottplants:honey 5",[27]="lottpotion:athelasbrew_power1",[29]="lottmobs:horsepegh1",[30]="lottpotion:athelasbrew_power1",[31]="lottthrowing:bow_wood_mallorn",[32]="lottthrowing:arrow 20",[34]="lottthrowing:arrow_fire_blue",[35]="lottthrowing:arrow_fire 3",[36]="lottother:blue_torch 10",[37]="lottores:white_gem", }
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,50)
                        inv:add_item("main",items_available[item_idx])
                end
        end,
})
minetest.register_abm({
        nodenames = {"lottmapgen:elfmirk_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="lottblocks:elfmirk_chest"})
				local item_count = math.random(2,13)
                local items_available = { [0] = "lottores:galvorn_ingot 3", [1] = "lottores:tin_ingot 5", [2]="lottweapons:elven_sword",[3]="lottblocks:door_alder",[4]="lottblocks:bed_green",[5]="lottblocks:fence_alder 5",[6]="lottblocks:lebethron_table",[7]="lottarmor:helmet_gold",[8]="lottblocks:lebethron_chair",[9]="lottores:galvornsword",[10]="lottweapons:galvorn_spear",[11]="lottweapons:galvorn_dagger",[12]="bucket:bucket_water",[14]="lottfarming:tomatoes_seed 3",[15]="lottfarming:barley_seed 2",[16]="lottfarming:berries_seed 6",[17]="lottfarming:cabbage_seed 4",[18]="lottfarming:mushroom_soup",[19]="lottfarming:salad",[20]="lottfarming:corn_seed",[21]="lottfarming:melon_seed 2",[22]="lottfarming:potato_seed 4",[23]="lottfarming:turnips_seed 2",[24]="lottfarming:blue_mushroom_spore 5",[27]="lottfarming:brown_mushroom_spore 5",[29]="lottmobs:horseh1",[30]="lottfarming:green_mushroom_spore",[31]="lottfarming:red_mushroom_spore",[32]="lottthrowing:arrow 7",[34]="lottthrowing:arrow_fire_blue",[35]="lottthrowing:arrow_fire 3",[36]="lottthrowing:bow_wood_lebethron",[37]="lottores:blue_gem",[38]="farming:hoe_bronze" }
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,50)
                        inv:add_item("main",items_available[item_idx])
                end
        end,
})
minetest.register_abm({
        nodenames = {"lottmapgen:mordor_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="lottblocks:mordor_chest"})
				local item_count = math.random(2,13)
                local items_available = { [0] = "lottmapgen:mordor_stone 6", [1] = "lottblocks:orc_brick 7", [2]="lottother:orc_torch 4",[3]="lottmobs:meat 5",[4]="lottfarming:blue_mushroom",[5]="lottfarming:green_mushroom",[6]="lottthrowing:crossbow_steel",[7]="lottthrowing:bolt 15",[8]="lottthrowing:bolt_fire 2",[11]="lottpotion:wine",[12]="lottpotion:orcdraught_power1 2",[13]="lottpotion:orcdraught_power2",[14]="lottweapons:orc_sword",[15]="bones:bone 3",[16]="lottarmor:helmet_bronze",[17]="lottarmor:chestplate_bronze",[18]="lottarmor:leggings_bronze",[19]="lottarmor:boots_bronze",[20]="lottpotion:beer",[21]="lottmobs:meat_raw", [22]="bones:skeleton_body", [23]= "lottweapons:steel_warhammer",[24]= "lottfarming:blue_mushroom_spore 2",[25]="lottmobs:horsearah1",[26]="lottores:red_gem", [27]="lottfarming:orc_food 4", [28]="lottfarming:orc_medicine 2"}
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,38)
                        inv:add_item("main",items_available[item_idx])
                end
        end,
})
minetest.register_abm({
        nodenames = {"lottmapgen:angmar_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="lottblocks:angmar_chest"})
				local item_count = math.random(2,13)
                local items_available = { [0] = "lottmapgen:angsnowblock 3", [1] = "lottblocks:orc_brick 7", [2]="lottother:orc_torch 4",[3]="lottmobs:meat 5",[4]="lottfarming:blue_mushroom",[5]="lottfarming:green_mushroom",[6]="lottthrowing:bow_wood_birch",[7]="lottthrowing:arrow 15",[8]="lottthrowing:arrow_fire 2",[10]="lottweapons:steel_battleaxe",[11]="lottpotion:wine",[12]="lottpotion:orcdraught_power1 2",[13]="lottweapons:steel_battleaxe",[14]="lottweapons:orc_sword",[15]="bones:bone 3",[16]="lottarmor:helmet_steel",[17]="lottarmor:chestplate_steel",[18]="lottarmor:leggings_steel",[19]="lottarmor:boots_steel",[20]="lottpotion:beer",[21]="lottmobs:meat_raw", [22]="bones:skeleton_body", [23]= "lottweapons:steel_warhammer",[24]= "default:sword_steel",[25]="lottmobs:horsepegh1",[26]="bones:bones", [27]="lottfarming:orc_food 4", [28]="lottfarming:orc_medicine 2"}
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,38)
                        inv:add_item("main",items_available[item_idx])
                end
        end,
})
