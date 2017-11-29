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

register_flower("dandelion_white", {
	groups = {white = 1, flower = 1, plant = 1}
})

register_flower("dandelion_yellow", {
	groups = {yellow = 1, flower = 1, plant = 1}
})

register_flower("geranium", {
	groups = {blue = 1, flower = 1, plant = 1}
})

register_flower("rose", {
	groups = {red = 1, flower = 1, plant = 1}
})

register_flower("tulip", {
	groups = {orange = 1, flower = 1, plant = 1}
})

register_flower("violet", {
	groups = {purple = 1, flower = 1, plant = 1}
})

-- Lorien

register_flower("elanor", {
	groups = {yellow = 1, flower = 1, plant = 1, lorien = 1}
})

register_flower("lissuin_short", {
	description = "Lissuin (Short)",
	groups = {orange = 1, flower = 1, plant = 1, lorien = 1},
})

register_flower("lissuin_tall_bottom", {
	description = "Lissuin (Tall, bottom)",
	drop = "lottplants:lissuin_tall_top",
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	},
	groups = {orange = 1, flower = 1, plant = 1, lorien = 1, hidden = 1},
})

register_flower("lissuin_tall_top", {
	description = "Lissuin (Tall)",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -1.5, -0.5, 0.5, 0, 0.5},
	},
	groups = {orange = 1, flower = 1, plant = 1, lorien = 1},
})

register_flower("niphredil", {
	visual_scale = 0.75,
	groups = {white = 1, flower = 1, plant = 1, lorien = 1},
})

register_flower("bluebell", {
	visual_scale = 0.75,
	groups = {blue = 1, flower = 1, plant = 1},
})

register_flower("buttercup", {
	visual_scale = 0.75,
	groups = {yellow = 1, flower = 1, plant = 1},
})

register_flower("calla_black", {
	visual_scale = 0.75,
	groups = {black = 1, flower = 1, plant = 1},
})

register_flower("calla_white", {
	visual_scale = 0.75,
	groups = {white = 1, flower = 1, plant = 1},
})

register_flower("encyclia", {
	groups = {black = 1, flower = 1, plant = 1},
})

-- Petuniae

register_flower("petunia_white", {
	groups = {white = 1, flower = 1, plant = 1},
})

register_flower("petunia_pink", {
	groups = {pink = 1, flower = 1, plant = 1},
})

register_flower("petunia_blue", {
	groups = {blue = 1, flower = 1, plant = 1},
})

