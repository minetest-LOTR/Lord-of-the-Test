local function chest_formspec(image)
	local formspec =
		"size[8,9]"..
		"list[current_name;main;0,0;8,4;]"..
		"list[current_player;main;0,5;8,4;]"..
    	"background[-0.5,-0.65;9,10.35;"..image.."]"..
    	"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"
	return formspec
end

minetest.register_node("cemen:hobbit_chest", {
        description = "Hobbit Chest",
        tiles = {"hobbit_chest_top.png", "hobbit_chest_top.png", "hobbit_chest_side.png",
                "hobbit_chest_side.png", "hobbit_chest_side.png", "hobbit_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
        drop = "default:chest",
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Hobbit Chest")   
           		meta:set_string("formspec",chest_formspec("gui_hobbitbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
                local item_count = math.random(2,13)
                local items_available = { [0] = "olvar:barley_seed 2", [1] = "olvar:barley_cooked", [2]="olvar:berries_seed",[3]="olvar:berries 3",[4]="olvar:brown_mushroom_spore 3",[5]="olvar:brown_mushroom 6",[6]="olvar:corn_seed 4",[7]="olvar:corn 4",[8]="olvar:pipeweed_seed 2",[9]="olvar:pipeweed 5",[10]="olvar:pipeweed_cooked 5",[11]="olvar:pipe",[12]="olvar:potato_seed 2",[13]="olvar:potato",[14]="olvar:potato_cooked 7",[15]="olvar:turnips_seed 3",[16]="olvar:turnips",[17]="olvar:turnips_cooked 7",[18]="olvar:plum",[19]="curwe:bronze_dagger",[20]="curwe:steel_dagger",[21]="curwe:copper_spear",[22]="curwe:tin_battleaxe",[23]="vessels:glass_bottle 3",[24]="farming:hoe_steel"}
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,36)
                        inv:add_item("main",items_available[item_idx])
                end
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
  
minetest.register_node("cemen:gondor_chest", {
        description = "Gondorian Chest",
        tiles = {"gondor_chest_top.png", "gondor_chest_bottom.png", "gondor_chest_side.png",
                "gondor_chest_side.png", "gondor_chest_side.png", "gondor_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
        drop = "default:chest",
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Gondorian Chest")
           		meta:set_string("formspec",chest_formspec("gui_gondorbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
                local item_count = math.random(2,13)
                local items_available = { [0] = "cemen:marble 6", [1] = "curwe:marble_brick 10", [2]="curwe:helmet_silver",[3]="curwe:chestplate_steel",[4]="curwe:leggings_tin",[5]="curwe:boots_bronze",[6]="curwe:boots_gondor",[7]="curwe:leggings_gondor",[8]="curwe:chestplate_gondor",[9]="curwe:helmet_gondor",[10]="curwe:shield_copper",[11]="cemen:goldsword",[12]="default:sword_bronze",[13]="farming:bread 5",[14]="kelvar:meat 2",[15]="olvar:potato_cooked 4",[16]="olvar:melon 3",[17]="olvar:tomatoes_cooked 2",[18]="olvar:corn 6",[19]="olvar:turnips_cooked 3",[20]="curwe:bronze_warhammer",[21]="curwe:gold_spear",[22]="curwe:copper_battleaxe",[23]="curwe:galvorn_dagger",[24]="gul:beer 10",[25]="gul:cider 10",[26]="gul:wine 5",[27]="gul:strongwine 2",[28]="kelvar:gondor_guard_spawner",[29]="curwe:bow_wood_alder",[30]="kelvar:gondor_guard_spawner" }
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,42)
                        inv:add_item("main",items_available[item_idx])
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
            meta:set_string("infotext", "Gondorian Chest")
           	meta:set_string("formspec",chest_formspec("gui_gondorbg.png"))
        end
})    

minetest.register_node("cemen:rohan_chest", {
        description = "Rohirrim Chest",
        tiles = {"rohan_chest_top.png", "rohan_chest_bottom.png", "rohan_chest_side.png",
                "rohan_chest_side.png", "rohan_chest_side.png", "rohan_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
        drop = "default:chest",
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Rohirrim Chest")
           		meta:set_string("formspec",chest_formspec("gui_rohanbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
                local item_count = math.random(2,13)
                local items_available = { [0] = "cemen:lead_block", [1] = "cemen:pearl 3", [2]="curwe:helmet_tin",[3]="curwe:chestplate_copper",[4]="curwe:leggings_bronze",[5]="curwe:boots_steel",[6]="curwe:boots_rohan",[7]="curwe:leggings_rohan",[8]="curwe:chestplate_rohan",[9]="curwe:helmet_rohan",[10]="curwe:shield_silver",[11]="cemen:silversword",[12]="curwe:bronze_spear",[13]="farming:bread 4",[14]="kelvar:meat 6",[15]="olvar:potato_cooked 2",[16]="olvar:brown_mushroom 4",[17]="olvar:red_mushroom 3",[18]="olvar:corn 7",[19]="curwe:gold_spear",[20]="curwe:bronze_battleaxe",[21]="curwe:tin_spear",[22]="curwe:steel_spear",[23]="curwe:tin_dagger",[24]="gul:ale 7",[25]="gul:mead 7",[26]="gul:wine 5",[27]="gul:cider 2",[28]="kelvar:rohan_guard_spawner",[29]="kelvar:horseh1",[30]="kelvar:horsepegh1",[31]="kelvar:horsepegh1",[32]="curwe:crossbow_tin",[33]="curwe:bolt 5" }
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,45)
                        inv:add_item("main",items_available[item_idx])
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
            meta:set_string("infotext", "Rohirrim Chest")
           	meta:set_string("formspec",chest_formspec("gui_rohanbg.png"))
        end
})

minetest.register_node("cemen:elfloth_chest", {
        description = "Elven Chest",
        tiles = {"elf_chest_top.png", "elf_chest_bottom.png", "elf_chest_side.png",
                "elf_chest_side.png", "elf_chest_side.png", "elf_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
        drop = "default:chest",
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Elven Chest")
           		meta:set_string("formspec",chest_formspec("gui_elfbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
                local item_count = math.random(2,13)
                local items_available = { [0] = "cemen:mithril_ingot", [1] = "default:gold_ingot 3", [2]="curwe:elven_sword",[3]="curwe:door_mallorn",[4]="curwe:bed_blue",[5]="curwe:fence_mallorn 3",[6]="curwe:mallorn_table",[7]="curwe:leggings_elf",[8]="curwe:chestplate_elf",[9]="curwe:helmet_gold",[10]="curwe:mallorn_chair",[11]="cemen:silversword",[12]="curwe:silver_spear",[13]="curwe:silver_dagger",[14]="curwe:silver_warhammer",[15]="curwe:silver_battleaxe",[16]="cemen:silveraxe",[17]="cemen:silverpick",[18]="cemen:silvershovel",[19]="olvar:tomato_soup",[20]="olvar:mushroom_soup",[21]="olvar:salad",[22]="olvar:athelas_seed",[23]="olvar:athelas",[24]="olvar:mallornsapling",[25]="gul:mead 6",[26]="olvar:honey 5",[27]="gul:weakathelasbrew",[28]="kelvar:elven_guard_spawner",[29]="kelvar:horsepegh1",[30]="gul:weakathelasbrew",[31]="curwe:mallorn_wood_bow",[32]="curwe:arrow 20",[34]="curwe:arrow_fire_blue",[35]="curwe:arrow_fire 3",[36]="lottother:blue_torch 10",[37]="cemen:white_gem",[38]="curwe:boots_elf" }
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,50)
                        inv:add_item("main",items_available[item_idx])
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
            meta:set_string("infotext", "Elven Chest")
           	meta:set_string("formspec",chest_formspec("gui_elfbg.png"))
        end
})  
 
minetest.register_node("cemen:elfmirk_chest", {
        description = "Elven Chest",
        tiles = {"elf_chest_top.png", "elf_chest_bottom.png", "elf_chest_side.png",
                "elf_chest_side.png", "elf_chest_side.png", "elf_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
        drop = "default:chest",
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Elven Chest")
           		meta:set_string("formspec",chest_formspec("gui_elfbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
                local item_count = math.random(2,13)
                local items_available = { [0] = "cemen:galvorn_ingot 3", [1] = "cemen:tin_ingot 5", [2]="curwe:elven_sword",[3]="curwe:door_alder",[4]="curwe:bed_green",[5]="curwe:fence_alder 5",[6]="curwe:lebethron_table",[7]="curwe:leggings_elf",[8]="curwe:chestplate_elf",[9]="curwe:helmet_gold",[10]="curwe:lebethron_chair",[11]="cemen:galvornsword",[12]="curwe:galvorn_spear",[13]="curwe:galvorn_dagger",[14]="bucket:bucket_water",[15]="curwe:boots_elf",[16]="olvar:tomatoes_seed 3",[17]="olvar:barley_seed 2",[18]="olvar:berries_seed 6",[19]="olvar:cabbage_seed 4",[20]="olvar:mushroom_soup",[21]="olvar:salad",[22]="olvar:corn_seed",[23]="olvar:melon_seed 2",[24]="olvar:potato_seed 4",[25]="olvar:turnips_seed 2",[26]="olvar:blue_mushroom_spore 5",[27]="olvar:brown_mushroom_spore 5",[28]="kelvar:elven_guard_spawner",[29]="horseh1",[30]="olvar:green_mushroom_spore",[31]="olvar:red_mushroom_spore",[32]="curwe:arrow 7",[34]="curwe:arrow_fire_blue",[35]="curwe:arrow_fire 3",[36]="curwe:lebethron_wood_bow",[37]="cemen:blue_gem",[38]="farming:hoe_bronze" }
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,50)
                        inv:add_item("main",items_available[item_idx])
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
            meta:set_string("infotext", "Elven Chest")
           	meta:set_string("formspec",chest_formspec("gui_elfbg.png"))
        end
})  

minetest.register_node("cemen:mordor_chest", {
        description = "Mordor Chest",
        tiles = {"mordor_chest_top.png", "mordor_chest_top.png", "mordor_chest_side.png",
                "mordor_chest_side.png", "mordor_chest_side.png", "mordor_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
        drop = "default:chest",
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Mordor Chest")
           		meta:set_string("formspec",chest_formspec("gui_mordorbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
                local item_count = math.random(2,13)
                local items_available = { [0] = "cemen:mordor_stone 6", [1] = "curwe:orc_brick 7", [2]="lottother:orc_torch 4",[3]="kelvar:meat 5",[4]="olvar:blue_mushroom",[5]="olvar:green_mushroom",[6]="curwe:crossbow_steel",[7]="curwe:bolt 15",[8]="curwe:bolt_fire 2",[9]="kelvar:orc_guard_spawner",[10]="kelvar:uruk_hai_guard_spawner",[11]="gul:strongwine",[12]="gul:weakorcdraught 2",[13]="gul:strongorcdraught",[14]="curwe:orc_sword",[15]="bones:bone 3",[16]="curwe:helmet_bronze",[17]="curwe:chestplate_bronze",[18]="curwe:leggings_bronze",[19]="curwe:boots_bronze",[20]="gul:beer",[21]="kelvar:meat_raw", [22]="bones:skeleton_body", [23]= "curwe:steel_warhammer",[24]= "olvar:blue_mushroom_spore 2",[25]="kelvar:horsearah1",[26]="cemen:red_gem"  }
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,38)
                        inv:add_item("main",items_available[item_idx])
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
            meta:set_string("infotext", "Mordor Chest")
           	meta:set_string("formspec",chest_formspec("gui_mordorbg.png"))
        end
})  

minetest.register_node("cemen:angmar_chest", {
        description = "Angmar Chest",
        tiles = {"angmar_chest_top.png", "angmar_chest_top.png", "angmar_chest_side.png",
                "angmar_chest_side.png", "angmar_chest_side.png", "angmar_chest_front.png"},
        paramtype2 = "facedir",
        groups = {choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
        drop = "default:chest",
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos, node, active_object_count, active_object_count_wider)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Angmar Chest")
           		meta:set_string("formspec",chest_formspec("gui_angmarbg.png"))
                local inv = meta:get_inventory()
                inv:set_size("main", 8*4)
                local item_count = math.random(2,13)
                local items_available = { [0] = "cemen:angsnowblock 3", [1] = "curwe:orc_brick 7", [2]="lottother:orc_torch 4",[3]="kelvar:meat 5",[4]="olvar:blue_mushroom",[5]="olvar:green_mushroom",[6]="curwe:bow_wood_birch",[7]="curwe:arrow 15",[8]="curwe:arrow_fire 2",[9]="kelvar:orc_guard_spawner",[10]="curwe:steel_battleaxe",[11]="gul:strongwine",[12]="gul:weakorcdraught 2",[13]="curwe:steel_battleaxe",[14]="curwe:orc_sword",[15]="bones:bone 3",[16]="curwe:helmet_steel",[17]="curwe:chestplate_steel",[18]="curwe:leggings_steel",[19]="curwe:boots_steel",[20]="gul:beer",[21]="kelvar:meat_raw", [22]="bones:skeleton_body", [23]= "curwe:steel_warhammer",[24]= "default:sword_steel",[25]="kelvar:horsepegh1",[26]="bones:bones"  }
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                for i = 0, item_count do
                        local item_idx = math.random(0,38)
                        inv:add_item("main",items_available[item_idx])
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
           	meta:set_string("formspec",chest_formspec("gui_angmarbg.png"))
        end
})                      

minetest.register_node("cemen:hobbit_chest_spawner", {
	description = "HCS",
	tiles = {"curwe_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})                  
minetest.register_node("cemen:gondor_chest_spawner", {
	description = "GCS",
	tiles = {"curwe_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})          
minetest.register_node("cemen:rohan_chest_spawner", {
	description = "RCS",
	tiles = {"curwe_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})      
minetest.register_node("cemen:elfloth_chest_spawner", {
	description = "ELCS",
	tiles = {"curwe_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})         
minetest.register_node("cemen:elfmirk_chest_spawner", {
	description = "EMCS",
	tiles = {"curwe_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})      
minetest.register_node("cemen:mordor_chest_spawner", {
	description = "MCS",
	tiles = {"curwe_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})   
minetest.register_node("cemen:angmar_chest_spawner", {
	description = "ACS",
	tiles = {"curwe_door_birch_b.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory=1},
})

minetest.register_abm({
        nodenames = {"cemen:hobbit_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="cemen:hobbit_chest"})
        end,
})
minetest.register_abm({
        nodenames = {"cemen:gondor_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="cemen:gondor_chest"})
        end,
})
minetest.register_abm({
        nodenames = {"cemen:rohan_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="cemen:rohan_chest"})
        end,
})
minetest.register_abm({
        nodenames = {"cemen:elfloth_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="cemen:elfloth_chest"})
        end,
})
minetest.register_abm({
        nodenames = {"cemen:elfmirk_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="cemen:elfmirk_chest"})
        end,
})
minetest.register_abm({
        nodenames = {"cemen:mordor_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="cemen:mordor_chest"})
        end,
})
minetest.register_abm({
        nodenames = {"cemen:angmar_chest_spawner"},
        interval = 9,
        chance = 1,
        action = function(pos, node, active_object_count, active_object_count_wider)
                local x = pos.x
                local y = pos.y
                local z = pos.z
                local here = {x=x,y=y,z=z}
                minetest.set_node(here, {name="cemen:angmar_chest"})
        end,
})


