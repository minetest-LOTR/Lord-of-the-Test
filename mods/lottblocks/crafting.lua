lottblocks.crafting = {}
lottblocks.crafts = {}

---
--- Basic functions:
---

local function tablematch(t1, t2, a)
	for i=1,a do
		if t1[i] ~= t2[i] then return false end
	end
	return true
end

local function can_dig(pos, list1, list2, list3, list4)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	if list4 then
		return inv:is_empty(list1) and inv:is_empty(list2)
		and inv:is_empty(list3) and inv:is_empty(list4)
	elseif list3 then
		return inv:is_empty(list1) and inv:is_empty(list2)
		and inv:is_empty(list3)
	elseif list2 then
		return inv:is_empty(list1) and inv:is_empty(list2)
	else
		return inv:is_empty(list1)
	end
end

function lottblocks.crafting.add_craft(output, recipe)
	local output_name = string.gsub(output, ":", "_", 1)
	lottblocks.crafts[output_name] = recipe
end

---
--- End basic functions, begin dual furnace!
---

local formspec =
	"size[8,9]"..
	"image[2,2;1,1;default_furnace_fire_bg.png^[lowpart:"..
	":default_furnace_fire_fg.png]"..
	"image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
	":gui_furnace_arrow_fg.png^[transformR270]"..
	"list[current_name;fuel;2,3;1,1;]"..
	"list[current_name;input;1.5,1;2,1;]"..
	"list[current_name;output;5,1;2,1;]"..
	"list[current_player;main;0,5;8,4;]"..
	"background[-0.5,-0.65;9,10.35;gui_furnacebg.png]"..
	"listcolors[#606060AA;#888;#141318;#30434C;#FFF]" ..
	"listring[current_name;src]"..
	"listring[current_player;main]"

local function check_craft(pos, list)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local wear = 0
	local x = {}
	for i,v in pairs(lottblocks.crafts) do
		if v.type == "dualfurn" then
			local time = v.time or 3
			if inv:get_stack("input", 1):get_name() == v.recipe[1] and
			inv:get_stack("input", 2):get_name() == v.recipe[2] then
				return true, i, time, v.func
			elseif inv:get_stack("input", 1):get_name() == v.recipe[2] and
			inv:get_stack("input", 2):get_name() == v.recipe[1] then
				return true, i, time, v.func
			end
		end
	end
	return false
end

local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

local function dfurnace_node_timer(pos, elapsed)
	--
	-- Inizialize metadata
	--
	local meta = minetest.get_meta(pos)
	local fuel_time = meta:get_float("fuel_time") or 0
	local src_time = meta:get_float("src_time") or 0
	local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

	local inv = meta:get_inventory()
	local input = inv:get_list("input")
	local fuel = inv:get_list("fuel")

	--
	-- Cooking
	--

	-- Check if we have cookable content
	local cookable, output, time, func = check_craft(pos, "output")
	-- Check if we have enough fuel to burn
	if fuel_time < fuel_totaltime then
		-- The furnace is currently active and has enough fuel
		fuel_time = fuel_time + 1

		-- If there is a cookable item then check if it is ready yet
		if cookable == true then
			output = output:gsub("_", ":", 1)
			src_time = src_time + 1
			if src_time >= time then
				if not func then
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
					src_time = func(pos, output, src_time)
				end
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
		swap_node(pos, "lottblocks:dual_furnace_active")
		result = true
		local percent = math.floor(fuel_time / fuel_totaltime * 100)
		new_formspec = new_formspec ..
			"image[2,2;1,1;default_furnace_fire_bg.png^[lowpart:"..
			(100-percent)..":default_furnace_fire_fg.png]"..
			"image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
			(item_percent)..":gui_furnace_arrow_fg.png^[transformR270]"
	else
		swap_node(pos, "lottblocks:dual_furnace_inactive")
		local timer = minetest.get_node_timer(pos)
		timer:stop()
	end

	meta:set_float("fuel_totaltime", fuel_totaltime)
	meta:set_float("fuel_time", fuel_time)
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", new_formspec)

	return result
end

---
--- Define the active & inactive nodes!
---

for _, nn in pairs({"active", "inactive"}) do
	local groups = {cracky=2}
	if nn == "active" then
		groups.not_in_creative_inventory = 1
	end
	minetest.register_node("lottblocks:dual_furnace_" .. nn, {
		description = "Dual Furnace",
		tiles = {
			"default_furnace_top.png",
			"default_furnace_bottom.png",
			"default_furnace_side.png",
			"default_furnace_side.png",
			"default_furnace_side.png",
			"lottblocks_dual_furnace_front_" .. nn .. ".png"
		},
		paramtype2 = "facedir",
		groups = groups,
		is_ground_content = false,
		paramtype = "light",
		drop = "lottblocks:dual_furnace_inactive",
		can_dig = function(pos)
			return can_dig(pos, "input", "output", "fuel")
		end,

		on_timer = dfurnace_node_timer,

		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("input", 2)
			inv:set_size("output", 2)
			inv:set_size("fuel", 1)
			meta:set_string("infotext", "Dual Furnace")
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
				else
					return 0
				end
			elseif listname == "output" then
				return 0
			else
				return stack:get_count()
			end
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if to_list == "fuel" then
				if minetest.get_craft_result({method="fuel", width=1,
					items={inv:get_stack(from_list, from_index)}}).time ~= 0 then
					return count
				else
					return 0
				end
			else
				return count
			end
		end,
	})
end

minetest.register_craft({
	output = "lottblocks:dual_furnace_inactive",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "default:furnace", "default:steel_ingot"}
	}
})

lottblocks.crafting.add_craft("default:bronze_ingot", {
	recipe = {"lottores:tin_ingot", "default:copper_ingot"},
	type = "dualfurn"
})

lottblocks.crafting.add_craft("default:steel_ingot", {
	recipe = {"lottores:orc_steel_ingot", "lottores:orc_steel_ingot"},
	type = "dualfurn",
	time = 5,
})

lottblocks.crafting.add_craft("default:steel_ingot", {
	recipe = {"lottores:orc_lump", "lottores:orc_lump"},
	type = "dualfurn",
	time = 5,
})

lottblocks.crafting.add_craft("lottores:galvorn_ingot", {
	recipe = {"lottores:lead_ingot", "default:mese_crystal"},
	type = "dualfurn",
	time = 60,
})

lottblocks.crafting.add_craft("lottores:ithildin_1", {
	recipe = {"lottores:mithril_ingot", "lottores:geodes_crystal_1"},
	type = "dualfurn",
	time = 5,
})

lottblocks.crafting.add_craft("lottores:ithildin_stone_1", {
	recipe = {"lottores:ithildin_1", "group:stone"},
	type = "dualfurn",
	time = 5,
})

lottblocks.crafting.add_craft("lottores:ithildin_lamp_1", {
	recipe = {"lottores:mithril_ingot", "lottblocks:elf_torch"},
	type = "dualfurn",
	time = 5,
})

lottblocks.crafting.add_craft("lottores:ithildin_stonelamp_1", {
	recipe = {"lottores:ithildin_lamp_1", "group:stone"},
	type = "dualfurn",
	time = 5,
})
