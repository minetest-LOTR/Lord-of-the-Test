
-- Shapes API
-- Credits for original shapes/nodeboxes goes to their respective authors as stated below
--
-- lottstairs:register_shapes("<name>", {
-- 		description = "<description>",
--		tiles = {"<textures>"},
-- 		texture = "<texture>" --> single texture only for fences/walls/spheres/posts
--		groups = {}
--		light_source = <light_source>
--		drop = <drop>
--		sounds = <sound>
--		connects_to = "<nodename>", "<nodename>" --> for fences and wall connections
--
-- List of nodes;
-- =============================================
-- mat, cube, step, halfstair, slab, innerstair, stair, outerstair, sphere
-- fence, fencepole, wall, wallpole, pane
--
-- ena_<name> = false ; to disable a certain shape, else all shapes are enabled by default
-- <name>_tiles = {<textures>} ; specialized textures -- not applicable for fence/wall/pane
--
--=== PANES FUCTIONALITY ===
-- Obtained from minetest-game/panes, credit to original authors
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

-- === REGISTER BLOCKS ===
-- Nodebox obtained from minetest-game/walls;panes;stairs & moreblocks/stairplus, credit to original authors

function lottstairs.register_shapes(name, def)
	
	-- Prevent nodes from cluttering creative inventories
	local flatgroups = table.copy(def.groups)
	--flatgroups.hidden = 1
	
	local shape_types = {
		-- name, description, sunlight_propagates (boolean), cost, mesh or nodebox, mesh model or nodebox model
		
		{	"mat",
			"Mat",
			false, "1",
			"nodebox",
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
		},
		
		{	"cube",
			"Cube",
			true, "1",
			"nodebox",
			{-0.5, -0.5, 0, 0, 0, 0.5}},
		
		{	"step",
			"Step",
			true, "2",
			"nodebox",
			{-0.5, -0.5, 0, 0.5, 0, 0.5}},
		
		{	"halfstair",
			"Half Stairs",
			true, "3",
			"nodebox",
			{	{-0.5, -0.5, -0.5, 0, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			}},
		
		{	"slab",
			"Slab",
			false, "4",
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5}},
		
		{	"outerstair",
			"Outer-Stairs",
			false, "5",
			"nodebox",
			{	{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			}},
		
		{	"stair",
			"Stairs",
			false, "6",
			"nodebox",
			{	{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			}},
		
		{	"innerstair",
			"Inner-Stairs",
			false, "7",
			"nodebox",
			{	{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			}},
		
		{	"sphere",
			"Sphere",
			true, "8",
			"mesh",
			"shapes_sphere.obj"},
	}
	
	for i in ipairs(shape_types) do
		local s_name = shape_types[i][1]
		local s_desc = shape_types[i][2]
		local s_sunl = shape_types[i][3]
		local s_cost = shape_types[i][4]
		local s_drawt = shape_types[i][5]
		local s_model = shape_types[i][6]
	end
	
	-- MAT
	if def.ena_mat ~= false then
		minetest.register_node(":lottstairs:"..name.."_mat", {
			description = def.description.." Mat" or "Mat",
			drawtype = "nodebox",
			groups = flatgroups,
			tiles = def.mat_tiles or def.tiles,
			paramtype = "light",
			paramtype2 = def.paramtype2 or "facedir",
			sunlight_propagates = def.sunlight_propagates or false,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
			},
			
			on_place = minetest.rotate_node
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube',
			recipe = {
				{'lottstairs:'..name..'_mat'},
			}
		})
	end
	
		-- CUBE
		minetest.register_node(":lottstairs:"..name.."_cube", {
			description = def.description.." Cube" or "Cube",
			drawtype = "nodebox",
			groups = flatgroups,
			tiles = def.cube_tiles or def.tiles,
			paramtype = "light",
			paramtype2 = def.paramtype2 or "facedir",
			sunlight_propagates = true,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0, 0, 0.5},
			},
			
			on_place = minetest.rotate_node
		})

	if def.ena_stair ~= false then
		-- STEP
		minetest.register_node(":lottstairs:"..name.."_step", {
			description = def.description.." Step" or "Step",
			drawtype = "nodebox",
			groups = flatgroups,
			tiles = def.step_tiles or def.tiles,
			paramtype = "light",
			paramtype2 = def.paramtype2 or "facedir",
			sunlight_propagates = true,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
			},
			
			on_place = minetest.rotate_node
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube 2',
			recipe = {
				{'lottstairs:'..name..'_step'},
			}
		})


		-- HALF STAIR
		minetest.register_node(":lottstairs:"..name.."_halfstair", {
			description = def.description.." Half Stairs" or "Half Stairs",
			drawtype = "nodebox",
			groups = flatgroups,
			tiles = def.halfstair_tiles or def.tiles,
			paramtype = "light",
			paramtype2 = def.paramtype2 or "facedir",
			sunlight_propagates = true,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0, 0, 0.5},
					{-0.5, 0, 0, 0, 0.5, 0.5},
				},
			},
			
			on_place = minetest.rotate_node
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube 3',
			recipe = {
				{'lottstairs:'..name..'_halfstair'},
			}
		})
		
	end
	if def.ena_slab ~= false then
		-- SLAB
		minetest.register_node(":lottstairs:"..name.."_slab", {
			description = def.description.." Slab" or "Slab",
			drawtype = "nodebox",
			groups = flatgroups,
			tiles = def.slab_tiles or def.tiles,
			paramtype = "light",
			paramtype2 = def.paramtype2 or "facedir",
			sunlight_propagates = def.sunlight_propagates or false,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			},
			
			on_place = minetest.rotate_node
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube 4',
			recipe = {
				{'lottstairs:'..name..'_slab'},
			}
		})
		
	end
	if def.ena_stair ~= false then
		-- OUTERSTAR
		minetest.register_node(":lottstairs:"..name.."_outerstair", {
			description = def.description.." Outer-Stairs" or "Outer-Stairs",
			drawtype = "nodebox",
			groups = flatgroups,
			tiles = def.outerstair_tiles or def.stair_tiles or def.tiles,
			paramtype = "light",
			paramtype2 = def.paramtype2 or "facedir",
			sunlight_propagates = def.sunlight_propagates or false,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
					{-0.5, 0, 0, 0, 0.5, 0.5},
				},
			},
			
			on_place = minetest.rotate_node
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube 5',
			recipe = {
				{'lottstairs:'..name..'_outerstair'},
			}
		})


		-- STAIR
		minetest.register_node(":lottstairs:"..name.."_stair", {
			description = def.description.." Stairs" or "Stairs",
			drawtype = "nodebox",
			groups = flatgroups,
			tiles = def.stair_tiles or def.tiles,
			paramtype = "light",
			paramtype2 = def.paramtype2 or "facedir",
			sunlight_propagates = def.sunlight_propagates or false,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
					{-0.5, 0, 0, 0.5, 0.5, 0.5},
				},
			},
			
			on_place = minetest.rotate_node
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube 6',
			recipe = {
				{'lottstairs:'..name..'_stair'},
			}
		})

		-- INNERSTAIR
		minetest.register_node(":lottstairs:"..name.."_innerstair", {
			description = def.description.." Inner-Stairs" or "Inner-Stairs",
			drawtype = "nodebox",
			groups = flatgroups,
			tiles = def.innerstair_tiles or def.tiles,
			paramtype = "light",
			paramtype2 = def.paramtype2 or "facedir",
			sunlight_propagates = def.sunlight_propagates or false,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
					{-0.5, 0, 0, 0.5, 0.5, 0.5},
					{-0.5, 0, -0.5, 0, 0.5, 0},
				},
			},
			
			on_place = minetest.rotate_node
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube 7',
			recipe = {
				{'lottstairs:'..name..'_innerstair'},
			}
		})
		
	end
	if def.ena_sphere ~= false then
		-- SPHERE
		minetest.register_node(":lottstairs:"..name.."_sphere", {
			description = def.description.." Sphere" or "Sphere",
			drawtype = "mesh",
			mesh = "shapes_sphere.obj",
			groups = flatgroups,
			tiles = {def.texture},
			paramtype = "light",
			paramtype2 = def.paramtype2 or "facedir",
			sunlight_propagates = true,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			
			on_place = minetest.rotate_node
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube 4',
			recipe = {
				{'lottstairs:'..name..'_sphere'},
			}
		})
	end
	
	-- === FENCE UNITS ===
	
	local fence_texture = "lottstairs_fence_overlay.png^" .. def.texture .. 
		"^lottstairs_fence_overlay.png^[makealpha:255,126,126"
	local flatgroups2 = table.copy(def.groups)
	flatgroups2.not_in_creative_inventory = 1
	flatgroups2.fence = 1
	if def.ena_fence ~= false then
		minetest.register_node(":lottstairs:"..name.."_fence", {
			description = def.description.." Fence" or "Fence",
			drawtype = "nodebox",
			groups = flatgroups2,
			tiles = {def.texture},
			inventory_image = fence_texture,
			wield_image = fence_texture,
			paramtype = "light",
			sunlight_propagates = true,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
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
			connects_to = {"group:fence", "group:wood", "group:tree", def.connects_to},
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube',
			recipe = {
				{'lottstairs:'..name..'_fence'},
			}
		})
	end
	
	if def.ena_pole ~= false then
		minetest.register_node(":lottstairs:"..name.."_fencepole", {
			description = def.description.." Fencepole" or "Fencepole",
			drawtype = "nodebox",
			groups = flatgroups,
			tiles = def.fence_tiles or {def.texture},
			paramtype = "light",
			paramtype2 = "facedir",
			sunlight_propagates = true,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "fixed",
				fixed = {{-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}},
			},
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube',
			recipe = {
				{'lottstairs:'..name..'_fencepole'},
			}
		})
	end
	
	local wall_texture = "lottstairs_wall_overlay.png^" .. def.texture ..
		"^lottstairs_wall_overlay.png^[makealpha:255,126,126"
	local flatgroups3 = table.copy(def.groups)
	flatgroups3.not_in_creative_inventory = 1
	flatgroups3.wall = 1
	if def.ena_fence ~= false then
		minetest.register_node(":lottstairs:"..name.."_wall", {
			description = def.description.." Wall" or "_wall",
			drawtype = "nodebox",
			groups = flatgroups3,
			tiles = {def.texture},
			inventory_image = wall_texture,
			wield_image = wall_texture,
			paramtype = "light",
			sunlight_propagates = true,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "connected",
				fixed = {{-1/4, -1/2, -1/4, 1/4, 1/2, 1/4}},
				-- connect_bottom =
				connect_front = {{-3/16, -1/2, -1/2,  3/16, 3/8, -1/4}},
				connect_left = {{-1/2, -1/2, -3/16, -1/4, 3/8,  3/16}},
				connect_back = {{-3/16, -1/2,  1/4,  3/16, 3/8,  1/2}},
				connect_right = {{ 1/4, -1/2, -3/16,  1/2, 3/8,  3/16}},
			},
			connects_to = {"group:wall", "group:stone", def.connects_to},
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube 2',
			recipe = {
				{'lottstairs:'..name..'_wall'},
			}
		})
	end

	if def.ena_pole ~= false then
		minetest.register_node(":lottstairs:"..name.."_wallpole", {
			description = def.description.." Wallpole" or "Wallpole",
			drawtype = "nodebox",
			groups = flatgroups,
			tiles = def.wall_tiles or {def.texture},
			paramtype = "light",
			paramtype2 = "facedir",
			sunlight_propagates = true,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "fixed",
				fixed = {{-1/4, -1/2, -1/4, 1/4, 1/2, 1/4}},
			},
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube 2',
			recipe = {
				{'lottstairs:'..name..'_wallpole'},
			}
		})
	end
	local flatgroups4 = table.copy(def.groups)
	flatgroups4.not_in_creative_inventory = 1
	flatgroups4.pane = 1
	if def.ena_pane ~= false then
		minetest.register_node(":lottstairs:" .. name .. "_pane_flat", {
			description = def.description.." Pane" or "Pane",
			drawtype = "nodebox",
			groups = flatgroups4,
			tiles = def.pane_flat_tiles or {def.texture},
			inventory_image = def.texture,
			wield_image = def.texture,
			paramtype = "light",
			paramtype2 = "facedir",
			sunlight_propagates = true,
			
			drop = def.drop,
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "fixed",
				fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
			},
			selection_box = {
				type = "fixed",
				fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
			},
			connect_sides = { "left", "right" },
		})
		minetest.register_node(":lottstairs:"..name.."_pane", {
			description = def.description.. " Pane" or "Pane",
			drawtype = "nodebox",
			tiles = def.pane_tiles or {def.texture},
			groups = flatgroups4,
			paramtype = "light",
			sunlight_propagates = true,
			
			drop = def.drop or "lottstairs:" .. name .. "_pane_flat",
			light_source = def.light_source,
			sounds = def.sounds,
			node_box = {
				type = "connected",
				fixed = {{-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}},
				connect_front = {{-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}},
				connect_left = {{-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}},
				connect_back = {{-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}},
				connect_right = {{1/32, -1/2, -1/32, 1/2, 1/2, 1/32}},
			},
			connects_to = {"group:pane", "group:stone", "group:glass", "group:wood", "group:tree", def.connects_to},
		})
		
		minetest.register_craft({
			output = 'lottstairs:'..name..'_cube',
			recipe = {
				{'lottstairs:'..name..'_pane_flat'},
			}
		})
	end
end
