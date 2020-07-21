minetest.register_alias("lottother:blue_torch", "lottblocks:elf_torch")
minetest.register_alias("lottother:orc_torch", "lottblocks:orc_torch")
minetest.register_alias("lottother:lamp_wood", "lottblocks:lamp_wood")
minetest.register_alias("lottother:lamp_middle_wood", "lottblocks:lamp_middle_wood")
minetest.register_alias("lottother:lamp_top_wood", "lottblocks:lamp_top_wood")
minetest.register_alias("lottother:tiny_lamp_wood", "lottblocks:small_lamp_wood")
minetest.register_alias("lottother:lamp_wood_alder", "lottblocks:lamp_alder")
minetest.register_alias("lottother:lamp_middle_wood_alder", "lottblocks:lamp_middle_alder")
minetest.register_alias("lottother:lamp_top_wood_alder", "lottblocks:lamp_top_alder")
minetest.register_alias("lottother:tiny_lamp_wood_alder", "lottblocks:small_lamp_alder")
minetest.register_alias("lottother:lamp_wood_birch", "lottblocks:lamp_birch")
minetest.register_alias("lottother:lamp_middle_wood_birch", "lottblocks:lamp_middle_birch")
minetest.register_alias("lottother:lamp_top_wood_birch", "lottblocks:lamp_top_birch")
minetest.register_alias("lottother:tiny_lamp_wood_birch", "lottblocks:small_lamp_birch")
minetest.register_alias("lottother:lamp_wood_lebethron", "lottblocks:lamp_lebethron")
minetest.register_alias("lottother:lamp_middle_wood_lebethron", "lottblocks:lamp_middle_lebethron")
minetest.register_alias("lottother:lamp_top_wood_lebethron", "lottblocks:lamp_top_lebethron")
minetest.register_alias("lottother:tiny_lamp_wood_lebethron", "lottblocks:small_lamp_lebethron")
minetest.register_alias("lottother:lamp_wood_mallorn", "lottblocks:lamp_mallorn")
minetest.register_alias("lottother:lamp_middle_wood_mallorn", "lottblocks:lamp_middle_mallorn")
minetest.register_alias("lottother:lamp_top_wood_mallorn", "lottblocks:lamp_top_mallorn")
minetest.register_alias("lottother:tiny_lamp_wood_mallorn", "lottblocks:small_lamp_mallorn")

function lottblocks.register_lamp(material, description, inv_texture, post1_texture, post2_texture, top_texture, texture, material_code_name, race)
	local node_bottom = "lottblocks:lamp_" .. material
	local node_middle = "lottblocks:lamp_middle_" .. material
	local node_top = "lottblocks:lamp_top_" .. material
	local node_small = "lottblocks:small_lamp_" .. material
	minetest.register_node(node_bottom, {
		drop = "",
		description = description .. " Lamppost",
		tiles = {post1_texture},
		inventory_image = inv_texture,
		wield_image = inv_texture,
		groups = {choppy=2,oddly_breakable_by_hand=1,flammable=2},
		paramtype = "light",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.15,-0.5,-0.15,0.15,0.4,0.15},
				{-0.1,0.4,-0.1,0.1,0.5,0.1}
			}
		},
		on_place = function(itemstack, placer, pointed_thing)
	    	local pos = pointed_thing.above;
	    	if(minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air") or (minetest.get_node({x=pos.x, y=pos.y+2, z=pos.z}).name ~= "air") then
	    		minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
	    		return;
	    	end
	    	return minetest.item_place(itemstack, placer, pointed_thing);
		end,
		after_place_node = function(pos,placer,itemstack)
			minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = node_middle})
			minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = node_top})
		end,
	})
	minetest.register_node(node_middle, {
		drop = "",
		groups = {choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory = 1},
		tiles = {post2_texture},
		paramtype = "light",
		drawtype = "nodebox",
		pointable = false,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.1,-0.5,-0.1,0.1,0.5,0.1}
			}
		}
	})
	minetest.register_node(node_top, {
		drop = "lottblocks:lamp_" .. material,
		groups = {choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory = 1},
			tiles = {
				top_texture, top_texture,
				{
					image = texture,
					backface_culling = false,
					animation = {
						type = "vertical_frames",
						aspect_w = 16,
						aspect_h = 16,
						length = 1.5
					},
	        	}
			},
		paramtype = "light",
		drawtype = "nodebox",
		light_source = 14,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
				{-0.3,-0.4,-0.3,0.3,0.5,0.3}
			}
		},
		selection_box = 	{
			type = "fixed",
			fixed = {
				{-0.3,0.5,-0.3,0.3,-2.5,0.3},
			}
		},
		after_dig_node = function(pos)
			minetest.remove_node({x = pos.x, y = pos.y - 1, z = pos.z})
			minetest.remove_node({x = pos.x, y = pos.y - 2, z = pos.z})
		end
	})
	minetest.register_node(node_small, {
		description = description .. " Small Lamp",
		groups = {choppy=2,oddly_breakable_by_hand=1,flammable=2},
		tiles = {
			top_texture, top_texture,
			{
				image = texture,
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 1.5
				},
	       	},
		},
		paramtype = "light",
		drawtype = "nodebox",
		light_source = 14,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
				{-0.3,-0.4,-0.3,0.3,0.5,0.3}
			}
		},
		selection_box = 	{
			type = "fixed",
			fixed = {
				{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
				{-0.3,-0.4,-0.3,0.3,0.5,0.3}
			}
		},
	})
	if race == "elf" then
		minetest.register_craft({
			output = node_bottom,
			recipe = {
				{node_small},
				{material_code_name},
				{"default:stonebrick"},
			}
		})
		minetest.register_craft({
			output = node_small,
			recipe = {
				{material_code_name, material_code_name, material_code_name},
				{material_code_name, "lottblocks:elf_torch", material_code_name},
				{material_code_name, material_code_name, material_code_name},
			}
		})
	elseif race == "orc" then
		minetest.register_craft({
			output = node_bottom,
			recipe = {
				{node_small},
				{material_code_name},
				{"lottblocks:orc_brick"},
			}
		})
		minetest.register_craft({
			output = node_small,
			recipe = {
				{material_code_name, material_code_name, material_code_name},
				{material_code_name, "lottblocks:orc_torch", material_code_name},
				{material_code_name, material_code_name, material_code_name},
			}
		})
	end
end

lottblocks.register_lamp("wood", "Wood", "lottblocks_lamp_inv_wood.png", "default_stone_brick.png", "default_wood.png", "default_wood.png", "lottblocks_lamp_active_wood.png",  "default:wood", "elf")
lottblocks.register_lamp("alder", "Alder", "lottblocks_lamp_inv_alder.png", "default_stone_brick.png", "lottplants_alderwood.png", "lottplants_alderwood.png", "lottblocks_lamp_active_alder.png",  "lottplants:alderwood", "elf")
lottblocks.register_lamp("junglewood", "Junglewood", "lottblocks_lamp_inv_junglewood.png", "default_stone_brick.png", "default_junglewood.png", "default_junglewood.png", "lottblocks_lamp_active_junglewood.png",  "default:junglewood", "elf")
lottblocks.register_lamp("birch", "Birch", "lottblocks_lamp_inv_birch.png", "default_stone_brick.png", "lottplants_birchwood.png", "lottplants_birchwood.png", "lottblocks_lamp_active_birch.png",  "lottplants:birchwood", "elf")
lottblocks.register_lamp("pine", "Pine", "lottblocks_lamp_inv_pine.png", "default_stone_brick.png", "lottplants_pinewood.png", "lottplants_pinewood.png", "lottblocks_lamp_active_pine.png",  "lottplants:pinewood", "elf")
lottblocks.register_lamp("lebethron", "Lebethron", "lottblocks_lamp_inv_lebethron.png", "default_stone_brick.png", "lottplants_lebethronwood.png", "lottplants_lebethronwood.png", "lottblocks_lamp_active_lebethron.png",  "lottplants:lebethronwood", "elf")
lottblocks.register_lamp("mallorn", "Mallorn", "lottblocks_lamp_inv_mallorn.png", "default_stone_brick.png", "lottplants_mallornwood.png", "lottplants_mallornwood.png", "lottblocks_lamp_active_mallorn.png",  "lottplants:mallornwood", "elf")

--Orc lamps

lottblocks.register_lamp("wood_orc", "Mordor Wooden", "lottblocks_orc_lamp_inv.png", "lottblocks_orc_brick.png", "default_wood.png", "default_wood.png", "lottblocks_orc_lamp_active.png",  "default:wood", "orc")
lottblocks.register_lamp("alder_orc", "Mordor Alder", "lottblocks_orc_lamp_inv_alder.png", "lottblocks_orc_brick.png", "lottplants_alderwood.png", "lottplants_alderwood.png", "lottblocks_orc_lamp_active_alder.png",  "lottplants:alderwood", "orc")
lottblocks.register_lamp("junglewood_orc", "Mordor Junglewood", "lottblocks_orc_lamp_inv_junglewood.png", "lottblocks_orc_brick.png", "default_junglewood.png", "default_junglewood.png", "lottblocks_orc_lamp_active_junglewood.png",  "default:junglewood", "orc")
lottblocks.register_lamp("birch_orc", "Mordor Birch", "lottblocks_orc_lamp_inv_birch.png", "lottblocks_orc_brick.png", "lottplants_birchwood.png", "lottplants_birchwood.png", "lottblocks_orc_lamp_active_birch.png",  "lottplants:birchwood", "orc")
lottblocks.register_lamp("pine_orc", "Mordor Pine", "lottblocks_orc_lamp_inv_pine.png", "lottblocks_orc_brick.png", "lottplants_pinewood.png", "lottplants_pinewood.png", "lottblocks_orc_lamp_active_pine.png",  "lottplants:pinewood", "orc")
lottblocks.register_lamp("lebethron_orc", "Mordor Lebethron", "lottblocks_orc_lamp_inv_lebethron.png", "lottblocks_orc_brick.png", "lottplants_lebethronwood.png", "lottplants_lebethronwood.png", "lottblocks_orc_lamp_active_lebethron.png",  "lottplants:lebethronwood", "orc")

-- Made by lumidify - lottblocks_mithril_stonelamp.png
-- created by modifying darkage_lamp.png
minetest.register_node("lottblocks:mithril_stonelamp", {
	description = "Mithril Stonelamp",
	tiles = { "lottblocks_mithril_stonelamp.png" },
	paramtype = "light",
	sunlight_propagates = true,
	light_source = LIGHT_MAX,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "lottblocks:mithril_stonelamp 2",
	recipe = {
		{"default:stone", "default:stone","default:stone"},
		{"default:stone", "lottores:mithril_ingot", "default:stone"},
		{"default:stone", "default:torch", "default:stone"},
	}
})
