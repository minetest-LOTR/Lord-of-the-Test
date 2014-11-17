minetest.register_node("gul:cauldron_full",{
    drawtype="nodebox",
	description= "Filled Cauldron",
    tiles = {"gul_cauldron_top.png", "gul_cauldron_side.png", "gul_cauldron_side.png",
		"gul_cauldron_side.png", "gul_cauldron_side.png", "gul_cauldron_side.png"},
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

minetest.register_node("gul:cauldron_two_third_full",{
    drawtype="nodebox",
    description= "Two Third Filled Cauldron",
    tiles = {"gul_cauldron_top.png", "gul_cauldron_side.png", "gul_cauldron_side.png",
		"gul_cauldron_side.png", "gul_cauldron_side.png", "gul_cauldron_side.png"},
	paramtype2 = "facedir",
    groups = {choppy=2,oddly_breakable_by_hand=2, not_in_creative_inventory=1},
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

minetest.register_node("gul:cauldron_one_third_full",{
    drawtype="nodebox",
	description= "One Third Filled Cauldron",
    tiles = {"gul_cauldron_top.png", "gul_cauldron_side.png", "gul_cauldron_side.png",
		"gul_cauldron_side.png", "gul_cauldron_side.png", "gul_cauldron_side.png"},
	paramtype2 = "facedir",
    groups = {choppy=2,oddly_breakable_by_hand=2, not_in_creative_inventory=1},
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

minetest.register_node("gul:cauldron_empty",{
    drawtype="nodebox",
    tiles = {"gul_cauldron_side.png"},
	paramtype2 = "facedir",
    groups = {cracky=1,level=2},
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
			     minetest.set_node(pos, {name="gul:cauldron_full"})
				 return {name="bucket:bucket_empty"}
            end
    end
})

minetest.register_node(":vessels:glass_bottle", {
	description = "Glass Bottle (empty)",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png"},
	inventory_image = "vessels_glass_bottle_inv.png",
	wield_image = "vessels_glass_bottle.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
     on_use = function(itemstack, user, pointed_thing)
		pos = pointed_thing.above
		pos.y = pos.y - 1
		if (minetest.get_node(pos).name == "gul:cauldron_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="gul:cauldron_two_third_full"})
               itemstack:take_item()
               user:get_inventory():add_item("main", "gul:glass_bottle_water")
               return itemstack
		end
		if (minetest.get_node(pos).name == "gul:cauldron_two_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="gul:cauldron_one_third_full"})
               itemstack:take_item()
               user:get_inventory():add_item('main', "gul:glass_bottle_water")
               return itemstack
		end
		if (minetest.get_node(pos).name == "gul:cauldron_one_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="gul:cauldron_empty"})
               itemstack:take_item()
               user:get_inventory():add_item('main', "gul:glass_bottle_water")
               return itemstack
		end
    end
})

minetest.register_node("gul:glass_bottle_water", {
	description = "Glass Bottle (Water)",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png^gul_water.png"},
	inventory_image = "vessels_glass_bottle_inv.png^gul_water.png",
	wield_image = "vessels_glass_bottle_inv.png^gul_water.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node(":vessels:drinking_glass", {
	description = "Drinking Glass (empty)",
	drawtype = "plantlike",
	tiles = {"vessels_drinking_glass.png"},
	inventory_image = "vessels_drinking_glass_inv.png",
	wield_image = "vessels_drinking_glass.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
     on_use = function(itemstack, user, pointed_thing)
		pos = pointed_thing.above
		pos.y = pos.y - 1
		if (minetest.get_node(pos).name == "gul:cauldron_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="gul:cauldron_two_third_full"})
               itemstack:take_item()
			user:get_inventory():add_item('main', "gul:drinking_glass_water")
               return itemstack
		end
		if (minetest.get_node(pos).name == "gul:cauldron_two_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="gul:cauldron_one_third_full"})
               itemstack:take_item()
			user:get_inventory():add_item('main', "gul:drinking_glass_water")
               return itemstack
		end
		if (minetest.get_node(pos).name == "gul:cauldron_one_third_full") then
			minetest.remove_node(pos)
			minetest.set_node(pos, {name="gul:cauldron_empty"})
               itemstack:take_item()
			user:get_inventory():add_item('main', "gul:drinking_glass_water")
               return itemstack
		end
    end
})

minetest.register_node("gul:drinking_glass_water", {
	description = "Drinking Glass (Water)",
	drawtype = "plantlike",
	tiles = {"gul_glass_water.png"},
	inventory_image = "gul_glass_water.png",
	wield_image = "gul_glass_water.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "vessels:glass_fragments",
	recipe = {
		"group:vessel",
		"group:vessel",
	},
})

minetest.register_craft({
	output = 'gul:cauldron_empty',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})
