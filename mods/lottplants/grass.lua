local function register_grass(name, heights, def)
	minetest.register_node("lottplants:" .. name .. "_" .. heights, {
		description = lott.str_to_desc(name),
		drawtype = "plantlike",
		tiles = {"lottplants_" .. name .. "_" .. heights .. ".png"},
		inventory_image = "lottplants_" .. name .. "_" .. heights .. ".png",
		paramtype = "light",
		paramtype2 = "meshoptions",
		buildable_to = true,
		walkable = false,
		waving = 1,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
		},
		groups = def.groups or {green = 1, grass = 1, plant = 1}
	})

	if def.groups then
		def.groups["hidden"] = 1
	end
	for i = 1, heights - 1 do
		minetest.register_node("lottplants:" .. name .. "_" .. i, {
			description = lott.str_to_desc(name),
			drawtype = "plantlike",
			tiles = {"lottplants_" .. name .. "_" .. i .. ".png"},
			inventory_image = "lottplants_" .. name .. "_" .. heights .. ".png",
			paramtype = "light",
			paramtype2 = "meshoptions",
			buildable_to = true,
			walkable = false,
			waving = 1,
			drop = "lottplants:" .. name .. "_" .. heights,
			selection_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
			},
			groups = def.groups or {green = 1, grass = 1, plant = 1, hidden = 1}
		})
	end
end

-- Normal Grass

register_grass("grass", 5, {})

-- Lorien Grass

register_grass("lorien_grass", 3, {
	groups = {green = 1, grass = 1, plant = 1, lorien = 1}
})

-- Mountain Grass
minetest.register_node("lottplants:mountain_grass", {
	description = "Mountain Grass",
	drawtype = "plantlike",
	tiles = {"lottplants_mountain_grass.png"},
	inventory_image = "lottplants_mountain_grass.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	buildable_to = true,
	walkable = false,
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
	groups = {green = 1, grass = 1, plant = 1}
})
