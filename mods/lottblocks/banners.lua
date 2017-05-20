minetest.register_alias("lottother:tapestry_top", "lottblocks:banner_top")
minetest.register_node("lottblocks:banner_top", {
	drawtype = "nodebox",
	description = "Banner Top",
	tiles = {"default_wood.png"},
	sunlight_propagates = true,
	groups = {flammable=3,oddly_breakable_by_hand=1},
	sounds = default.node_sound_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.6, -0.5, 0.375, 0.6, -0.375, 0.5},
		},
	},
})

minetest.register_craft({
	output = "lottblocks:banner_top",
	recipe = {
		{"default:stick", "default:stick", "default:stick"},
	},
})

local banners = {
	{"angmar",   "Angmar",   "red"},
	{"dunland",  "Dunland",  "brown"},
	{"dwarf",    "Dwarf",    "grey"},
	{"gondor",   "Gondor",	 "blue"},
	{"lorien",   "Lorien",	 "cyan"},
	{"mirkwood", "Mirkwood", "dark_green"},
	{"mordor",   "Mordor",   "black"},
	{"rohan",    "Rohan",    "orange"},
	{"urukhai",  "Uruk Hai", "dark_grey"},
}

for _, row in ipairs(banners) do
	local name = row[1]
	local desc = row[2]
	local craft = row[3]
	minetest.register_alias("lottother:tapestry_" .. name, "lottblocks:banner_" .. name)
	minetest.register_alias("lottother:tapestry_top_" .. name, "lottblocks:banner_top_" .. name)

	minetest.register_node("lottblocks:banner_"..name, {
		drawtype = "nodebox",
		description = desc.." Banner",
		tiles = {
			"lottblocks_banner_"..name.."_side.png",
			"lottblocks_banner_"..name.."_side.png",
			"lottblocks_banner_"..name..".png",
		},
		groups = {oddly_breakable_by_hand=3,flammable=3},
		sounds = default.node_sound_defaults(),
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.375, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox1
				{-0.4375, 0.25, 0.4375, 0.4375, 0.375, 0.5}, -- NodeBox2
				{-0.375, 0.125, 0.4375, 0.375, 0.25, 0.5}, -- NodeBox3
				{-0.3125, 0, 0.4375, 0.3125, 0.125, 0.5}, -- NodeBox4
				{-0.25, -0.125, 0.4375, 0.25, 0.0625, 0.5}, -- NodeBox5
				{-0.1875, -0.25, 0.4375, 0.1875, -0.125, 0.5}, -- NodeBox6
				{-0.125, -0.375, 0.4375, 0.125, -0.25, 0.5}, -- NodeBox7
				{-0.0625, -0.5, 0.4375, 0.0625, -0.375, 0.5}, -- NodeBox8
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.500000,-0.500000,0.437500,0.500000,1.500000,0.500000},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			local above = pointed_thing.above
			if minetest.get_node({x = above.x, y = above.y + 1, z = above.z}).name ~= "air" then
				return itemstack
			end
			local fdir = 0
			local placer_pos = placer:getpos()
			if placer_pos then
				dir = {
					x = above.x - placer_pos.x,
					y = above.y - placer_pos.y,
					z = above.z - placer_pos.z
				}
				fdir = minetest.dir_to_facedir(dir)
			end
			minetest.add_node(above, {name = "lottblocks:banner_"..name, param2 = fdir})
			minetest.add_node({x = above.x, y = above.y + 1, z = above.z}, {name = "lottblocks:banner_top_"..name,param2 = fdir})
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end,
		on_destruct = function(pos)
			local p = {x=pos.x, y=pos.y+1, z=pos.z}
			minetest.remove_node(p)
		end
	})

	minetest.register_node("lottblocks:banner_top_"..name, {
		drawtype = "nodebox",
		description = desc.." Banner Top",
		tiles = {
			"lottblocks_banner_"..name.."_side.png",
			"lottblocks_banner_"..name.."_side.png",
			"lottblocks_banner_top_"..name..".png",
		},
		groups = {flammable=3, not_in_creative_inventory=1},
		sounds = default.node_sound_defaults(),
		paramtype = "light",
		paramtype2 = "facedir",
		drop = '',
		pointable = false,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.500000,-0.500000,0.437500,0.500000,0.500000,0.500000},
			},
		},
	})
	
	minetest.register_craft({
		output = "lottblocks:banner_" .. name,
		recipe = {
			{"lottblocks:banner_top"},
			{"wool:" .. craft},
			{"wool:" .. craft},
		},
	})
end
