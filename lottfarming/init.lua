farming = {}

function farming.hoe_on_use(itemstack, user, pointed_thing, uses)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end
	
	local under = minetest.get_node(pt.under)
	local p = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
	local above = minetest.get_node(p)
	
	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end
	
	-- check if the node above the pointed thing is air
	if above.name ~= "air" then
		return
	end
	
	-- check if pointing at dirt
	if minetest.get_item_group(under.name, "soil") ~= 1 then
		return
	end
	
	-- turn the node into soil, wear out item and play sound
	minetest.set_node(pt.under, {name="farming:soil"})
	minetest.sound_play("default_dig_crumbly", {
		pos = pt.under,
		gain = 0.5,
	})
	itemstack:add_wear(65535/(uses-1))
	return itemstack
end

function farming:add_plant(full_grown, names, interval, chance)
	minetest.register_abm({
		nodenames = names,
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "farming:soil_wet" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			local step = nil
			for i,name in ipairs(names) do
				if name == node.name then
					step = i
					break
				end
			end
			if step == nil then
				return
			end
			local new_node = {name=names[step+1]}
			if new_node.name == nil then
				new_node.name = full_grown
			end
			minetest.env:set_node(pos, new_node)
		end
}	)
end

-- ========= CORN =========
dofile(minetest.get_modpath("lottfarming").."/corn.lua")

-- ========= BERRIES =========
dofile(minetest.get_modpath("lottfarming").."/berries.lua")

-- ========= CABBAGE =========
dofile(minetest.get_modpath("lottfarming").."/cabbage.lua")

-- ========= ATHELAS =========
dofile(minetest.get_modpath("lottfarming").."/athelas.lua")

-- ========= POTATO =========
dofile(minetest.get_modpath("lottfarming").."/potato.lua")

-- ========= TOMATO =========
dofile(minetest.get_modpath("lottfarming").."/tomatoes.lua")

-- ========= TURNIP =========
dofile(minetest.get_modpath("lottfarming").."/turnips.lua")

-- ========= PIPEWEED =========
dofile(minetest.get_modpath("lottfarming").."/pipeweed.lua")

minetest.register_node("lottfarming:decay_tree", {
	description = "Decaying Wood",
	tile_images = {'default_tree_top.png^lottfarming_decay_tree.png', 'default_tree.png', 	'default_tree.png'},
     is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	drop = "default:dirt",
})

local function decaying_wood(pos, inv, p)
	if pos == nil then
		return false
	end
	local node = minetest.env:get_node(pos)
	local name = node.name
	local above = minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z})
	if name == "default:tree" or name == "default:jungletree" then
		if above.name == "air" then
			node.name = "lottfarming:decay_tree"
			minetest.env:set_node(pos, node)
			return true
		end
	end
	return false
end

minetest.register_tool("lottfarming:bacteria_fertiliser", {
	description = "Bacteria Fertiliser",
	inventory_image = "lottfarming_bacteria_fertiliser.png",
	on_use = function(itemstack, user, pointed_thing)
		if decaying_wood(pointed_thing.under, user:get_inventory(), 10) then
			itemstack:add_wear(65535/80)
			return itemstack
		end
	end
})

minetest.register_craft({
	output = "lottfarming:bacteria_fertiliser",
	recipe = {
		{"default:glass", "", "default:glass"},
		{"default:glass", "bones:bones", "default:glass"},
		{"default:glass", "default:glass", "default:glass"},
	}
})

-- ========= BROWN MUSHROOM =========
dofile(minetest.get_modpath("lottfarming").."/brown.lua")

-- ========= RED MUSHROOM =========
dofile(minetest.get_modpath("lottfarming").."/red.lua")

-- ========= BLUE MUSHROOM =========
dofile(minetest.get_modpath("lottfarming").."/blue.lua")

-- ========= GREEN MUSHROOM =========
dofile(minetest.get_modpath("lottfarming").."/green.lua")