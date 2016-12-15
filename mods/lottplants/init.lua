dofile(minetest.get_modpath("lottplants").."/nodes.lua")
dofile(minetest.get_modpath("lottplants").."/wild_food.lua")
dofile(minetest.get_modpath("lottplants").."/flowers.lua")
dofile(minetest.get_modpath("lottplants").."/functions.lua")

minetest.register_node("lottplants:brambles_of_mordor", {
	description = "Brambles Of Mordor",
	drawtype = "plantlike",
	tiles = { "lottplants_brambles_of_mordor.png" },
	inventory_image = "lottplants_brambles_of_mordor.png",
	wield_image = "lottplants_brambles_of_mordor.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 42,
	walkable = false,
	waving = 1,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_grey=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.3, 0.5 },
	},
})

minetest.register_node("lottplants:pilinehtar", {
	description = "Pilinehtar",
	drawtype = "plantlike",
	tiles = { "lottplants_pilinehtar.png" },
	inventory_image = "lottplants_pilinehtar.png",
	wield_image = "lottplants_pilinehtar.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 2,
	walkable = false,
	buildable_to = true,
	waving = 1,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_green=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, 0.27, 0.3 },
	},
})

minetest.register_alias("lottplants:brambles_of_mordor_fake", "lottplants:brambles_of_mordor")
minetest.register_alias("lottplants:pilinehtar_fake", "lottplants:pilinehtar")

minetest.register_abm({
	nodenames = {"group:flora"},
	neighbors = {"default:dirt_with_grass", "default:desert_sand"},
	interval = 50,
	chance = 25,
	action = function(pos, node)
		pos.y = pos.y - 1
		local under = minetest.get_node(pos)
		pos.y = pos.y + 1
		if under.name == "default:desert_sand" then
			minetest.set_node(pos, {name="lottplants:brambles_of_mordor"})
		elseif under.name ~= "default:dirt_with_grass" then
			return
		end

		local light = minetest.get_node_light(pos)
		if not light or light < 13 then
			return
		end

		local pos0 = {x=pos.x-4,y=pos.y-4,z=pos.z-4}
		local pos1 = {x=pos.x+4,y=pos.y+4,z=pos.z+4}
		if #minetest.find_nodes_in_area(pos0, pos1, "group:flora_block") > 0 then
			return
		end

		local flowers = minetest.find_nodes_in_area(pos0, pos1, "group:flora")
		if #flowers > 3 then
			return
		end

		local seedling = minetest.find_nodes_in_area(pos0, pos1, "default:dirt_with_grass")
		if #seedling > 0 then
			seedling = seedling[math.random(#seedling)]
			seedling.y = seedling.y + 1
			light = minetest.get_node_light(seedling)
			if not light or light < 13 then
				return
			end
			if minetest.get_node(seedling).name == "air" then
				minetest.set_node(seedling, {name=node.name})
			end
		end
	end,
})

minetest.register_craftitem("lottplants:honey", {
	description = "Honey",
	inventory_image = "lottplants_honey.png",
	on_use = minetest.item_eat(1),
})
