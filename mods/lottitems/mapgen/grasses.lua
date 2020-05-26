local grass_list = {
	{"base", "#69af32", 3},
	{"snowy", "#a4c577", 1},
	{"ettenmoors", "#84af86", 1},
	{"arthedain", "#347c24", 3},
	{"breeland", "#438e00", 4},
	{"lindon", "#50bb44", 4},
	{"shire", "#55bf16", 5},
	{"minhiriath", "#a6bc57", 2},
	{"enedwaith", "#96bc13", 2},
	{"eregion", "#78a95c", 2},
	{"dunland", "#57b839", 3},
	{"mirkwood", "#323b08", 2},
	{"lorien", "#befb4a", 5},
	{"fangorn", "#6d8c30", 2},
	{"rohan", "#abb32e", 3},
	{"gondor", "#9db033", 3},
	{"iron_hills", "#54b45d", 2},
	{"rhun", "#7d8522", 3},
	{"wilderland", "#427d47", 3},
	{"blue_mountains", "#5ba490", 2},
	{"white_mountains", "#84d970", 2},
}

for _, tab in pairs(grass_list) do
	minetest.register_node("lottitems:" .. tab[1] .. "_grass", {
		description = lott.str_to_desc(tab[1]) .. " Grass",
		tiles = {{name = "lottitems_grass.png"},
			{name = "lottitems_dirt.png", color = "white"}},
		overlay_tiles = {"", "",
			{name = "lottitems_grass_side.png", tileable_vertical = false}},
		color = tab[2],
		paramtype2 = "color",
		palette = "lottitems_palette_" .. tab[1] .. ".png",
		groups = {[tab[1]] = 1, shovel = 1, grass = 2,
			hand = 3, dirt_with_grass = 1, soil_quality = tab[3]},
		drop = {
			max_items = 2,
			items = {
				{items = {"lottitems:flint"}, rarity = 56},
				{items = {"lottitems:dirt"}}
			}
		},
		is_ground_content = true,
	})
end

minetest.register_node("lottitems:grass_with_leaf_litter", {
	description = "Grass With Leaf Litter",
	tiles = {
		"lottitems_leaf_litter.png",
		"lottitems_dirt.png",
		{name = "lottitems_dirt.png^lottitems_leaf_litter_side.png",
			tileable_vertical = false}
	},
	groups = {shovel = 1, grass = 1, hand = 3, soil_quality = 4},
	drop = "lottitems:dirt",
	is_ground_content = true,
})

