-- Base Ingredients
minetest.register_node("lottpotion:glass_bottle_mese", {
	description = "Glass Bottle (Mese Water)",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png^lottpotion_water_mese.png"},
	inventory_image = "vessels_glass_bottle_inv.png^lottpotion_water_mese.png",
	wield_image = "vessels_glass_bottle_inv.png^lottpotion_water_mese.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lottpotion:glass_bottle_geodes", {
	description = "Glass Bottle (Geodes Crystal Water)",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png^lottpotion_water_geodes.png"},
	inventory_image = "vessels_glass_bottle_inv.png^lottpotion_water_geodes.png",
	wield_image = "vessels_glass_bottle_inv.png^lottpotion_water_geodes.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lottpotion:glass_bottle_seregon", {
	description = "Glass Bottle (Seregon Water)",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png^lottpotion_water_seregon.png"},
	inventory_image = "vessels_glass_bottle_inv.png^lottpotion_water_seregon.png",
	wield_image = "vessels_glass_bottle_inv.png^lottpotion_water_seregon.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = 'lottpotion:potion_brewer',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
		{'group:stone', 'group:stone', 'group:stone'},
	}
})

lottpotion.potion_recipes = { cooking = { input_size = 1, output_size = 1 } }
function lottpotion.register_recipe_type(typename, origdata)
	local data = {}
	for k, v in pairs(origdata) do data[k] = v end
	data.input_size = data.input_size or 1
	data.output_size = data.output_size or 1
	data.recipes = {}
	lottpotion.potion_recipes[typename] = data
end

local function get_recipe_index(items)
	local l = {}
	for i, stack in ipairs(items) do
		l[i] = ItemStack(stack):get_name()
	end
	table.sort(l)
	return table.concat(l, "/")
end

local function register_recipe(typename, data)
	-- Handle aliases
	for i, stack in ipairs(data.input) do
		data.input[i] = ItemStack(stack):to_string()
	end
	if type(data.output) == "table" then
		for i, v in ipairs(data.output) do
			data.output[i] = ItemStack(data.output[i]):to_string()
		end
	else
		data.output = ItemStack(data.output):to_string()
	end
	
	local recipe = {time = data.time, input = {}, output = data.output}
	local index = get_recipe_index(data.input)
	for _, stack in ipairs(data.input) do
		recipe.input[ItemStack(stack):get_name()] = ItemStack(stack):get_count()
	end
	
	lottpotion.potion_recipes[typename].recipes[index] = recipe
end

function lottpotion.register_recipe(typename, data)
	minetest.after(0.01, register_recipe, typename, data) -- Handle aliases
end

function lottpotion.get_potion_recipe(typename, items)
	if typename == "cooking" then -- Already builtin in Minetest, so use that
		local result, new_input = minetest.get_craft_result({
			method = "cooking",
			width = 1,
			items = items})
		-- Compatibility layer
		if not result or result.time == 0 then
			return nil
		else
			return {time = result.time,
			        new_input = new_input.items,
			        output = result.item}
		end
	end
	local index = get_recipe_index(items)
	local recipe = lottpotion.potion_recipes[typename].recipes[index]
	if recipe then
		local new_input = {}
		for i, stack in ipairs(items) do
			if stack:get_count() < recipe.input[stack:get_name()] then
				return nil
			else
				new_input[i] = ItemStack(stack)
				new_input[i]:take_item(recipe.input[stack:get_name()])
			end
		end
		return {time = recipe.time,
		        new_input = new_input,
		        output = recipe.output}
	else
		return nil
	end
end

lottpotion.register_recipe_type("potionbrew", {
	description = "Potion Brewing",
	input_size = 2,
})

function lottpotion.register_potionbrew_recipe(data)
	data.time = data.time or 120
	lottpotion.register_recipe("potionbrew", data)
end

local recipes = {
--Base Potion
	{"lottplants:seregon_fake",        "lottpotion:glass_bottle_water",         "lottpotion:glass_bottle_seregon"},
     {"default:mese_crystal_fragment 1",        "lottpotion:glass_bottle_water",         "lottpotion:glass_bottle_mese"},
     {"lottores:geodes_crystal_1",        "lottpotion:glass_bottle_water",         "lottpotion:glass_bottle_geodes"},
--Potions
     --Orc Draught
     {"lottmobs:meat_raw 5",        "lottpotion:glass_bottle_seregon",         "lottpotion:orcdraught_power1"},
     {"lottmobs:meat_raw 5",        "lottpotion:orcdraught_power1",         "lottpotion:orcdraught_power2", 180},
     {"lottmobs:meat_raw 5",        "lottpotion:orcdraught_power2",         "lottpotion:orcdraught_power3", 240},
     --Spider Poison
     {"lottmobs:spiderpoison 2",        "lottpotion:glass_bottle_seregon",         "lottpotion:spiderpoison_power1"},
     {"lottmobs:spiderpoison 2",        "lottpotion:spiderpoison_power1",         "lottpotion:spiderpoison_power2", 180},
     {"lottmobs:spiderpoison 2",        "lottpotion:spiderpoison_power2",         "lottpotion:spiderpoison_power3", 240},
     --Limpe
     {"lottplants:yavannamireleaf 10",        "lottpotion:glass_bottle_mese",         "lottpotion:limpe_power1"},
     {"lottplants:yavannamireleaf 10",        "lottpotion:limpe_power1",         "lottpotion:limpe_power2", 180},
     {"lottplants:yavannamireleaf 10",        "lottpotion:limpe_power2",         "lottpotion:limpe_power3", 240},
     --Miruvor
     {"lottplants:yavannamirefruit 2",        "lottpotion:glass_bottle_mese",         "lottpotion:miruvor_power1"},
     {"lottplants:yavannamirefruit 2",        "lottpotion:miruvor_power1",         "lottpotion:miruvor_power2", 180},
     {"lottplants:yavannamirefruit 2",        "lottpotion:miruvor_power2",         "lottpotion:miruvor_power3", 240},
     --Athelas Brew
     {"lottfarming:athelas 3",        "lottpotion:glass_bottle_geodes",         "lottpotion:athelasbrew_power1"},
     {"lottfarming:athelas 3",        "lottpotion:athelasbrew_power1",         "lottpotion:athelasbrew_power2", 180},
     {"lottfarming:athelas 3",        "lottpotion:athelasbrew_power2",         "lottpotion:athelasbrew_power3", 240},
     --Ent Draught
     {"default:leaves 10",        "lottpotion:glass_bottle_geodes",         "lottpotion:entdraught_power1"},
     {"default:leaves 10",        "lottpotion:entdraught_power1",         "lottpotion:entdraught_power2", 120},
     {"default:leaves 10",        "lottpotion:entdraught_power2",         "lottpotion:entdraught_power3", 240},
}

for _, data in pairs(recipes) do
	lottpotion.register_potionbrew_recipe({input = {data[1], data[2]}, output = data[3], time = data[4]})
end

local machine_name = "Potion Brewer"

local formspec =
	"size[8,9]"..
	"label[0,0;"..machine_name.."]"..
	"image[4,2;1,1;lottpotion_bubble_off.png]"..
     "image[3,2;1,1;lottpotion_arrow.png]"..
     "image[5,2;1,1;lottpotion_arrow.png]"..
     "label[3.2,3.2;Fuel:]"..
	"list[current_name;fuel;4,3;1,1;]"..
     "label[1,1.5;Ingredients:]"..
	"list[current_name;src;1,2;2,1;]"..
     "label[6,1.5;Result:]"..
	"list[current_name;dst;6,2;1,1;]"..
	"list[current_player;main;0,5;8,4;]"

minetest.register_node("lottpotion:potion_brewer", {
	description = machine_name,
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottpotion_potion_brewer.png"},
	inventory_image = {"lottpotion_potion_brewer.png"},
	wield_image = {"lottpotion_potion_brewer.png"},
	paramtype = "light",
     sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", formspec)
		meta:set_string("infotext", machine_name)
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 2)
		inv:set_size("dst", 1)
	end,
	can_dig = lottpotion.can_dig,
})

minetest.register_node("lottpotion:potion_brewer_active", {
	description = machine_name,
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottpotion_potion_brewer_active.png"},
     inventory_image = {"lottpotion_potion_brewer.png"},
	wield_image = {"lottpotion_potion_brewer.png"},
	paramtype = "light",
	light_source = 8,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	drop = "lottpotion:potion_brewer",
	groups = {cracky=2, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	can_dig = lottpotion.can_dig,
})

minetest.register_abm({
	nodenames = {"lottpotion:potion_brewer", "lottpotion:potion_brewer_active"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		local inv    = meta:get_inventory()
		
		if inv:get_size("src") == 1 then -- Old furnace -> convert it
			inv:set_size("src", 2)
			inv:set_stack("src", 2, inv:get_stack("src2", 1))
			inv:set_size("src2", 0)
		end
		
		local recipe = nil

		for i, name in pairs({
				"fuel_totaltime",
				"fuel_time",
				"src_totaltime",
				"src_time"}) do
			if not meta:get_float(name) then
				meta:set_float(name, 0.0)
			end
		end

		local result = lottpotion.get_potion_recipe("potionbrew", inv:get_list("src"))

		local was_active = false

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_int("fuel_time", meta:get_int("fuel_time") + 1)
			if result then
				meta:set_int("src_time", meta:get_int("src_time") + 1)
				if meta:get_int("src_time") >= result.time then
					meta:set_int("src_time", 0)
					local result_stack = ItemStack(result.output)
					if inv:room_for_item("dst", result_stack) then
						inv:set_list("src", result.new_input)
						inv:add_item("dst", result_stack)
					end
				end
			else
				meta:set_int("src_time", 0)
			end
		end

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") /
					meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext", ("%s Brewing"):format(machine_name).." ("..percent.."%)")
			lottpotion.swap_node(pos, "lottpotion:potion_brewer_active")
			meta:set_string("formspec",
					"size[8,9]"..
					"label[0,0;"..machine_name.."]"..
					"image[4,2;1,1;lottpotion_bubble_off.png^[lowpart:"..
					(percent)..":lottpotion_bubble.png]"..
     				"image[3,2;1,1;lottpotion_arrow.png]"..
     				"image[5,2;1,1;lottpotion_arrow.png]"..
					"label[3.2,3.2;Fuel:]"..
					"list[current_name;fuel;4,3;1,1;]"..
     				"label[1,1.5;Ingredients:]"..
					"list[current_name;src;1,2;2,1;]"..
    				     "label[6,1.5;Result:]"..
					"list[current_name;dst;6,2;1,1;]"..
					"list[current_player;main;0,5;8,4;]")
			return
		end
          
		local recipe = lottpotion.get_potion_recipe("potionbrew", inv:get_list("src"))

		if not recipe then
			if was_active then
				meta:set_string("infotext", ("%s is empty"):format(machine_name))
				lottpotion.swap_node(pos, "lottpotion:potion_brewer")
				meta:set_string("formspec", formspec)
			end
			return
		end

		local fuel = nil
		local afterfuel
		local fuellist = inv:get_list("fuel")

		if fuellist then
			fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end

		if fuel.time <= 0 then
			meta:set_string("infotext", ("%s Out Of Heat"):format(machine_name))
			lottpotion.swap_node(pos, "lottpotion:potion_brewer")
			meta:set_string("formspec", formspec)
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)

		inv:set_stack("fuel", 1, afterfuel.items[1])
	end,
})