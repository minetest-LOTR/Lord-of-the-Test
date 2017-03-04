--Function for random breakages!

local function random_break(pos, chance, output, src_time)
	local inv = minetest.get_meta(pos):get_inventory()
	if math.random(8) > chance then
		if inv:room_for_item("output", output) then
			inv:add_item("output", output)
			for i = 1, 2 do
				local s = inv:get_stack("input", i)
				local n = s:get_name()
				local c = s:get_count()
				inv:set_stack("input", i, n .. " " .. c - 1)
			end
			src_time = 0
		end
	else
		for i = 1, 2 do
			local s = inv:get_stack("input", i)
			local n = s:get_name()
			local c = s:get_count()
			inv:set_stack("input", i, n .. " " .. c - 1)
		end
		src_time = 0
	end
	return src_time
end

--------------------
-- Forming a ring --
--------------------

minetest.register_craftitem("lottother:quarter_ring", {
	description = "Quarter Ring",
	inventory_image = "lottother_quarter_ring.png",
    groups = {forbidden=1},
})

minetest.register_craftitem("lottother:half_ring", {
	description = "Half Ring",
	inventory_image = "lottother_half_ring.png",
    groups = {forbidden=1},
})

minetest.register_craftitem("lottother:ring", {
	description = "Plain Ring",
	inventory_image = "lottother_ring.png",
	groups = {forbidden=1},
})

lottblocks.crafting.add_craft("lottother:quarter_ring", {
	recipe = {"lottother:ringsilver", "lottother:ringsilver"},
	type = "dualfurn",
	time = 7,
	func = function(pos, output, src_time)
		return random_break(pos, 1, output, src_time)
	end,
})

lottblocks.crafting.add_craft("lottother:half_ring", {
	recipe = {"lottother:quarter_ring", "lottother:quarter_ring"},
	type = "dualfurn",
	time = 14,
	func = function(pos, output, src_time)
		return random_break(pos, 2, output, src_time)
	end,
})

lottblocks.crafting.add_craft("lottother:ring", {
	recipe = {"lottother:half_ring", "lottother:half_ring"},
	type = "dualfurn",
	time = 28,
	func = function(pos, output, src_time)
		return random_break(pos, 3, output, src_time)
	end
})

---------------------------------
-- Attaching a gem to the ring --
---------------------------------

-- Preparing the ring

minetest.register_craftitem("lottother:pin", {
	description = "Pin",
	inventory_image = "lottother_pin.png",
	groups = {forbidden=1},
})

minetest.register_craftitem("lottother:prepared_ring", {
	description = "Prepared Ring",
	inventory_image = "lottother_prepared_ring.png",
	groups = {forbidden=1},
})

minetest.register_craft({
	output = "lottother:pin 2",
	type = "shapeless",
	recipe = {"lottother:ringsilver"},
})

minetest.register_craft({
	output = "lottother:prepared_ring",
	recipe = {
		{"lottother:pin", "", "lottother:pin"},
		{"", "lottother:ring", ""},
	}
})

-- The basic gemed rings.

minetest.register_craftitem("lottother:blue_gem_ring", {
	description = "Blue Gem Ring.",
	inventory_image = "lottother_bluegem_ring.png",
	groups = {forbidden=1},
})

minetest.register_craftitem("lottother:red_gem_ring", {
	description = "Red Gem Ring",
	inventory_image = "lottother_redgem_ring.png",
    groups = {forbidden=1},
})

minetest.register_craftitem("lottother:purple_gem_ring", {
	description = "Purple Gem Ring",
	inventory_image = "lottother_purplegem_ring.png",
    groups = {forbidden=1},
})

minetest.register_craftitem("lottother:white_gem_ring", {
	description = "White Gem Ring",
	inventory_image = "lottother_whitegem_ring.png",
    groups = {forbidden=1},
})

lottblocks.crafting.add_craft("lottother:blue_gem_ring", {
	recipe = {"lottother:prepared_ring", "lottother:blue_gem"},
	type = "dualfurn",
	time = 60,
	func = function(pos, output, src_time)
		return random_break(pos, 2, output, src_time)
	end
})

lottblocks.crafting.add_craft("lottother:red_gem_ring", {
	recipe = {"lottother:prepared_ring", "lottother:red_gem"},
	type = "dualfurn",
	time = 60,
	func = function(pos, output, src_time)
		return random_break(pos, 2, output, src_time)
	end
})

lottblocks.crafting.add_craft("lottother:purple_gem_ring", {
	recipe = {"lottother:prepared_ring", "lottother:purple_gem"},
	type = "dualfurn",
	time = 60,
	func = function(pos, output, src_time)
		return random_break(pos, 2, output, src_time)
	end
})

lottblocks.crafting.add_craft("lottother:white_gem_ring", {
	recipe = {"lottother:prepared_ring", "lottother:white_gem"},
	type = "dualfurn",
	time = 60,
	func = function(pos, output, src_time)
		return random_break(pos, 2, output, src_time)
	end
})

---------------------------------
-- Imbuing the ring with power --
---------------------------------

-- First add a rough rock coating

minetest.register_craftitem("lottother:blue_rr_ring", {
	description = "Rough Rock Blue Ring",
	inventory_image = "lottother_bluegem_rr_ring.png",
	groups = {forbidden=1, ring = 1},
	stack_max = 1,
})

minetest.register_craftitem("lottother:red_rr_ring", {
	description = "Rough Rock Red Ring",
	inventory_image = "lottother_redgem_rr_ring.png",
	groups = {forbidden=1, ring = 1},
	stack_max = 1,
})

minetest.register_craftitem("lottother:purple_rr_ring", {
	description = "Rough Rock Purple Ring",
	inventory_image = "lottother_purplegem_rr_ring.png",
	groups = {forbidden=1, ring = 1},
	stack_max = 1,
})

minetest.register_craftitem("lottother:white_rr_ring", {
	description = "Rough Rock White Ring",
	inventory_image = "lottother_whitegem_rr_ring.png",
	groups = {forbidden=1, ring = 1},
	stack_max = 1,
})

minetest.register_craft({
	output = "lottother:blue_rr_ring",
	recipe = {
		{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
		{"lottores:rough_rock_lump", "lottother:blue_gem_ring", "lottores:rough_rock_lump"},
		{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	},
})

minetest.register_craft({
	output = "lottother:red_rr_ring",
	recipe = {
		{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
		{"lottores:rough_rock_lump", "lottother:red_gem_ring", "lottores:rough_rock_lump"},
		{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	},
})

minetest.register_craft({
	output = "lottother:purple_rr_ring",
	recipe = {
		{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
		{"lottores:rough_rock_lump", "lottother:purple_gem_ring", "lottores:rough_rock_lump"},
		{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	},
})

minetest.register_craft({
	output = "lottother:white_rr_ring",
	recipe = {
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottother:white_gem_ring", "lottores:rough_rock_lump"},
	{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
	},
})

-- Then cook in a special furnace!
-- It's hard-coded, but has only one purpose (and, ofc, gets destroyed when used, 100% chance!)

local formspec = "size[8,8]"..
	"background[-0.5,-0.65;9,9.35;gui_elfbg.png]"..
	"list[current_player;main;0,3.75;8,1;]"..
	"list[current_player;main;0,5;8,3;8]"..
	"list[context;ring;3.5,1.5;1,1;]"..
	"label[2.25,0.7;Galvorn]"..
	"list[context;galvorn;3.5,0.5;1,1;]"..
	"label[1.5,1.7;Mithril]"..
	"list[context;mithril;2.5,1.5;1,1;]"..
	"label[5.5,1.7;Tilkal]"..
	"list[context;tilkal;4.5,1.5;1,1;]"..
	"label[2.5,2.7;Fuel]"..
	"list[context;fuel;3.5,2.5;1,1;]"..
	"image[4.5,2.5;1,1;default_furnace_fire_bg.png]"..
	"image[5.5,2.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("goldsilver") and inv:is_empty("mithril")
		and inv:is_empty("roughrock") and inv:is_empty("fuel")
end

local function check_nodes(pos)
	for x = -1, 1 do
	for z = -1, 1 do
		local npos = {x = pos.x + x, y = pos.y - 1, z = pos.z + z}
		if minetest.get_node(npos).name ~= "default:lava_source" then
			return false
		end
	end
	end
	return true
end

local function is_cookable(inv)
	if inv:contains_item("mithril", "lottores:mithril_block")
	and inv:contains_item("tilkal", "lottores:tilkal")
	and inv:contains_item("galvorn", "lottores:galvorn_block") then
		if inv:contains_item("ring", "lottother:blue_rr_ring") then
			return true, "vilya"
		elseif inv:contains_item("ring", "lottother:red_rr_ring") then
			return true, "narya"
		elseif inv:contains_item("ring", "lottother:white_rr_ring") then
			return true, "nenya"
		elseif inv:contains_item("ring", "lottother:purple_rr_ring") then
			return true, "dwarf_ring"
		end
	end
	return false
end

local function take_items(inv)
	local c = inv:get_stack("mithril", 1):get_count() - 1
	inv:set_stack("mithril", 1, "lottores:mithril_block " .. c)
	c = inv:get_stack("goldsilver", 1):get_count() - 1
	inv:set_stack("tilkal", 1, "lottores:tilkal " .. c)
	c = inv:get_stack("galvorn", 1):get_count() - 1
	inv:set_stack("galvorn", 1, "lottores:galvorn_block " .. c)
	inv:set_stack("ring", 1, "")
end

local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

local function furnace_node_timer(pos, elapsed)
	local meta = minetest.get_meta(pos)
	local fuel_time = meta:get_float("fuel_time") or 0
	local src_time = meta:get_float("src_time") or 0
	local fuel_totaltime = meta:get_float("fuel_totaltime") or 0
	local time = 1800

	local inv = meta:get_inventory()
	local fuel = inv:get_list("fuel")
	local cookable, ring = is_cookable(inv)

	-- Check if we have enough fuel to burn
	if fuel_time < fuel_totaltime then
		-- The furnace is currently active and has enough fuel
		fuel_time = fuel_time + 1

		-- If there is a cookable item then check if it is ready yet
		if cookable then
			src_time = src_time + 1
			if src_time % 50 == 0 then
				if check_nodes(pos) == false then
					default.explode(pos, 0, 4, 20)
				end
			end
			if src_time >= time then
				take_items(inv)
				if math.random(1,3) == 1 then
					local item = minetest.add_item({x=pos.x, y=pos.y+1, z=pos.z},
						"lottother:" .. ring)
					item:setvelocity({x=0, y=10, z=0})
					default.explode(pos, 0, 14, 100)
				else
					default.explode(pos, 0, 5, 20)
				end
				src_time = 0
			end
		end
	else
		-- Furnace ran out of fuel
		if cookable then
			-- We need to get new fuel
			local fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuel})

			if fuel.time == 0 then
				-- No valid fuel in fuel list
				fuel_totaltime = 0
				fuel_time = 0
				src_time = 0
			else
				-- Take fuel from fuel list
				inv:set_stack("fuel", 1, afterfuel.items[1])

				fuel_totaltime = fuel.time
				fuel_time = 0
			end
		else
			-- We don't need to get new fuel since there is no cookable item
			fuel_totaltime = 0
			fuel_time = 0
			src_time = 0
		end
	end

	--
	-- Update formspec, infotext and node
	--

	local item_state = ""

	local fuel_state = "Empty"
	local active = "inactive "
	local result = false
	local item_percent = 0
	local new_formspec = formspec
	if time then
		item_percent = math.floor(src_time / time * 100)
	end
	if fuel_time <= fuel_totaltime and fuel_totaltime ~= 0 then
		swap_node(pos, "lottother:ring_furnace_active")
		result = true
		local fuel_percent = math.floor(fuel_time / fuel_totaltime * 100)
		new_formspec = new_formspec ..
			"image[5.5,2.5;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
			(item_percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
			"image[4.5,2.5;1,1;default_furnace_fire_bg.png^[lowpart:"..
			(100-fuel_percent)..":default_furnace_fire_fg.png]"
	else
		swap_node(pos, "lottother:ring_furnace_inactive")
		local timer = minetest.get_node_timer(pos)
		timer:stop()
	end

	--
	-- Set meta values
	--
	meta:set_float("fuel_totaltime", fuel_totaltime)
	meta:set_float("fuel_time", fuel_time)
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", new_formspec)

	return result
end

--
-- Node definitions
--

for _, status in pairs({"active", "inactive"}) do
	local groups = {forbidden=1, very_hard=1, creative=1}
	if status == "active" then
		groups.not_in_creative_inventory = 1
	end
	minetest.register_node("lottother:ring_furnace_" .. status, {
		description = "Ring Furnace",
		tiles = {
			"lottother_ring_furnace_side.png",
			"lottother_ring_furnace_side.png",
			"lottother_ring_furnace_side.png",
			"lottother_ring_furnace_side.png",
			"lottother_ring_furnace_side.png",
			"lottother_ring_furnace_front_" .. status .. ".png"
		},
		paramtype2 = "facedir",
		groups = groups,
		drop = "lottother:ring_furnace_inactive",
		legacy_facedir_simple = true,
		is_ground_content = false,
		can_dig = can_dig,

		on_timer = furnace_node_timer,

		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("tilkal", 1)
			inv:set_size("mithril", 1)
			inv:set_size("galvorn", 1)
			inv:set_size("ring", 1)
			inv:set_size("fuel", 1)
			meta:set_string("infotext", "Ringsilver Furnace")
			meta:set_string("formspec", formspec)
		end,

		on_metadata_inventory_move = function(pos)
			local timer = minetest.get_node_timer(pos)
			timer:start(1.0)
		end,
		on_metadata_inventory_put = function(pos)
			-- start timer function, it will sort out whether furnace can burn or not.
			local timer = minetest.get_node_timer(pos)
			timer:start(1.0)
		end,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			if listname == "fuel" then
				if minetest.get_craft_result({method="fuel", width=1, items={stack}}).time ~= 0 then
					return stack:get_count()
				end
			elseif listname == "galvorn" then
				if stack:get_name() == "lottores:galvorn_block" then
					return 1
				end
			elseif listname == "tilkal" then
				if stack:get_name() == "lottores:tilkal" then
					return 1
				end
			elseif listname == "mithril" then
				if stack:get_name() == "lottores:mithril_block" then
					return 1
				end
			elseif listname == "ring" then
				if stack:get_definition().groups.ring == 1 then
					return 1
				end
			end
			return 0
		end,
		allow_metadata_inventory_move = function()
			return 0
		end,
		on_place = function(itemstack, placer, pointed_thing)
			if check_nodes(pointed_thing.above) == false then
				minetest.chat_send_player(placer:get_player_name(),
					"This area is not hot enough for a ringsilver furnace.")
				return
			end
			return minetest.item_place(itemstack, placer, pointed_thing)
		end,
	})
end

minetest.register_craft({
	output = "lottother:ring_furnace_inactive",
	recipe = {
		{"lottores:galvorn_block", "lottores:mithril_block", "lottores:galvorn_block"},
		{"default:steelblock", "lottother:ringsilver_furnace_inactive", "default:steelblock"},
		{"lottores:tilkal", "lottores:mithril_block", "lottores:tilkal"},
	},
})
