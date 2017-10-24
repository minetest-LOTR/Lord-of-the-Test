local grass_list = {
	{"base", "#000:0"},
	{"snowy", "#000:0"},
	{"ettenmoors", "#930000:70"},
	{"arthedain", "#898940:75"},
	{"breeland", "#729305:65"},
	{"lindon", "#5bf7ea:40"},
	{"shire", "#86ad06:105"},
	{"minhiriath", "#474000:105"},
	{"enedwaith", "#fc7702:40"},
	{"eregion", "#777c75:90"},
	{"dunland", "#35ba3c:50"},
	{"mirkwood", "#331507:120"},
	{"lorien", "#5bf7ea:75"},
	{"fangorn", "#720e6f:30"},
	{"rohan", "#af5301:95"},
	{"gondor", "#000:0"},
	{"iron_hills", "#1cbca7:60"},
	{"rhun", "#663002:90"},
	{"wilderland", "#011075:70"},
	{"blue_mountains", "#8db7d3:75"},
	{"white_mountains", "#acacac:30"},
}

for _, tab in pairs(grass_list) do
	minetest.register_node("lottitems:" .. tab[1] .. "_grass", {
		description = lott.str_to_desc(tab[1]) .. " Grass",
		tiles = {
			"lottitems_grass.png^[colorize:" .. tab[2], "lottitems_dirt.png",
			{name = "lottitems_dirt.png^(lottitems_grass_side.png^[colorize:"
				.. tab[2] .. ")", tileable_vertical = false},
		},
		groups = {[tab[1]] = 1, shovel = 1, grass = 1},
		is_ground_content = true,
	})
end
