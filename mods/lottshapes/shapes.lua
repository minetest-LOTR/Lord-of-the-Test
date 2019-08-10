
-- Transparent shapes
local nodebox_list = {
	-- description, name, nodebox, sunlight_propagates
	{ "Mat", "mat", {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, 1, true},
	{ "Cube", "cube", {-0.5, -0.5, 0, 0, 0, 0.5}, 1, true},
	{ "Step", "step", {-0.5, -0.5, 0, 0.5, 0, 0.5}, 2, true},
	{ "Halfstair", "halfstair", {{-0.5, -0.5, -0.5, 0, 0, 0.5},{-0.5, 0, 0, 0, 0.5, 0.5},}, 3, true},
	{ "Slab", "slab", {-0.5, -0.5, -0.5, 0.5, 0, 0.5}, 4, true},
	{ "Outerstair", "outerstair", {{-0.5, -0.5, -0.5, 0.5, 0, 0.5},{-0.5, 0, 0, 0, 0.5, 0.5},}, 5, true},
	{ "Stair", "stair", {{-0.5, -0.5, -0.5, 0.5, 0, 0.5},{-0.5, 0, 0, 0.5, 0.5, 0.5},}, 6, true},
	{ "Innerstair", "innerstair", {{-0.5, -0.5, -0.5, 0.5, 0, 0.5},{-0.5, 0, 0, 0.5, 0.5, 0.5},{-0.5, 0, -0.5, 0, 0.5, 0},}, 7, false},
	{ "Pole", "pole", {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}, 1, true},
	{ "Pillar", "pillar", {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4}, 2, true},
}

-- Model-based shapes
local model_list = {
	{ "Sphere", "sphere", "shapes_sphere.obj", 4},
}

local is_disabled = function(disabled, name)
	local output = string.match(disabled, '(.*)'..name..'(.*)')
	if output ~= nil then
		return false
	elseif output == nil then
		return true
	end
end

--=== PANES FUCTIONALITY ===
-- Obtained from minetest-game/panes
-- [ https://github.com/minetest/minetest_game/tree/master/mods/xpanes ]
-- Credit to original authors

local function is_pane(pos)
	return minetest.get_item_group(minetest.get_node(pos).name, "pane") > 0
end

local function connects_dir(pos, name, dir)
	local aside = vector.add(pos, minetest.facedir_to_dir(dir))
	if is_pane(aside) then
		return true
	end

	local connects_to = minetest.registered_nodes[name].connects_to
	if not connects_to then
		return false
	end

	local list = minetest.find_nodes_in_area(aside, aside, connects_to)
	if #list > 0 then
		return true
	end

	return false
end

local function swap(pos, node, name, param2)
	if node.name == name and node.param2 == param2 then
		return
	end
	minetest.set_node(pos, {name = name, param2 = param2})
end

local function update_pane(pos)
	if not is_pane(pos) then
		return
	end

	local node = minetest.get_node(pos)
	local name = node.name
	if name:sub(-5) == "_flat" then
		name = name:sub(1, -6)
	end

	local any = node.param2
	local c = {}
	local count = 0
	for dir = 0, 3 do
		c[dir] = connects_dir(pos, name, dir)
		if c[dir] then
			any = dir
			count = count + 1
		end
	end

	if count == 0 then
		swap(pos, node, name .. "_flat", any)
	elseif count == 1 then
		swap(pos, node, name .. "_flat", (any + 1) % 4)
	elseif count == 2 then
		if (c[0] and c[2]) or (c[1] and c[3]) then
			swap(pos, node, name .. "_flat", (any + 1) % 4)
		else
			swap(pos, node, name, 0)
		end
	else
		swap(pos, node, name, 0)
	end
end

minetest.register_on_placenode(function(pos, node)
	if minetest.get_item_group(node, "pane") then
		update_pane(pos)
	end
	for i = 0, 3 do
		local dir = minetest.facedir_to_dir(i)
		update_pane(vector.add(pos, dir))
	end
end)

minetest.register_on_dignode(function(pos)
	for i = 0, 3 do
		local dir = minetest.facedir_to_dir(i)
		update_pane(vector.add(pos, dir))
	end
end)

lottshapes = {}
function lottshapes:register_shapes(name, def)
	def = def or {}
	local disabled = def.disabled or ""
	local sname = string.match(name, ':(.*)')
	local itemmeta = minetest.registered_items[name]
	local r_group = table.copy(itemmeta.groups)
	r_group.not_in_creative_inventory = 2
	local stexture = def.texture or string.match(minetest.serialize(itemmeta.tiles), '{"(.*)"}')

	-- Registering nodebox shapes
	for i in ipairs(nodebox_list) do
		local tdesc = nodebox_list[i][1]
		local tname = nodebox_list[i][2]
		local tnobo = nodebox_list[i][3]
		local tcraf = nodebox_list[i][4]
		local tsunl = nodebox_list[i][5]

		if itemmeta.sunlight_propagates == true then
			tsunl = true
		end

		if is_disabled(disabled, tname) then
			minetest.register_node(":lottshapes:"..sname.."_"..tname, {
				description = itemmeta.description.." "..tdesc,
				drawtype = "nodebox",
				groups = r_group,
				tiles = def[tname.."_tiles"] or itemmeta.tiles,
				paramtype = "light",
				paramtype2 = "facedir",
				sunlight_propagates = tsunl,
				drop = def.drop,
				light_source = itemmeta.light_source,
				sounds = itemmeta.sounds,
				node_box = {
					type = "fixed",
					fixed = tnobo,
				},
				on_place = minetest.rotate_node
			})

			minetest.register_craft({
				output = 'lottshapes:'..sname..'_cube '..tcraf,
				recipe = {{'lottshapes:'..sname..'_'..tname}}
			})
		end
	end

	-- Registering model-based shapes
	for i in ipairs(model_list) do
		local tdesc = model_list[i][1]
		local tname = model_list[i][2]
		local tmodl = model_list[i][3]
		local tcraf = model_list[i][4]

		if is_disabled(disabled, tname) then
			minetest.register_node(":lottshapes:"..sname.."_"..tname, {
				description = itemmeta.description.." "..tdesc,
				drawtype = "mesh",
				mesh = tmodl,
				groups = r_group,
				tiles = def[tname.."_tiles"] or itemmeta.tiles,
				paramtype = "light",
				paramtype2 = "facedir",
				sunlight_propagates = true,
				drop = def.drop,
				light_source = itemmeta.light_source,
				sounds = itemmeta.sounds,
				on_place = minetest.rotate_node
			})

			minetest.register_craft({
				output = 'lottshapes:'..sname..'_cube '..tcraf,
				recipe = {{'lottshapes:'..sname..'_'..tname}}
			})
		end
	end

	-- Registering fences
	if is_disabled(disabled, "fence") then
		local f_group = table.copy(itemmeta.groups)
		f_group.not_in_creative_inventory = 1
		f_group.fence = 1
		local fence_texture = "lottshapes_fence_overlay.png^" .. stexture .. "^lottshapes_fence_overlay.png^[makealpha:255,126,126"

		minetest.register_node(":lottshapes:"..sname.."_fence", {
			description = itemmeta.description.." Fence",
			drawtype = "nodebox",
			groups = f_group,
			tiles = def.fence_tiles or {stexture},
			inventory_image = fence_texture,
			wield_image = fence_texture,
			paramtype = "light",
			sunlight_propagates = true,
			drop = def.drop,
			light_source = itemmeta.light_source,
			sounds = itemmeta.sounds,
			node_box = {
				type = "connected",
				fixed = {{-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}},
				-- connect_top =
				-- connect_bottom =
				connect_front = {{-1/16,3/16,-1/2,1/16,5/16,-1/8},
					{-1/16,-5/16,-1/2,1/16,-3/16,-1/8}},
				connect_left = {{-1/2,3/16,-1/16,-1/8,5/16,1/16},
					{-1/2,-5/16,-1/16,-1/8,-3/16,1/16}},
				connect_back = {{-1/16,3/16,1/8,1/16,5/16,1/2},
					{-1/16,-5/16,1/8,1/16,-3/16,1/2}},
				connect_right = {{1/8,3/16,-1/16,1/2,5/16,1/16},
					{1/8,-5/16,-1/16,1/2,-3/16,1/16}},
			},
			connects_to = {"group:fence", "group:wood", "group:tree"},
		})

		minetest.register_craft({
			output = 'lottshapes:'..sname..'_cube',
			recipe = {{'lottshapes:'..sname..'_fence'}}
		})
	end

	-- Registering walls
	if is_disabled(disabled, "wall") then
		local w_group = table.copy(itemmeta.groups)
		w_group.not_in_creative_inventory = 1
		w_group.wall = 1
		local wall_texture = "lottshapes_wall_overlay.png^" .. stexture .. "^lottshapes_wall_overlay.png^[makealpha:255,126,126"

		minetest.register_node(":lottshapes:"..sname.."_wall", {
			description = itemmeta.description.." Wall",
			drawtype = "nodebox",
			groups = w_group,
			tiles = def.wall_tiles or {stexture},
			inventory_image = wall_texture,
			wield_image = wall_texture,
			paramtype = "light",
			sunlight_propagates = true,
			drop = def.drop,
			light_source = itemmeta.light_source,
			sounds = itemmeta.sounds,
			node_box = {
				type = "connected",
				fixed = {{-1/4, -1/2, -1/4, 1/4, 1/2, 1/4}},
				-- connect_bottom =
				connect_front = {{-3/16, -1/2, -1/2,  3/16, 3/8, -1/4}},
				connect_left = {{-1/2, -1/2, -3/16, -1/4, 3/8,  3/16}},
				connect_back = {{-3/16, -1/2,  1/4,  3/16, 3/8,  1/2}},
				connect_right = {{ 1/4, -1/2, -3/16,  1/2, 3/8,  3/16}},
			},
			connects_to = {"group:wall", "group:stone"},
		})

		minetest.register_craft({
			output = 'lottshapes:'..sname..'_cube 2',
			recipe = {{'lottshapes:'..sname..'_wall'}}
		})
	end

	-- Registering panes
	if is_disabled(disabled, "pane") then
		local p_group = table.copy(itemmeta.groups)
		p_group.not_in_creative_inventory = 1
		p_group.pane = 1

		minetest.register_node(":lottshapes:"..sname.."_pane_flat", {
			description = itemmeta.description.." Pane" or "Pane",
			drawtype = "nodebox",
			groups = p_group,
			tiles = def.pane_flat_tiles or def.pane_tiles or {stexture},
			inventory_image = stexture,
			wield_image = stexture,
			paramtype = "light",
			paramtype2 = "facedir",
			sunlight_propagates = true,
			drop = def.drop,
			light_source = itemmeta.light_source,
			sounds = itemmeta.sounds,
			node_box = {
				type = "fixed",
				fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
			},
			connect_sides = { "left", "right" },
		})

		minetest.register_node(":lottshapes:"..sname.."_pane", {
			description = itemmeta.description.. " Pane" or "Pane",
			drawtype = "nodebox",
			groups = r_group,
			tiles = def.pane_tiles or {stexture},
			paramtype = "light",
			sunlight_propagates = true,
			drop = "lottshapes:"..sname.."_pane_flat",
			light_source = itemmeta.light_source,
			sounds = itemmeta.sounds,
			node_box = {
				type = "connected",
				fixed = {{-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}},
				connect_front = {{-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}},
				connect_left = {{-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}},
				connect_back = {{-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}},
				connect_right = {{1/32, -1/2, -1/32, 1/2, 1/2, 1/32}},
			},
			connects_to = {"group:pane", "group:stone", "group:glass", "group:wood", "group:tree"},
		})

		minetest.register_craft({
			output = 'lottshapes:'..sname..'_cube',
			recipe = {{'lottshapes:'..sname..'_pane_flat'}}
		})
	end
end
