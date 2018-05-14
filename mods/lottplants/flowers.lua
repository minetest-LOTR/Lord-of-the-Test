-- Function to make registering flowers easier!
local function register_flower(name, def)
	minetest.register_node("lottplants:" .. name, {
		description = def.description or lott.str_to_desc(name),
		drawtype = "plantlike",
		tiles = {"lottplants_" .. name .. ".png"},
		inventory_image = "lottplants_" .. name .. ".png",
		paramtype = "light",
		paramtype2 = def.paramtype2 or "meshoptions",
		buildable_to = true,
		walkable = false,
		waving = 1,
		drop = def.drop or "lottplants:" .. name,
		visual_scale = def.visual_scale or 1,
		selection_box = def.selection_box or {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
		},
		groups = def.groups,
	})
end

-- Basic flowers

register_flower("chrysanthemum_green", {
	groups = {green = 1, flower = 1, hand = 2, plant = 1}
})

register_flower("dandelion_white", {
	groups = {white = 1, flower = 1, hand = 2, plant = 1}
})

register_flower("dandelion_yellow", {
	groups = {yellow = 1, flower = 1, hand = 2, plant = 1}
})

register_flower("geranium", {
	groups = {blue = 1, flower = 1, hand = 2, plant = 1}
})

register_flower("rose", {
	groups = {red = 1, flower = 1, hand = 2, plant = 1}
})

register_flower("tulip", {
	groups = {orange = 1, flower = 1, hand = 2, plant = 1}
})

register_flower("tulip_black", {
	groups = {black = 1, flower = 1, hand = 2, plant = 1}
})

register_flower("violet", {
	groups = {purple = 1, flower = 1, hand = 2, plant = 1}
})

-- Lorien

register_flower("elanor", {
	groups = {yellow = 1, flower = 1, hand = 2, plant = 1, lorien = 1}
})

register_flower("lissuin_short", {
	description = "Lissuin (Short)",
	groups = {orange = 1, flower = 1, hand = 2, plant = 1, lorien = 1},
})

register_flower("lissuin_tall_bottom", {
	description = "Lissuin (Tall, bottom)",
	drop = "lottplants:lissuin_tall_top",
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	},
	groups = {orange = 1, flower = 1, hand = 2, plant = 1, lorien = 1, hidden = 1},
})

register_flower("lissuin_tall_top", {
	description = "Lissuin (Tall)",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -1.5, -0.5, 0.5, 0, 0.5},
	},
	groups = {orange = 1, flower = 1, hand = 2, plant = 1, lorien = 1},
})

register_flower("niphredil", {
	visual_scale = 0.75,
	groups = {white = 1, flower = 1, hand = 2, plant = 1, lorien = 1},
})

-- General

register_flower("bluebell", {
	visual_scale = 0.75,
	groups = {blue = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("buttercup", {
	visual_scale = 0.75,
	groups = {yellow = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("calla_black", {
	visual_scale = 0.75,
	groups = {black = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("calla_white", {
	visual_scale = 0.75,
	groups = {white = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("encyclia", {
	groups = {black = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("lilly", {
	groups = {white = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("iris_blue", {
	groups = {blue = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("iris_purple", {
	groups = {purple = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("amaryllis_pink", {
	groups = {pink = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("amaryllis_red", {
	groups = {red = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("amaryllis_white", {
	groups = {white = 1, flower = 1, hand = 2, plant = 1},
})


-- Petuniae

register_flower("petunia_white", {
	groups = {white = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("petunia_pink", {
	groups = {pink = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("petunia_blue", {
	groups = {blue = 1, flower = 1, hand = 2, plant = 1},
})

-- Gerberae

register_flower("gerbera_orange", {
	groups = {orange = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("gerbera_pink", {
	groups = {pink = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("gerbera_red", {
	groups = {red = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("gerbera_yellow", {
	groups = {yellow = 1, flower = 1, hand = 2, plant = 1},
})

-- Mountain Flowers

register_flower("parnassus", {
	groups = {purple = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("snow_glory", {
	groups = {purple = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("sericea", {
	groups = {pink = 1, flower = 1, hand = 2, plant = 1},
})

register_flower("menelluin", {
	groups = {blue = 1, flower = 1, hand = 2, plant = 1},
})

-- Desert Flowers

register_flower("desert_canaigre", {
	groups = {brown = 1, flower = 1, harad = 1, hand = 2, plant = 1},
})

register_flower("desert_bigelow", {
	groups = {purple = 1, flower = 1, harad = 1, hand = 2, plant = 1},
})

register_flower("desert_plume", {
	groups = {pink = 1, flower = 1, harad = 1, hand = 2, plant = 1},
})

register_flower("desert_phacelia", {
	groups = {purple = 1, flower = 1, harad = 1, hand = 2, plant = 1},
})

register_flower("desert_poppy", {
	groups = {red = 1, flower = 1, harad = 1, hand = 2, plant = 1},
})

register_flower("desert_star", {
	groups = {yellow = 1, flower = 1, harad = 1, hand = 2, plant = 1},
})

-- Special flowers
-- Sunflower
-- Code & model by kazea, https://forum.minetest.net/viewtopic.php?t=10448

local box = {
	type="fixed",
	fixed = { { -0.2, -0.5, -0.2, 0.2, 0.5, 0.2 } },
}

minetest.register_node("lottplants:sunflower", {
	description = "Sunflower",
	drawtype = "mesh",
	visual_scale = 1.25,
	paramtype = "light",
	paramtype2 = "facedir",
	inventory_image = "lottplants_sunflower_inv.png",
	mesh = "lottplants_sunflower.obj",
	tiles = {"lottplants_sunflower.png"},
	walkable = false,
	buildable_to = true,
	groups = {dig_immediate=3, oddly_breakable_by_hand=1, flora=1},
	selection_box = box,
	collision_box = box,
})

