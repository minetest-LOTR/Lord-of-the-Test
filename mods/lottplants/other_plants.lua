minetest.register_node("lottplants:cactus", {
	description = "Cactus",
	tiles = {"lottplants_cactus_top.png", "lottplants_cactus_top.png", "lottplants_cactus_side.png"},
	groups = {axe = 2, plant = 1, green = 1},
})

local function waterlily_place(itemstack, placer, pointed_thing, i)
	local pos = pointed_thing.above
	local node = minetest.get_node(pointed_thing.under)
	local def = minetest.registered_nodes[node.name]
	local player_name = placer and placer:get_player_name() or ""

	if def and def.on_rightclick then
		return def.on_rightclick(pointed_thing.under, node, placer, itemstack,
				pointed_thing)
	end

	if def and def.liquidtype == "source" and
			minetest.get_item_group(node.name, "water") > 0 then
		if not minetest.is_protected(pos, player_name) then
			minetest.set_node(pos, {name = "lottplants:waterlily_" .. i,
				param2 = math.random(0, 3)})
			if not (creative and creative.is_enabled_for
					and creative.is_enabled_for(player_name)) then
				itemstack:take_item()
			end
		else
			minetest.record_protection_violation(pos, player_name)
		end
	end

	return itemstack
end

-- Waterlilys
for i = 1,2 do
	minetest.register_node("lottplants:waterlily_" .. i, {
		description = "Waterlily " .. i,
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		tiles = {"lottplants_waterlily_" .. i .. ".png", "lottplants_waterlily_bottom.png"},
		buildable_to = true,
		sunlight_propagates = true,
		floodable = true,
		drop = "lottplants:waterlily_1",
		liquids_pointable = true,
		groups = {snappy = 3, flower = 1, flammable = 1},
		--sounds = default.node_sound_leaves_defaults(),
		node_placement_prediction = "",
		on_place = function(itemstack, placer, pointed_thing)
			waterlily_place(itemstack, placer, pointed_thing, i)
		end,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -31 / 64, -0.5, 0.5, -15 / 32, 0.5}
		},
		selection_box = {
			type = "fixed",
			fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16}
		},
	})
end

for i = 3,4 do
	minetest.register_node("lottplants:waterlily_" .. i, {
		description = "Waterlily " .. i,
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		tiles = {"lottplants_waterlily_3.png", "lottplants_waterlily_bottom.png", "lottplants_waterlily_lily_" .. i .. ".png"},
		buildable_to = true,
		sunlight_propagates = true,
		floodable = true,
		drop = "lottplants:waterlily_1",
		liquids_pointable = true,
		groups = {snappy = 3, flower = 1, flammable = 1},
		--sounds = default.node_sound_leaves_defaults(),
		node_placement_prediction = "",
		on_place = function(itemstack, placer, pointed_thing)
			waterlily_place(itemstack, placer, pointed_thing, i)
		end,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.484375, -0.5, 0.5, -0.484375, 0.5}, -- NodeBox1
				{-0.5, -0.484375, 0, 0.5, 0.5, 0}, -- NodeBox2
				{0, -0.484375, -0.5, 0, 0.5, 0.5}, -- NodeBox3
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16}
		},
	})
end
