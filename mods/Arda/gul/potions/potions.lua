gul = {}

dofile(minetest.get_modpath("gul").."/potions/potion_api.lua")

-- Base Potions

minetest.register_node("gul:glass_bottle_mese", {
	description = "Glass Bottle (Mese Water)",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png^gul_water_mese.png"},
	inventory_image = "vessels_glass_bottle_inv.png^gul_water_mese.png",
	wield_image = "vessels_glass_bottle_inv.png^gul_water_mese.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("gul:glass_bottle_geodes", {
	description = "Glass Bottle (Geodes Crystal Water)",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png^gul_water_geodes.png"},
	inventory_image = "vessels_glass_bottle_inv.png^gul_water_geodes.png",
	wield_image = "vessels_glass_bottle_inv.png^gul_water_geodes.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("gul:glass_bottle_seregon", {
	description = "Glass Bottle (Seregon Water)",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png^gul_water_seregon.png"},
	inventory_image = "vessels_glass_bottle_inv.png^gul_water_seregon.png",
	wield_image = "vessels_glass_bottle_inv.png^gul_water_seregon.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})

-- Advanced Potions
     
gul.register_potion("athelasbrew", "Athelas Brew", "gul:athelasbrew", 100, {
	effect = "fixhp",
	types = {
		{
			type = 1,
               hp = 1,
               time = 20, 
			set = {},
			effects = {
			},
		},
		{
			type = 2,
               hp = 2,
               time = 50, 
			set = {},
			effects = {
			},
		},
		{
			type = 3,
               hp = 4,
               time = 100, 
			set = {},
			effects = {
			},
		},
	}
})
   
gul.register_potion("limpe", "Limpe", "gul:limpe", 240, {
	effect = "air",
	types = {
		{
			type = 1,
			br = 2,
               hp = 10,
               time = 60,
			set = {},
			effects = {
			},
		},
		{
			type = 2,
			br = 5,
               time = 120,
			set = {},
			effects = {
			},
		},
		{
			type = 3,
			br = 10,
               time = 240,
			set = {},
			effects = {
			},
		},
	}
})

gul.register_potion("miruvor", "Miruvor", "gul:miruvor", 240, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			time = 60,
			effects = {
				jump = 0.3,
			},
		},
		{
			type = 2,
			set = {},
			time = 120,
			effects = {
				jump = 0.6,
			},
		},
		{
			type = 3,
			set = {},
			time = 240,
			effects = {
				jump = 1.0,
			},
		},
	}
})

gul.register_potion("spiderpoison", "Spider Poison", "gul:spiderpoison", 20, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			effects = {
                    speed = -0.2,
                    jump = -0.2,
			},
		},
		{
			type = 2,
			set = {},
			effects = {
                    speed = -0.5,
                    jump = -0.5,
			},
		},
		{
			type = 3,
			set = {},
			effects = {
                    speed = -1,
                    jump = -1,
			},
		},
	}
})

gul.register_potion("orcdraught", "Orc Draught", "gul:orcdraught", 100, {
	effect = "fixhp",
	types = {
		{
			type = 1,
               hp = -1,
               time = 20, 
			set = {},
			effects = {
			},
		},
		{
			type = 2,
               hp = -1,
               time = 50, 
			set = {},
			effects = {
			},
		},
		{
			type = 3,
               hp = -1,
               time = 100, 
			set = {},
			effects = {
			},
		},
	}
})

gul.register_potion("entdraught", "Ent Draught", "gul:entdraught", 240, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			effects = {
                    speed = 1,
                    jump = -0.2,
			},
		},
		{
			type = 2,
			set = {},
			effects = {
                    speed = 2,
                    jump = -0.5,
			},
		},
		{
			type = 3,
			set = {},
			effects = {
                    speed = 3,
                    jump = -1,
			},
		},
	}
})

-- Brews

minetest.register_craftitem( "gul:wine", {
	description = "Wine",
	inventory_image = "gul_wine.png",
	wield_image = "gul_wine.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craftitem( "gul:beer", {
	description = "Beer",
	inventory_image = "gul_beer.png",
	wield_image = "gul_beer.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craftitem( "gul:ale", {
	description = "Ale",
	inventory_image = "gul_ale.png",
	wield_image = "gul_ale.png",
	on_use = minetest.item_eat(5),
})

minetest.register_craftitem( "gul:mead", {
	description = "Mead",
	inventory_image = "gul_mead.png",
	wield_image = "gul_mead.png",
	on_use = minetest.item_eat(5),
})

minetest.register_craftitem( "gul:cider", {
	description = "Cider",
	inventory_image = "gul_cider.png",
	wield_image = "gul_cider.png",
	on_use = minetest.item_eat(4),
})

dofile(minetest.get_modpath("gul").."/potions/potion_ingredients.lua")
dofile(minetest.get_modpath("gul").."/potions/potion_brewing.lua")
dofile(minetest.get_modpath("gul").."/potions/brewing.lua")
dofile(minetest.get_modpath("gul").."/potions/crafting.lua")