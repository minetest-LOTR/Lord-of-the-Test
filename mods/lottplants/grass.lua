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

-- Pine Grass
register_grass("pine_grass", 3, {})

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

-- Mountain Shrub
minetest.register_node("lottplants:mountain_shrub", {
	description = "Mountain Shrub",
	drawtype = "plantlike",
	tiles = {"lottplants_mountain_shrub.png"},
	inventory_image = "lottplants_mountain_shrub.png",
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

-- Dry Shrub
minetest.register_node("lottplants:dry_shrub", {
	description = "Dry Shrub",
	drawtype = "plantlike",
	tiles = {"lottplants_dry_shrub.png"},
	inventory_image = "lottplants_dry_shrub.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	buildable_to = true,
	walkable = false,
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
	groups = {brown = 1, grass = 1, plant = 1}
})

-- Tall Grass
minetest.register_node("lottplants:tall_grass_bottom", {
	description = "Tall Grass",
	drawtype = "plantlike",
	visual_scale = 1.15,
	tiles = {"lottplants_tall_grass_bottom.png"},
	inventory_image = "lottplants_tall_grass_bottom.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	buildable_to = true,
	walkable = false,
	groups = {green = 1, grass = 1, plant = 1},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.7, 0.5},
	},
	on_construct = function(pos)
		local posa = {x = pos.x, y = pos.y + 1, z = pos.z}
		minetest.set_node(posa, {name = "lottplants:tall_grass_" .. math.random(1, 5)})
	end,
	on_destruct = function(pos)
		local posa = {x = pos.x, y = pos.y + 1, z = pos.z}
		local name = minetest.get_node(posa).name
		if name:sub(1, 22) == "lottplants:tall_grass_" then
			minetest.remove_node(posa)
		end
	end,
})

for i = 1, 5 do
	minetest.register_node("lottplants:tall_grass_" .. i, {
		description = "Tall Grass Top",
		drawtype = "plantlike",
		visual_scale = 1.15,
		tiles = {"lottplants_tall_grass_" .. i .. ".png"},
		inventory_image = "lottplants_tall_grass_" .. i .. ".png",
		wield_image = "lottplants_tall_grass_" .. i .. ".png",
		paramtype = "light",
		paramtype2 = "meshoptions",
		buildable_to = true,
		walkable = false,
		pointable = false,
		groups = {green = 1, grass = 1, plant = 1},
		drop = "lottplants:tall_grass_bottom",
	})
end
