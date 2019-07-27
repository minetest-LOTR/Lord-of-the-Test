local modp = minetest.get_modpath("lottblocks")
local function guide_on_use(itemstack, user)
	local player_name = user:get_player_name()
	local data = minetest.registered_items[itemstack:get_name()].text

	title = data.title
	text = data.text
	owner = data.owner
	background = data.background or "gui_elfbg.png"

	local formspec = "size[8,8]" ..
		"background[8,8;1,1;" .. background .. ";true]"..
		"label[0.5,0.5;by " .. owner .. "]" ..
		"label[0.4,0;" .. minetest.colorize("yellow", minetest.formspec_escape(title)) .. "]" ..
		"textarea[0.5,1.5;7.5,7;;" ..
		minetest.formspec_escape(text) .. ";]"

	minetest.show_formspec(player_name, "lottother:guide", formspec)
end

minetest.register_craftitem("lottblocks:palantir_guide", {
	description = "Palantir Guidebook",
	inventory_image = "default_book.png^[colorize:darkblue:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/palantir_guide.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craft({
	type = "shapeless",
	output = "lottblocks:palantir_guide",
	recipe = {"default:book", "lottblocks:palantir"},
	replacements = {{"lottblocks:palantir", "lottblocks:palantir"}}
})

minetest.register_craftitem("lottblocks:ring_guide", {
	description = "Ring Guidebook Vol I",
	inventory_image = "default_book.png^[colorize:pink:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/ring_guide.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craftitem("lottblocks:ring_guide_2", {
	description = "Ring Guidebook Vol II",
	inventory_image = "default_book.png^[colorize:pink:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/ring_guide_2.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craftitem("lottblocks:deep_depths", {
	description = "Deep Depths",
	inventory_image = "default_book.png^[colorize:black:200",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/deep_depths.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craftitem("lottblocks:farmer_handbook", {
	description = "Hobbit Farmer Essentials Vol I",
	inventory_image = "default_book.png^[colorize:green:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/farmer_handbook.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craftitem("lottblocks:farmer_handbook_2", {
	description = "Hobbit Farmer Essentials Vol II",
	inventory_image = "default_book.png^[colorize:green:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/farmer_handbook_2.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craftitem("lottblocks:miner_handbook", {
	description = "Dwarven Miner Handbook Vol I",
	inventory_image = "default_book.png^[colorize:grey:150",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/miner_handbook.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craftitem("lottblocks:miner_handbook_2", {
	description = "Dwarven Miner Handbook Vol II",
	inventory_image = "default_book.png^[colorize:grey:150",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/miner_handbook_2.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craftitem("lottblocks:miner_handbook_3", {
	description = "Dwarven Miner Handbook Vol III",
	inventory_image = "default_book.png^[colorize:grey:150",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/miner_handbook_3.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craftitem("lottblocks:explorer_guide", {
	description = "Explorers' Guide Vol I",
	inventory_image = "default_book.png^[colorize:red:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/explorer_guide.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craftitem("lottblocks:explorer_guide_2", {
	description = "Explorers' Guide Vol II",
	inventory_image = "default_book.png^[colorize:red:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/explorer_guide_2.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})
minetest.register_craftitem("lottblocks:explorer_guide_3", {
	description = "Explorers' Guide Vol III",
	inventory_image = "default_book.png^[colorize:red:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/explorer_guide_3.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craftitem("lottblocks:brewing_guide", {
	description = "Art of Barrel Brewing",
	inventory_image = "default_book.png^[colorize:orange:150",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/brewing_guide.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craftitem("lottblocks:brewing_guide_2", {
	description = "Art of Potion Brewing",
	inventory_image = "default_book.png^[colorize:orange:150",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dofile(modp.."/guide_text/brewing_guide_2.lua")),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})