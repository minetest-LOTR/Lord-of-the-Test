local lpp = 13
local function guide_on_use(itemstack, user)
	local player_name = user:get_player_name()
	local data = minetest.registered_items[itemstack:get_name()].text
	local page_info = minetest.deserialize(itemstack:get_metadata())
	local title, text, owner = "", "", player_name
	local page, page_max, lines, string = 1, 1, {}, ""

	title = data.title
	text = data.text
	owner = data.owner
	page_max = data.page_max
	background = data.background or "gui_elfbg.png"

	for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
		lines[#lines+1] = str
	end

	if page_info then
		if page_info.page then
			page = page_info.page
		end
	end

	for i = ((lpp * page) - lpp) + 1, lpp * page do
		if not lines[i] then break end
		string = string .. lines[i] .. "\n"
	end

	local formspec = "size[8,8]" ..
		"background[8,8;1,1;" .. background .. ";true]"..
		"label[0.5,0.5;by " .. owner .. "]" ..
		"label[0.4,0;" .. minetest.colorize("yellow", minetest.formspec_escape(title)) .. "]" ..
		"textarea[0.5,1.5;7.5,7;;" ..
		minetest.formspec_escape(string ~= "" and string or text) .. ";]" ..
		"button[2.4,7.6;0.8,0.8;book_prev;<]" ..
		"label[3.1,7.7;Page " .. page .. " of " .. page_max .. "]" ..
		"button[5.2,7.6;0.8,0.8;book_next;>]"

	minetest.show_formspec(player_name, "lottother:guide", formspec)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "lottother:guide" then return end
	local inv = player:get_inventory()
	local stack = player:get_wielded_item()

	if fields.book_next or fields.book_prev then
		local data = minetest.registered_items[stack:get_name()].text
		local page_info = minetest.deserialize(stack:get_metadata())
		if not page_info then
			page_info = {page = 1}
		end

		if fields.book_next then
			page_info.page = page_info.page + 1
			if page_info.page > data.page_max then
				page_info.page = 1
			end
		else
			page_info.page = page_info.page - 1
			if page_info.page == 0 then
				page_info.page = data.page_max
			end
		end

		local data_str = minetest.serialize(page_info)
		stack:set_metadata(data_str)
		guide_on_use(stack, player)
	end

	player:set_wielded_item(stack)
end)

local palantir_guide = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/palantir_guide.lua")

minetest.register_craftitem("lottblocks:palantir_guide", {
	description = "Palantir Guidebook",
	inventory_image = "default_book.png^[colorize:darkblue:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(palantir_guide),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})


local lore_poem1 = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/lore_poem1.lua")

minetest.register_craftitem("lottblocks:lore_scroll1", {
	description = "Scroll labeled A GILTHONIEL",
	inventory_image = "scroll.png",
	groups = {forbidden = 1, not_in_creative_inventory = 1},
	stack_max = 1,
	text = minetest.deserialize(lore_poem1),
	on_use = function(itemstack, user)	
		 guide_on_use(itemstack, user)
	end,
})

local lore_poem2 = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/lore_poem2.lua")

minetest.register_craftitem("lottblocks:lore_scroll2", {
	description = "Scroll labeled RALMENLETH",
	inventory_image = "scroll.png",
	groups = {forbidden = 1, not_in_creative_inventory = 1},
	stack_max = 1,
	text = minetest.deserialize(lore_poem2),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

--local lore_poem3 = dofile(minetest.get_modpath("lottblocks")
--	.. "/guide_text/lore_poem3.lua")

--minetest.register_craftitem("lottblocks:lore_scroll3", {
--	description = "Scroll labeled LEKH",
--	inventory_image = "scroll.png",
--	groups = {forbidden = 1, not_in_creative_inventory = 1},
--	stack_max = 1,
--	text = minetest.deserialize(lore_poem3),
--	on_use = function(itemstack, user)
--		guide_on_use(itemstack, user)
--	end,
--})
--COMING SOON
--local lore_story1 = dofile(minetest.get_modpath("lottblocks")
--	.. "/guide_text/lore_story1.lua")
--
--minetest.register_craftitem("lottblocks:lore_book1", {
--	description = "A tattered book",
--	inventory_image = "default_book.png",
--	groups = {book=1, not_in_creative_inventory=1},
--	stack_max = 1,
--	text = minetest.deserialize(lore_story1)
--	on_use = function(itemstack, user)
--		guide_on_use(itemstack, user)
--	end,
--})

minetest.register_craft({
	type = "shapeless",
	output = "lottblocks:palantir_guide",
	recipe = {"default:book", "lottblocks:palantir"},
	replacements = {{"lottblocks:palantir", "lottblocks:palantir"}}
})

local ring_guide = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/ring_guide.lua")

minetest.register_craftitem("lottblocks:ring_guide", {
	description = "Ring Guidebook",
	inventory_image = "default_book.png^[colorize:pink:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(ring_guide),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

-- No craft for the ring guide, can only be found in generated structures.
