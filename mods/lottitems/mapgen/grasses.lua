local grass_list = {
	{"base", "#69af32"},
	--{"snowy", "#000:0"},
	{"ettenmoors", "#84af86"},
	{"arthedain", "#347c24"},
	{"breeland", "#438e00"},
	{"lindon", "#50bb44"},
	{"shire", "#55bf16"},
	{"minhiriath", "#a6bc57"},
	{"enedwaith", "#96bc13"},
	{"eregion", "#78a95c"},
	{"dunland", "#57b839"},
	{"mirkwood", "#323b08"},
	{"lorien", "#befb4a"},
	{"fangorn", "#6d8c30"},
	{"rohan", "#abb32e"},
	{"gondor", "#9db033"},
	{"iron_hills", "#54b45d"},
	{"rhun", "#7d8522"},
	{"wilderland", "#427d47"},
	{"blue_mountains", "#5ba490"},
	{"white_mountains", "#84d970"},
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
		groups = {[tab[1]] = 1, shovel = 1, grass = 1},
		is_ground_content = true,
	})
end

