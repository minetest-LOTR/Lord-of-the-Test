minetest.register_node("cemen:fog", {
	description = "Fog",
	drawtype = "glasslike",
	tiles = {"cemen_fog.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	post_effect_color = {a=128, r=241, g=248, b=255},
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("cemen:angsnowblock", {
	description = "Snow Block",
	tiles = {"default_snow.png"},
	is_ground_content = true,
     drop = 'default:snowblock',
	freezemelt = "default:water_source",
	groups = {crumbly=3, melts=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
		dug = {name="default_snow_footstep", gain=0.75},
	}),
})

minetest.register_node("cemen:frozen_stone", {
	description = "Frozen Stone",
	tiles = {"default_stone.png^cemen_frozen.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'default:cobble','default:snow',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:mordor_stone", {
	description = "Mordor Stone",
	tiles = {"cemen_mordor_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(":default:ice", {
	description = "Ice",
	drawtype = "glasslike",
	tiles = {"cemen_ice.png"},
	is_ground_content = true,
    alpha = 200,
	paramtype = "light",
	freezemelt = "default:water_source",
	groups = {cracky=3, melts=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("cemen:blacksource", {
	description = "Black Water Source",
	inventory_image = minetest.inventorycube("cemen_black_water.png"),
	tiles = {"cemen_black_water.png"},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "cemen:blackflowing",
	liquid_alternative_source = "cemen:blacksource",
	liquid_viscosity = 1,
	post_effect_color = {a=224, r=31, g=56, b=8},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("cemen:blackflowing", {
	drawtype = "flowingliquid",
	tiles = {"cemen_black_water.png"},
	special_tiles = {
		{
			image="cemen_black_water_flow.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1}
		},
		{
			image="cemen_black_water_flow.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1}
		},
	},
	-- alpha = 224,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "cemen:blackflowing",
	liquid_alternative_source = "cemen:blacksource",
	liquid_viscosity = 1,
	post_effect_color = {a=224, r=31, g=56, b=8},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
})

-- Grasses

minetest.register_node("cemen:dunland_grass", {
	description = "Dunland Grass",
	tiles = {"cemen_dunland_grass.png", "default_dirt.png", "default_dirt.png^cemen_dunland_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1,cemen_grass=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("cemen:ironhill_grass", {
	description = "Iron Hills Grass",
	tiles = {"cemen_dunland_grass.png", "default_dirt.png", "default_dirt.png^cemen_dunland_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1,cemen_grass=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("cemen:gondor_grass", {
	description = "Gondor Grass",
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1,cemen_grass=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("cemen:lorien_grass", {
	description = "Lorien Grass",
	tiles = {"cemen_lorien_grass.png", "default_dirt.png", "default_dirt.png^cemen_lorien_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1,cemen_grass=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("cemen:fangorn_grass", {
	description = "? Grass",
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1,cemen_grass=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("cemen:mirkwood_grass", {
	description = "Mirkwood Grass",
	tiles = {"cemen_mirkwood_grass.png", "default_dirt.png", "default_dirt.png^cemen_mirkwood_grass_side.png"}, 
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1,cemen_grass=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("cemen:rohan_grass", {
	description = "? Grass",
	tiles = {"cemen_rohan_grass.png", "default_dirt.png", "default_dirt.png^cemen_rohan_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1,cemen_grass=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("cemen:shire_grass", {
	description = "Shire Grass",
	tiles = {"cemen_shire_grass.png", "default_dirt.png", "default_dirt.png^cemen_shire_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, cemen_grass=1, not_in_creative_inventory =1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("cemen:ithilien_grass", {
	description = "Ithilien Grass",
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, cemen_grass=1, not_in_creative_inventory =1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("cemen:default_grass", {
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3, soil=1,cemen_grass=1,not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_abm({
	nodenames = {"default:dirt_with_grass"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
		local count_grasses = {};
		local curr_max  = 0;
		local curr_type = "cemen:default_grass";

		local positions = minetest.find_nodes_in_area( {x=(pos.x-2), y=(pos.y-2), z=(pos.z-2)},
							       {x=(pos.x+2), y=(pos.y+2), z=(pos.z+2)},
							   "group:cemen_grass" );
		for _,p in ipairs(positions) do
			local n = minetest.get_node( p );
			if( n and n.name ) then
				if( not( count_grasses[ n.name ] )) then
					count_grasses[ n.name ] = 1;
				else
					count_grasses[ n.name ] = count_grasses[ n.name ] + 1;	
				end
				if( count_grasses[ n.name ] > curr_max ) then
					curr_max  = count_grasses[ n.name ];
					curr_type = n.name;
				end
			end
		end
		minetest.set_node(pos, {name = curr_type })
        end
})

minetest.register_abm({
	nodenames = {"group:cemen_grass"},
	interval = 2,
	chance = 20,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef
				and not ((nodedef.sunlight_propagates or nodedef.paramtype == "light")
				and nodedef.liquidtype == "none") then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end
})