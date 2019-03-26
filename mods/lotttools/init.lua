-- Tmp dig all pick!
minetest.register_tool("lotttools:omni_pick", {
	description = "Digs all!",
	inventory_image = "lotttools_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps = {
			pickaxe = {maxlevel = 0, uses = 100,
				times = {[1] = 0.5, [2] = 0.75, [3] = 1, [4] = 0.2}},
			axe = {maxlevel = 0, uses = 100,
				times = {[1] = 0.5, [2] = 0.75, [3] = 1, [4] = 0.2}},
			plant = {maxlevel = 0, uses = 100,
				times = {[1] = 0.5, [2] = 0.75, [3] = 1, [4] = 0.2}},
		}
	},
})
