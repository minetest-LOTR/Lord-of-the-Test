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
		groups = def.groups or {green = 1, grass = 1, hand = 2, plant = 1}
	})

	if def.groups then
		def.groups["not_in_creative_inventory"] = 1
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
			groups = def.groups or {green = 1, grass = 1, plant = 1, hand = 2, not_in_creative_inventory = 1}
		})
	end
end

-- Normal Grass

register_grass("grass", 5, {})

-- Dry Grass

register_grass("dry_grass", 5, {})

-- Lorien Grass

register_grass("lorien_grass", 3, {
	groups = {green = 1, grass = 1, plant = 1, hand = 2, lorien = 1}
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
	groups = {green = 1, grass = 1, hand = 2, plant = 1}
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
	groups = {brown = 1, grass = 1, plant = 1, hand = 2}
})

-- Tall Grass
local tall_grasses = {
	"grass",
	"dry_grass",
}

for _, name in pairs(tall_grasses) do
	minetest.register_node("lottplants:tall_" .. name .. "_bottom", {
		description = "Tall " .. lott.str_to_desc(name),
		drawtype = "plantlike",
		visual_scale = 1.15,
		tiles = {"lottplants_tall_" .. name .. "_bottom.png"},
		inventory_image = "lottplants_tall_" .. name .. "_bottom.png",
		paramtype = "light",
		paramtype2 = "meshoptions",
		buildable_to = true,
		walkable = false,
		groups = {green = 1, grass = 1, plant = 1, hand = 2},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.7, 0.5},
		},
		on_construct = function(pos)
			local posa = {x = pos.x, y = pos.y + 1, z = pos.z}
			minetest.set_node(posa, {name = "lottplants:tall_" .. name .. "_" .. math.random(1, 5)})
		end,
		on_destruct = function(pos)
			local posa = {x = pos.x, y = pos.y + 1, z = pos.z}
			local nodename = minetest.get_node(posa).name
			local num = "lottplants:tall_" .. name .. "_"
			if nodename:sub(1, #num) == "lottplants:tall_" .. name .. "_" then
				minetest.remove_node(posa)
			end
		end,
	})

	for i = 1, 5 do
		minetest.register_node("lottplants:tall_" .. name .. "_" .. i, {
			description = "Tall " .. lott.str_to_desc(name) .. " Top",
			drawtype = "plantlike",
			visual_scale = 1.15,
			tiles = {"lottplants_tall_" .. name .. "_" .. i .. ".png"},
			inventory_image = "lottplants_tall_" .. name .. "_" .. i .. ".png",
			wield_image = "lottplants_tall_" .. name .. "_" .. i .. ".png",
			paramtype = "light",
			paramtype2 = "meshoptions",
			buildable_to = true,
			walkable = false,
			pointable = false,
			groups = {green = 1, grass = 1, plant = 1},
			drop = "lottplants:tall_" .. name .. "_bottom",
		})
	end
end

