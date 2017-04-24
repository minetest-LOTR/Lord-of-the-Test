-- The basic ingredients of ringsilver

minetest.register_craftitem("lottother:pure_silver", {
	description = "Pure Silver",
	inventory_image = "lottother_pure_silver.png",
    groups = {forbidden=1},
})

minetest.register_craftitem("lottother:pure_gold", {
	description = "Pure Gold",
	inventory_image = "lottother_pure_gold.png",
    groups = {forbidden=1},
})

minetest.register_craftitem("lottother:goldsilver", {
	description = "Goldsilver",
	inventory_image = "lottother_goldsilver.png",
    groups = {forbidden=1},
})

-- Crafts

minetest.register_craft({
	type = "cooking",
	output = "lottother:pure_silver",
	recipe = "lottores:silver_ingot",
	cooktime = 15,
})

minetest.register_craft({
	type = "cooking",
	output = "lottother:pure_gold",
	recipe = "default:gold_ingot",
	cooktime = 15,
})

lottblocks.crafting.add_craft("lottother:goldsilver", {
	recipe = {"lottother:pure_silver", "lottother:pure_gold"},
	type = "dualfurn",
	time = 30,
})

-- Cooling the hot ringsilver in water.
-- Very fancy!!!

-- We have to copy minetest.item_drop in order to get it to return the entity...
local function item_drop(itemstack, dropper, pos)
	if dropper and dropper:is_player() then
		local v = dropper:get_look_dir()
		local p = {x=pos.x, y=pos.y+1.2, z=pos.z}
		local cs = itemstack:get_count()
		local inv = dropper:get_inventory()
		local ind = dropper:get_wield_index()
		if dropper:get_player_control().sneak then
			cs = 1
		end
		local item = itemstack:take_item(cs)
		local obj = minetest.add_item(p, item)
		if obj then
			v.x = v.x*2
			v.y = v.y*2 + 2
			v.z = v.z*2
			obj:setvelocity(v)
			obj:get_luaentity().dropped_by = dropper:get_player_name()
			inv:set_stack("main", ind, "")
			return obj
		end
	else
		if minetest.add_item(pos, itemstack) then
			return itemstack
		end
	end
end

minetest.register_craftitem("lottother:hot_ringsilver", {
	description = "Hot Ringsilver",
	inventory_image = "lottother_hot_ringsilver.png",
    groups = {forbidden=1},
	stack_max = 1,
	on_drop = function(itemstack, dropper, pos)
		local metadata = itemstack:get_metadata()
		local ent = item_drop(itemstack, dropper, pos)
		minetest.after(3, function()
			if ent ~= nil and metadata ~= nil then
				local pos = ent:getpos()
				if pos ~= nil then
					local node = minetest.get_node(pos).name
					ent:remove()
					if node == "default:water_source" and os.time() - tonumber(metadata) <= 13 then
						minetest.add_item(pos, "lottother:ringsilver")
					end
					if dropper and dropper:get_player_name() then
						lottachievements.unlock(dropper:get_player_name(), "ringsilver_crafter")
					end
				end
			end
		end)
	end,
})

minetest.register_craftitem("lottother:ringsilver", {
	description = "Ringsilver",
	inventory_image = "lottother_ringsilver_ingot.png",
    groups = {forbidden=1},
})

-------------------------------------------------
-----          Ringsilver furnace           -----
-----          (Very hard-coded!)           -----
-----  (But as it serves not other purpose, -----
-----  it makes no sense for it not to be!) -----
-------------------------------------------------

local formspec = "size[8,8]"..
	"background[-0.5,-0.65;9,9.35;gui_elfbg.png]"..
	"list[current_player;main;0,3.75;8,1;]"..
	"list[current_player;main;0,5;8,3;8]"..
	"list[context;goldsilver;2,0.5;1,1;]"..
	"label[0.45,0.5;Goldsilver]"..
	"list[context;mithril;5,0.5;1,1;]"..
	"label[6,0.5;Mithril]"..
	"list[context;roughrock;2,2;1,1;]"..
	"label[0.18,2;Rough Rock]"..
	"list[context;fuel;5,2;1,1;]"..
	"label[6,2;Fuel]"..
	"image[3.5,0.5;1,1;gui_furnace_arrow_bg.png]"..
	"image[3.5,1.5;1,1;default_furnace_fire_bg.png]"

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("goldsilver") and inv:is_empty("mithril")
		and inv:is_empty("roughrock") and inv:is_empty("fuel")
end

local function is_cookable(inv)
	if inv:contains_item("mithril", "lottores:mithril_ingot")
	and inv:contains_item("goldsilver", "lottother:goldsilver")
	and inv:contains_item("roughrock", "lottores:rough_rock_lump") then
		return true
	end
	return false
end

local function take_items(inv)
	local c = inv:get_stack("mithril", 1):get_count() - 1
	inv:set_stack("mithril", 1, "lottores:mithril_ingot " .. c)
	c = inv:get_stack("goldsilver", 1):get_count() - 1
	inv:set_stack("goldsilver", 1, "lottother:goldsilver " .. c)
	c = inv:get_stack("roughrock", 1):get_count() - 1
	inv:set_stack("roughrock", 1, "lottores:rough_rock_lump " .. c)
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
	local time = 20

	local inv = meta:get_inventory()
	local fuel = inv:get_list("fuel")
	local cookable = is_cookable(inv)

	-- Check if we have enough fuel to burn
	if fuel_time < fuel_totaltime then
		-- The furnace is currently active and has enough fuel
		fuel_time = fuel_time + 1

		-- If there is a cookable item then check if it is ready yet
		if cookable then
			src_time = src_time + 1
			if src_time >= time then
				local x = tostring(os.time())
				local item = minetest.add_item({x=pos.x, y=pos.y+1, z=pos.z},
					{name = "lottother:hot_ringsilver", metadata = x})
				item:setvelocity({x=0, y=10, z=0})
				minetest.add_particlespawner({
					amount = 30,
					time = 1,
					minpos = {x=pos.x, y=pos.y+1, z=pos.z},
					maxpos = {x=pos.x, y=pos.y+1, z=pos.z},
					minvel = {x=-2, y=3, z=-2},
					maxvel = {x=2, y=6, z=2},
					minacc = {x=-1, y=2, z=-1},
					maxacc = {x=1, y=4, z=1},
					minexptime = 1,
					maxexptime = 2,
					minsize = 1,
					maxsize = 2,
					texture = "fire_basic_flame.png",
				})
				src_time = 0
				take_items(inv)
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
		swap_node(pos, "lottother:ringsilver_furnace_active")
		result = true
		local fuel_percent = math.floor(fuel_time / fuel_totaltime * 100)
		new_formspec = new_formspec ..
			"image[3.5,0.5;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
			(item_percent)..":gui_furnace_arrow_fg.png]"..
			"image[3.5,1.5;1,1;default_furnace_fire_bg.png^[lowpart:"..
			(100-fuel_percent)..":default_furnace_fire_fg.png]"
	else
		swap_node(pos, "lottother:ringsilver_furnace_inactive")
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
	local groups = {forbidden=1, cracky=2}
	if status == "active" then
		groups.not_in_creative_inventory = 1
	end
	minetest.register_node("lottother:ringsilver_furnace_" .. status, {
		description = "Ringsilver Furnace",
		tiles = {
			"lottother_ringsilver_furnace_side.png",
			"lottother_ringsilver_furnace_side.png",
			"lottother_ringsilver_furnace_side.png",
			"lottother_ringsilver_furnace_side.png",
			"lottother_ringsilver_furnace_side.png",
			"lottother_ringsilver_furnace_front_" .. status .. ".png"
		},
		paramtype2 = "facedir",
		groups = groups,
		drop = "lottother:ringsilver_furnace_inactive",
		legacy_facedir_simple = true,
		is_ground_content = false,
		can_dig = can_dig,

		on_timer = furnace_node_timer,

		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("goldsilver", 1)
			inv:set_size("mithril", 1)
			inv:set_size("roughrock", 1)
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
				else
					return 0
				end
			elseif listname == "mithril" then
				if stack:get_name() == "lottores:mithril_ingot" then
					return stack:get_count()
				end
			elseif listname == "goldsilver" then
				if stack:get_name() == "lottother:goldsilver" then
					return stack:get_count()
				end
			elseif listname == "roughrock" then
				if stack:get_name() == "lottores:rough_rock_lump" then
					return stack:get_count()
				end
			end
			return 0
		end,
		allow_metadata_inventory_move = function()
			return 0
		end,
	})
end

minetest.register_craft({
	output = "lottother:ringsilver_furnace_inactive",
	recipe = {
		{"default:obsidian", "default:obsidian", "default:obsidian"},
		{"default:obsidian", "default:furnace", "default:obsidian"},
		{"default:obsidian", "default:obsidian", "default:obsidian"},
	},
})
