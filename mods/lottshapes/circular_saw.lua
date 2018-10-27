--[[
== Modified From ==
More Blocks: circular saw
[ https://github.com/minetest-mods/moreblocks ]

Copyright (c) 2011-2017 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

circular_saw = {}

local circular_saw_formspec =
	lottplayer.inv_size("4x6")..
		
	"list[detached:creative_trash;main;-0.2,-0.15;1,1;]" ..
	"image[-0.13,-0.05;0.8,0.8;icon_trash.png]" ..
	
	"list[current_name;input;0.8,-0.15;1,1;]" ..
	"image[0.87,-0.05;0.8,0.8;icon_input.png]" ..
	"image[0.87,0.95;0.8,0.8;icon_arrow.png^[transformFY]" ..
			
	"list[current_name;micro;1.8,-0.15;1,1;]" ..
	"image[1.87,-0.05;0.8,0.8;icon_cube.png]" ..
	"image[1.87,0.95;0.8,0.8;icon_arrow.png^[transformFY]" ..
		
	"field[3.1,0.4;1,1;max_offered;" .."Max".. ":;${max_offered}]" ..
	"button[2.8,0.85;1,1;Set;" .."Set".. "]" ..
			
	"list[current_name;output;-0.2,1.85;4,4;]"
	


-- How many microblocks does this shape at the output inventory cost:
-- It may cause slight loss, but no gain.
circular_saw.cost_in_microblocks = {
	--mat, cube, step, halfstair,
	1, 1, 2, 3,
	--slab, outerstair, stair, innerstair
	4, 5, 6, 7,
	--fence, pole, wall, pillar
	1, 1, 2, 2,
	--sphere, pane, full
	1, 8
}

circular_saw.names = {

	{"mat", ""},
	{"cube", ""},
	{"step", ""},
	{"halfstair", ""},
	
	{"slab", ""},
	{"outerstair", ""},
	{"stair", ""},
	{"innerstair", ""},
	
	{"fence", ""},
	{"pole", ""},
	{"wall", ""},
	{"pillar", ""},
	
	{"pane_flat", ""},
	{"full", ""},
}

function circular_saw:get_cost(inv, stackname)
	for i, item in pairs(inv:get_list("output")) do
		if item:get_name() == stackname then
			return circular_saw.cost_in_microblocks[i]
		end
	end
end

function circular_saw:get_output_inv(modname, material, amount, max)
	if (not max or max < 1 or max > 99) then max = 99 end

	local list = {}
	local pos = #list

	-- If there is nothing inside, display empty inventory:
	if amount < 1 then
		return list
	end

	for i = 1, #circular_saw.names do
		local t = circular_saw.names[i]
		local cost = circular_saw.cost_in_microblocks[i]
		local balance = math.min(math.floor(amount/cost), max)
		local nodename = ""
		if t[1] == "full" then
			local node_name = node_name:gsub("lottshapes:", "", 1)
			local node_name = node_name:gsub("_cube", "", 1)
			nodename = node_name
		else
			nodename = modname..":"..material.."_"..t[1]
		end
		
		if  minetest.registered_nodes[nodename] then
			pos = pos + 1
			list[pos] = nodename .. " " .. balance
		else
			pos = pos + 1
			list[pos] = ""
		end
	end
	return list
end


-- Reset empty circular_saw after last full block has been taken out
-- (or the circular_saw has been placed the first time)
-- Note: max_offered is not reset:
function circular_saw:reset(pos)
	local meta = minetest.get_meta(pos)
	local inv  = meta:get_inventory()

	inv:set_list("input",  {})
	inv:set_list("micro",  {})
	inv:set_list("output", {})
	meta:set_int("anz", 0)

	meta:set_string("infotext",
			("Circular Saw is empty (owned by %s)")
			:format(meta:get_string("owner") or ""))
end


-- Player has taken something out of the box or placed something inside
-- that amounts to count microblocks:
function circular_saw:update_inventory(pos, amount)
	local meta          = minetest.get_meta(pos)
	local inv           = meta:get_inventory()

	amount = meta:get_int("anz") + amount

	-- The material is recycled automaticly.
	inv:set_list("recycle",  {})

	if amount < 1 then -- If the last block is taken out.
		self:reset(pos)
		return
	end

	local stack = inv:get_stack("input",  1)
	-- At least one "normal" block is necessary to see what kind of stairs are requested.
	if stack:is_empty() then
		-- Any microblocks not taken out yet are now lost.
		-- (covers material loss in the machine)
		local microstack = inv:get_stack("micro",  1)
		node_name = microstack:get_name() or ""
	
		local modname  = "lottshapes"
		--local material = node_name:match(":(.*)")
		local material = node_name:gsub("lottshapes:", "", 1)
		local material = material:gsub("_cube", "", 1)
		if not inv:get_stack("micro",  1):is_empty() then
		
		inv:set_list("micro", {
			modname..":"..material.."_cube " .. (amount)
		})
		
		inv:set_list("output",
			self:get_output_inv(modname, material, amount,
					meta:get_int("max_offered")))
					
		meta:set_int("anz", amount)

		meta:set_string("infotext",
				("Circular Saw is working on %s (owned by %s)")
				:format(material, meta:get_string("owner") or ""))
		end

	elseif not stack:is_empty() then
	
		node_name = stack:get_name() or ""
	
		local modname  = "lottshapes"
		local material = node_name:match(":(.*)")

		inv:set_list("input", { -- Display as many full blocks as possible:
			node_name.. " " .. math.floor(amount / 8)
		})

		-- 0-7 microblocks may remain left-over:
		inv:set_list("micro", {
			modname..":"..material.."_cube " .. (amount % 8)
		})
		-- Display:
		inv:set_list("output",
			self:get_output_inv(modname, material, amount,
					meta:get_int("max_offered")))
		-- Store how many microblocks are available:
		meta:set_int("anz", amount)

		meta:set_string("infotext",
				("Circular Saw is working on %s (owned by %s)")
				:format(material, meta:get_string("owner") or ""))
	else
		self:reset(pos)
		return
	end
end


-- The amount of items offered per shape can be configured:
function circular_saw.on_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local max = tonumber(fields.max_offered)
	if max and max > 0 then
		meta:set_string("max_offered",  max)
		-- Update to show the correct number of items:
		circular_saw:update_inventory(pos, 0)
	end
	
	lottplayer.inv_update(sender, fields)
	meta:set_string("formspec",
		circular_saw_formspec..
		lottplayer.inv(sender))
		
	if fields.quit then
		if minetest.settings:get_bool("creative_mode") then
			creative.update_formspec(sender, creative.page(sender))
		else lottplayer.inv_update_force(sender, lottplayer.inv_size("4x4")..lottplayer.inv_left(sender))
		end
	end
end

-- Moving the inventory of the circular_saw around is not allowed because it
-- is a fictional inventory. Moving inventory around would be rather
-- impractical and make things more difficult to calculate:
function circular_saw.allow_metadata_inventory_move(
		pos, from_list, from_index, to_list, to_index, count, player)
	return 0
end


-- Only input- and recycle-slot are intended as input slots:
function circular_saw.allow_metadata_inventory_put(
		pos, listname, index, stack, player)
	-- The player is not allowed to put something in there:
	if listname == "output" then
		return 0
	end

	local meta = minetest.get_meta(pos)
	local inv  = meta:get_inventory()
	local stackname = stack:get_name()
	local materialname = stackname:match(":(.*)")
	local count = stack:get_count()

	-- Only alow those items that are offered in the output inventory to be recycled:
	if listname == "recycle" then
		if not inv:contains_item("output", stackname) then
			return 0
		end
		local stackmax = stack:get_stack_max()
		local instack = inv:get_stack("input", 1)
		local microstack = inv:get_stack("micro", 1)
		local incount = instack:get_count()
		local incost = (incount * 8) + microstack:get_count()
		local maxcost = (stackmax * 8) + 7
		local cost = circular_saw:get_cost(inv, stackname)
		if (incost + cost) > maxcost then
			return math.max((maxcost - incost) / cost, 0)
		end
		return count
	end
	
	-- Only accept certain blocks as input which are known to be craftable into stairs:
	if listname == "input" and minetest.registered_nodes["lottshapes:"..materialname.."_cube"] then
		if inv:get_stack("input", index):get_count() >= inv:get_stack("input", index):get_stack_max() then
			return 0
		end
		
		if not inv:is_empty("input") then
			if inv:get_stack("input", index):get_name() ~= stackname then
				return 0
			end
		end
		if not inv:is_empty("micro") then
			local microstackname = inv:get_stack("micro", 1):get_name():gsub("lottshapes:", "", 1)
			local microstackname = microstackname:gsub("_cube", "", 1)
			local cutstackname = stackname:match(":(.*)")
			if microstackname == cutstackname then
				return count
			else
				return 0
			end
		end
		return count
	end
	
	if listname == "micro" and materialname:match("[A-Za-z0-9%.%%%+%-]+_cube") and stackname:match("lottshapes:"..materialname) then
		if inv:get_stack("micro", index):get_count() >= inv:get_stack("micro", index):get_stack_max() then
			return 0
		end
	
		if not inv:is_empty("micro") then
			if inv:get_stack("micro", index):get_name() ~= stackname then
				return 0
			end
		end
		if not inv:is_empty("input") then
			local inputstackname = inv:get_stack("input", 1):get_name():match(":(.*)")
			local cutstackname = stackname:gsub("_cube", "", 1)
			local cutstackname = cutstackname:gsub("lottshapes:", "", 1)
			if inputstackname == cutstackname then
				return count
			else
				return 0
			end
		end
		return count
	end
	return 0
end

-- Taking is allowed from all slots (even the internal microblock slot).
-- Putting something in is slightly more complicated than taking anything
-- because we have to make sure it is of a suitable material:
function circular_saw.on_metadata_inventory_put(
		pos, listname, index, stack, player)
	-- We need to find out if the circular_saw is already set to a
	-- specific material or not:
	local meta = minetest.get_meta(pos)
	local inv  = meta:get_inventory()
	local stackname = stack:get_name()
	local count = stack:get_count()

	-- Putting something into the input slot is only possible if that had
	-- been empty before or did contain something of the same material:
	if listname == "input" then
		-- Each new block is worth 8 microblocks:
		circular_saw:update_inventory(pos, 8 * count)
	elseif listname == "micro" then
		circular_saw:update_inventory(pos, count)
	elseif listname == "recycle" then
		-- Lets look which shape this represents:
		local cost = circular_saw:get_cost(inv, stackname)
		local input_stack = inv:get_stack("input", 1)
		-- check if this would not exceed input itemstack max_stacks
		if input_stack:get_count() + ((cost * count) / 8) <= input_stack:get_stack_max() then
			circular_saw:update_inventory(pos, cost * count)
		end
	end
end

function circular_saw.allow_metadata_inventory_take(pos, listname, index, stack, player)
	local meta          = minetest.get_meta(pos)
	local inv           = meta:get_inventory()
	local input_stack 	= inv:get_stack(listname,  index)
	local player_inv 	= player:get_inventory()
	if not player_inv:room_for_item("main", input_stack) then
		return 0
	else return stack:get_count()
	end
end

function circular_saw.on_metadata_inventory_take(
		pos, listname, index, stack, player)

	-- Prevent (inbuilt) swapping between inventories with different blocks
	-- corrupting player inventory or Saw with 'unknown' items.
	local meta			= minetest.get_meta(pos)
	local inv			= meta:get_inventory()
	local input_stack	= inv:get_stack(listname,  index)
	
	if not input_stack:is_empty() and input_stack:get_name()~= stack:get_name() then
		local player_inv = player:get_inventory()
		if player_inv:room_for_item("main", input_stack) then
			player_inv:add_item("main", input_stack)
		end

		circular_saw:reset(pos)
		return
	end

	-- If it is one of the offered stairs: find out how many
	-- microblocks have to be substracted:
	if listname == "output" then
		-- We do know how much each block at each position costs:
		local cost = circular_saw.cost_in_microblocks[index]
				* stack:get_count()

		circular_saw:update_inventory(pos, -cost)
	elseif listname == "micro" then
		-- Each microblock costs 1 microblock:
		circular_saw:update_inventory(pos, -stack:get_count())
	elseif listname == "input" then
		-- Each normal (= full) block taken costs 8 microblocks:
		circular_saw:update_inventory(pos, 8 * -stack:get_count())
	end
	-- The recycle field plays no role here since it is processed immediately.
end

function circular_saw.on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec",
		circular_saw_formspec)
	
	meta:set_int("anz", 0) -- No microblocks inside yet.
	meta:set_string("max_offered", 99) -- How many items of this kind are offered by default?
	meta:set_string("infotext", "Circular Saw is empty")

	local inv = meta:get_inventory()
	inv:set_size("input", 1)    -- Input slot for full blocks of material x.
	inv:set_size("micro", 1)    -- Storage for 1-7 surplus microblocks.
	inv:set_size("recycle", 1)  -- Surplus partial blocks can be placed here.
	inv:set_size("output", 4*4) -- 4x4 versions of stair-parts of material x.

	circular_saw:reset(pos)
end

function circular_saw.on_rightclick(pos, node, clicker, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec",
		circular_saw_formspec..
		lottplayer.inv(clicker))
end

minetest.register_node("lottshapes:circular_saw",  {
	description = "Circular Saw",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.4, -0.25, 0.375, -0.25}, -- NodeBox1
			{0.25, -0.5, 0.25, 0.4, 0.375, 0.4}, -- NodeBox2
			{-0.4, -0.5, 0.25, -0.25, 0.375, 0.4}, -- NodeBox3
			{0.25, -0.5, -0.4, 0.4, 0.375, -0.25}, -- NodeBox4
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox5
			{-0.25, 0.0625, -0.25, 0.25, 0.375, 0.25}, -- NodeBox6

			{-0.01, 0.5, -0.125, 0.01, 0.6125, 0.125}, -- Saw blade (top)
			{-0.01, 0.5, -0.1875, 0.01, 0.5625, 0.1875}, -- Saw blade (bottom)
		},
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }
	},
	tiles = {"circular_saw_top.png",
		"circular_saw_bottom.png",
		"circular_saw_side.png"},
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	groups = {axe = 2, hand = 3},
	on_construct = circular_saw.on_construct,
	after_place_node = function(pos, placer)
		-- Set the owner of this circular saw.
		local meta = minetest.get_meta(pos)
		local owner = placer and placer:get_player_name() or ""
		meta:set_string("owner",  owner)
		meta:set_string("infotext",
				("Circular Saw is empty (owned by %s)")
				:format(owner))
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if not inv:is_empty("input") or
			not inv:is_empty("micro") or
			not inv:is_empty("recycle") then
			return false
		end
		if player:get_player_name() ~= meta:get_string("owner") then
			return true
		end
	return true
	end,
	-- The amount of items offered per shape can be configured:
	on_receive_fields = circular_saw.on_receive_fields,
	on_rightclick = circular_saw.on_rightclick,
	allow_metadata_inventory_move = circular_saw.allow_metadata_inventory_move,
	-- Only input- and recycle-slot are intended as input slots:
	allow_metadata_inventory_put = circular_saw.allow_metadata_inventory_put,
	allow_metadata_inventory_take = circular_saw.allow_metadata_inventory_take,
	-- Taking is allowed from all slots (even the internal microblock slot). Moving is forbidden.
	-- Putting something in is slightly more complicated than taking anything because we have to make sure it is of a suitable material:
	on_metadata_inventory_put = circular_saw.on_metadata_inventory_put,
	on_metadata_inventory_take = circular_saw.on_metadata_inventory_take,
})