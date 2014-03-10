minetest.register_node("lottpotion:cauldron_full",{
    drawtype="nodebox",
	description= "Filled Cauldron",
    tiles = {"lottpotion_cauldron_top.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png",
		"lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
    groups = {choppy=2},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.500000,-0.375000,-0.500000,-0.375000,0.500000,0.500000}, 
            {0.375000,-0.375000,-0.500000,0.500000,0.500000,0.500000}, 
            {-0.500000,-0.375000,-0.500000,0.500000,0.500000,-0.375000}, 
            {-0.500000,-0.375000,0.375000,0.500000,0.500000,0.500000},
            {-0.500000,-0.312500,-0.500000,0.500000,0.312500,0.500000}, 
            {-0.500000,-0.500000,-0.500000,-0.375000,0.500000,-0.375000}, 
            {0.375000,-0.500000,-0.500000,0.500000,0.500000,-0.375000}, 
            {0.375000,-0.500000,0.375000,0.500000,0.500000,0.500000}, 
            {-0.500000,-0.500000,0.375000,-0.375000,0.500000,0.500000}, 
        }
    }
})

minetest.register_node("lottpotion:cauldron_two_third_full",{
    drawtype="nodebox",
    description= "Two Third Filled Cauldron",
    tiles = {"lottpotion_cauldron_top.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png",
		"lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png"},
	paramtype2 = "facedir",
    groups = {choppy=2, not_in_creative_inventory=1},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.500000,-0.375000,-0.500000,-0.375000,0.500000,0.500000}, 
            {0.375000,-0.375000,-0.500000,0.500000,0.500000,0.500000}, 
            {-0.500000,-0.375000,-0.500000,0.500000,0.500000,-0.375000}, 
            {-0.500000,-0.375000,0.375000,0.500000,0.500000,0.500000},
            {-0.500000,-0.312500,-0.500000,0.500000,0.125000,0.500000}, 
            {-0.500000,-0.500000,-0.500000,-0.375000,0.500000,-0.375000}, 
            {0.375000,-0.500000,-0.500000,0.500000,0.500000,-0.375000}, 
            {0.375000,-0.500000,0.375000,0.500000,0.500000,0.500000}, 
            {-0.500000,-0.500000,0.375000,-0.375000,0.500000,0.500000}, 
        }
    }
})

minetest.register_node("lottpotion:cauldron_one_third_full",{
    drawtype="nodebox",
	description= "One Third Filled Cauldron",
    tiles = {"lottpotion_cauldron_top.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png",
		"lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png", "lottpotion_cauldron_side.png"},
	paramtype2 = "facedir",
    groups = {choppy=2, not_in_creative_inventory=1},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.500000,-0.375000,-0.500000,-0.375000,0.500000,0.500000}, 
            {0.375000,-0.375000,-0.500000,0.500000,0.500000,0.500000}, 
            {-0.500000,-0.375000,-0.500000,0.500000,0.500000,-0.375000}, 
            {-0.500000,-0.375000,0.375000,0.500000,0.500000,0.500000},
            {-0.500000,-0.312500,-0.500000,0.500000,-0.062500,0.500000}, 
            {-0.500000,-0.500000,-0.500000,-0.375000,0.500000,-0.375000}, 
            {0.375000,-0.500000,-0.500000,0.500000,0.500000,-0.375000}, 
            {0.375000,-0.500000,0.375000,0.500000,0.500000,0.500000}, 
            {-0.500000,-0.500000,0.375000,-0.375000,0.500000,0.500000}, 
        }
    }
})

minetest.register_node("lottpotion:cauldron_empty",{
    drawtype="nodebox",
    tiles = {"lottpotion_cauldron_side.png"},
	paramtype2 = "facedir",
    groups = {choppy=2},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.500000,-0.375000,-0.500000,-0.375000,0.500000,0.500000}, 
            {0.375000,-0.375000,-0.500000,0.500000,0.500000,0.500000}, 
            {-0.500000,-0.375000,-0.500000,0.500000,0.500000,-0.375000}, 
            {-0.500000,-0.375000,0.375000,0.500000,0.500000,0.500000}, 
            {-0.500000,-0.500000,-0.500000,-0.375000,0.500000,-0.375000}, 
            {0.375000,-0.500000,-0.500000,0.500000,0.500000,-0.375000}, 
            {0.375000,-0.500000,0.375000,0.500000,0.500000,0.500000}, 
            {-0.500000,-0.500000,0.375000,-0.375000,0.500000,0.500000}, 
            {-0.500000,-0.375000,-0.500000,0.500000,-0.312500,0.500000}, 
        },
    },
    on_rightclick = function(pos, node, clicker, itemstack)
            if itemstack:get_name() == "bucket:bucket_water" then
			     minetest.set_node(pos, {name="lottpotion:cauldron_full"})
				 return {name="bucket:bucket_empty"}
            end
    end
})

minetest.register_craftitem("lottpotion:potion_bottle", {
	description = "Potion Bottle",
	stack_max = 1,
	inventory_image = "lottpotion_bottle.png",
	wield_image = "lottpotion_bottle.png",
	on_place = function(item, user, pointed_thing)
		pos = pointed_thing.above
		pos.y = pos.y - 1
		if (minetest.get_node(pos).name == "lottpotion:cauldron_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_two_third_full"})
			return {name="lottpotion:water_bottle"}
		end
		if (minetest.get_node(pos).name == "lottpotion:cauldron_two_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_one_third_full"})
			return {name="lottpotion:water_bottle"}
		end
		if (minetest.get_node(pos).name == "lottpotion:cauldron_one_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_empty"})
			return {name="lottpotion:water_bottle"}
		end
    end
})

minetest.register_craftitem("lottpotion:water_bottle", {
	description = "Potion Bottle",
	inventory_image = "lottpotion_bottle.png^lottpotion_water.png",
	wield_image = "lottpotion_bottle.png^lottpotion_water.png",
})

minetest.register_craftitem("lottpotion:glass", {
	description = "Drinking Glass",
	stack_max = 1,
	inventory_image = "vessels_drinking_glass.png",
	wield_image = "vessels_drinking_glass.png",
	on_place = function(item, user, pointed_thing)
		pos = pointed_thing.above
		pos.y = pos.y - 1
		if (minetest.get_node(pos).name == "lottpotion:cauldron_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_two_third_full"})
			return {name="lottpotion:water_glass"}
		end
		if (minetest.get_node(pos).name == "lottpotion:cauldron_two_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_one_third_full"})
			return {name="lottpotion:water_glass"}
		end
		if (minetest.get_node(pos).name == "lottpotion:cauldron_one_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="lottpotion:cauldron_empty"})
			return {name="lottpotion:water_glass"}
		end
    end
})

minetest.register_craftitem("lottpotion:water_glass", {
	description = "Drinking Glass filled with Water",
	inventory_image = "lottpotion_water_glass.png",
	wield_image = "lottpotion_water_glass.png",
})

minetest.register_craft({
	output = 'lottpotion:cauldron_empty',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})
