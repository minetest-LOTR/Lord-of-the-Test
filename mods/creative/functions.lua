
-- Unlimited node placement
minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
	if placer and placer:is_player() then
		if creative.is_enabled_for(placer:get_player_name()) then
			return true
		end
	end
end)


-- Don't pick up if the item is already in the inventory
local old_handle_node_drops = minetest.handle_node_drops
function minetest.handle_node_drops(pos, drops, digger)
	if not digger or not digger:is_player() or
		not creative.is_enabled_for(digger:get_player_name()) then
		return old_handle_node_drops(pos, drops, digger)
	end
	local inv = digger:get_inventory()
	if inv then
		for _,item in ipairs(drops) do
			item = ItemStack(item):get_name()
			if not inv:contains_item("main", item) then
				inv:add_item("main", item)
			end
		end
	end
end

-- Shift + punch = set pointed block to hand
minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
	if creative.is_enabled_for(puncher:get_player_name()) then
		if puncher:get_player_control().aux1 == true then
			if not node or not node.name then
				return
			end

			if minetest.registered_items[node.name].groups.not_in_creative_inventory ~= 1 then
				puncher:set_wielded_item(node)
			end
		end
	end
end)

if minetest.settings:get_bool("creative_mode") then
	local digtime = 0.15
	minetest.register_item(":", {
		type = "none",
		wield_image = "wieldhand.png",
		wield_scale = {x=1,y=1,z=2.5},
		range = 10,
		tool_capabilities = {
			full_punch_interval = 0.5,
			max_drop_level = 3,
			groupcaps = {
				hand = {times = {[1] = digtime, [2] = digtime, [3] = digtime, [4] = digtime},
					uses = 0, maxlevel = 0},
				axe = {times = {[1] = digtime, [2] = digtime, [3] = digtime, [4] = digtime},
					uses = 0, maxlevel = 0},
				pickaxe = {times = {[1] = digtime, [2] = digtime, [3] = digtime, [4] = digtime},
					uses = 0, maxlevel = 0},
			},
			damage_groups = {fleshy = 10},
		}
	})
end
