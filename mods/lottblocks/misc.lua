--Code written by foot_on_teh_hill, with some slight changes.
--https://github.com/foot-on-teh-hill/cavetools/blob/master/rope.lua

local creative = minetest.setting_getbool("creative_mode")
local function place_rope(pos, itemstack)
	if itemstack == nil and itemstack:get_count() <= 1 then
		return
	else
		local max_nodes = itemstack:get_count()
        if creative then
            max_nodes = 200
        end
		local set_nodes = 0
		for i = 2, max_nodes do
			pos.y = pos.y - 1
			local node_below = minetest.get_node(pos)
			if node_below ~= nil then
				if node_below.name == "air" then
					minetest.set_node(pos, {name = "lottblocks:elven_rope"})
					set_nodes = set_nodes + 1
				else
					break
				end
			end
		end
        if not creative then
		    itemstack:set_count(max_nodes - set_nodes)
        end
	end
end

local function dig_rope(pos, digger)
	if digger == nil and not digger:is_player() then
		return
	end
	local dug_nodes = 0
	local max_nodes = 200
	local y = pos.y
	for i = 1, max_nodes do
		pos.y = y + i
		local node = minetest.get_node(pos)
		if node ~= nil then
			if node.name == "lottblocks:elven_rope" then
				if not minetest.is_protected(pos, digger:get_player_name()) then
					minetest.remove_node(pos)
					dug_nodes = dug_nodes + 1
				else
					break
				end
			else
				break
			end
		end
	end
	for i = -1, -max_nodes, -1 do
		pos.y = y + i
		local node = minetest.get_node(pos)
		if node ~= nil then
			if node.name == "lottblocks:elven_rope" then
				if not minetest.is_protected(pos, digger:get_player_name()) then
					minetest.remove_node(pos)
					dug_nodes = dug_nodes + 1
				else
					break
				end
			else
				break
			end
		end
	end
	local inventory = digger:get_inventory()
	if inventory == nil then
		return
	end
    if not creative then
	   inventory:add_item("main", "lottblocks:elven_rope " .. dug_nodes)
    end
end

minetest.register_node("lottblocks:elven_rope", {
	tiles = {"lottblocks_elven_rope.png"}, --Made by foot_on_teh_hill
    --https://github.com/foot-on-teh-hill/cavetools/blob/master/textures/cavetools_rope.png
    inventory_image = "lottblocks_elven_rope.png",
    wield_image = "lottblocks_elven_rope.png",
	description = "Elven Rope",
	drawtype = "plantlike",
	paramtype = "light",
	light_source = 1,
	climbable = true,
	walkable = false,
	stack_max = 200,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		place_rope(pos, itemstack)
		return false
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		dig_rope(pos, digger)
	end,
	groups = {oddly_breakable_by_hand = 3}
})

minetest.register_craft({
	output = "lottblocks:elven_rope 8",
	recipe = {
		{"group:wool"},
		{"lottplants:mallornwood"},
		{"group:wool"}
	}
})

minetest.register_node("lottblocks:whatever", {
	description = "Whatever",
	tiles = {"lottblocks_whatever.png"},
	is_ground_content = false,
	groups = {cracky=1,level=2, no_darkball=1, puts_out_fire=1},
})

doors:register_door("lottblocks:whatever_door", {
	description = "Whatever Door",
	inventory_image = "lottblocks_whatever_door.png",
	groups = {snappy=1,bendy=2,cracky=1,level=2,door=1,no_darkball=1,puts_out_fire=1},
	tiles_bottom = {"lottblocks_whatever_door_b.png", "lottblocks_door_black.png"},
	tiles_top = {"lottblocks_whatever_door_a.png", "lottblocks_door_black.png"},
	only_placer_can_open = true,
})
