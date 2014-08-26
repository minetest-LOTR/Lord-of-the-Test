lottpotion.make_pipe = function( pipes, horizontal )
   local result = {};
   for i, v in pairs( pipes ) do
      local f  = v.f;
      local h1 = v.h1;
      local h2 = v.h2;
      if( not( v.b ) or v.b == 0 ) then
         table.insert( result,   {-0.37*f,  h1,-0.37*f, -0.28*f, h2,-0.28*f});
         table.insert( result,   {-0.37*f,  h1, 0.28*f, -0.28*f, h2, 0.37*f});
         table.insert( result,   { 0.37*f,  h1,-0.28*f,  0.28*f, h2,-0.37*f});
         table.insert( result,   { 0.37*f,  h1, 0.37*f,  0.28*f, h2, 0.28*f});
         table.insert( result,   {-0.30*f,  h1,-0.42*f, -0.20*f, h2,-0.34*f});
         table.insert( result,   {-0.30*f,  h1, 0.34*f, -0.20*f, h2, 0.42*f});
         table.insert( result,   { 0.20*f,  h1,-0.42*f,  0.30*f, h2,-0.34*f});
         table.insert( result,   { 0.20*f,  h1, 0.34*f,  0.30*f, h2, 0.42*f});
         table.insert( result,   {-0.42*f,  h1,-0.30*f, -0.34*f, h2,-0.20*f});
         table.insert( result,   { 0.34*f,  h1,-0.30*f,  0.42*f, h2,-0.20*f});
         table.insert( result,   {-0.42*f,  h1, 0.20*f, -0.34*f, h2, 0.30*f});
         table.insert( result,   { 0.34*f,  h1, 0.20*f,  0.42*f, h2, 0.30*f});
         table.insert( result,   {-0.25*f,  h1,-0.45*f, -0.10*f, h2,-0.40*f});
         table.insert( result,   {-0.25*f,  h1, 0.40*f, -0.10*f, h2, 0.45*f});
         table.insert( result,   { 0.10*f,  h1,-0.45*f,  0.25*f, h2,-0.40*f});
         table.insert( result,   { 0.10*f,  h1, 0.40*f,  0.25*f, h2, 0.45*f});
         table.insert( result,   {-0.45*f,  h1,-0.25*f, -0.40*f, h2,-0.10*f});
         table.insert( result,   { 0.40*f,  h1,-0.25*f,  0.45*f, h2,-0.10*f});
         table.insert( result,   {-0.45*f,  h1, 0.10*f, -0.40*f, h2, 0.25*f});
         table.insert( result,   { 0.40*f,  h1, 0.10*f,  0.45*f, h2, 0.25*f});
         table.insert( result,   {-0.15*f,  h1,-0.50*f,  0.15*f, h2,-0.45*f});
         table.insert( result,   {-0.15*f,  h1, 0.45*f,  0.15*f, h2, 0.50*f});
         table.insert( result,   {-0.50*f,  h1,-0.15*f, -0.45*f, h2, 0.15*f});
         table.insert( result,   { 0.45*f,  h1,-0.15*f,  0.50*f, h2, 0.15*f});
      else
         table.insert( result,   {-0.35*f,  h1,-0.40*f,  0.35*f, h2,0.40*f});
         table.insert( result,   {-0.40*f,  h1,-0.35*f,  0.40*f, h2,0.35*f});
         table.insert( result,   {-0.25*f,  h1,-0.45*f,  0.25*f, h2,0.45*f});
         table.insert( result,   {-0.45*f,  h1,-0.25*f,  0.45*f, h2,0.25*f});
         table.insert( result,   {-0.15*f,  h1,-0.50*f,  0.15*f, h2,0.50*f});
         table.insert( result,   {-0.50*f,  h1,-0.15*f,  0.50*f, h2,0.15*f});
      end
   end
   if( horizontal == 1 ) then
      for i,v in ipairs( result ) do
         result[ i ] = { v[2], v[1], v[3],   v[5], v[4], v[6] };
      end
   end
   return result;
end




minetest.register_craft({
	output = 'lottpotion:brewer',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', '', 'group:wood'},
		{'group:wood', 'default:steel_ingot', 'group:wood'},
	}
})

lottpotion.brew_recipes = { cooking = { input_size = 1, output_size = 1 } }
function lottpotion.register_recipe_type(typename, origdata)
	local data = {}
	for k, v in pairs(origdata) do data[k] = v end
	data.input_size = data.input_size or 1
	data.output_size = data.output_size or 1
	data.recipes = {}
	lottpotion.brew_recipes[typename] = data
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
	
	lottpotion.brew_recipes[typename].recipes[index] = recipe
end

function lottpotion.register_recipe(typename, data)
	minetest.after(0.01, register_recipe, typename, data) -- Handle aliases
end

function lottpotion.get_brew_recipe(typename, items)
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
	local recipe = lottpotion.brew_recipes[typename].recipes[index]
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

lottpotion.register_recipe_type("brew", {
	description = "Brewing",
	input_size = 2,
})

function lottpotion.register_brew_recipe(data)
	data.time = data.time or 60
	lottpotion.register_recipe("brew", data)
end

local recipes = {
--Base Potion
	{"lottfarming:berries 5",        "lottpotion:drinking_glass_water",         "lottpotion:wine"},
     {"farming:wheat 3",        "lottpotion:drinking_glass_water",         "lottpotion:beer"},
     {"lottplants:honey 6",        "lottpotion:drinking_glass_water",         "lottpotion:mead"},
     {"default:apple 5",        "lottpotion:drinking_glass_water",         "lottpotion:cider"},
     {"lottfarming:barley 6",        "lottpotion:drinking_glass_water",         "lottpotion:ale"},
}

for _, data in pairs(recipes) do
	lottpotion.register_brew_recipe({input = {data[1], data[2]}, output = data[3], time = data[4]})
end

local machine_name = "Brewer"

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

minetest.register_node("lottpotion:brewer", {
	description = machine_name,
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	node_box = {
        type = "fixed",
            fixed = lottpotion.make_pipe( { {f=0.9,h1=-0.2,h2=0.2,b=0}, {f=0.75,h1=-0.50,h2=-0.35,b=0}, {f=0.75,h1=0.35,h2=0.5,b=0},
                                        {f=0.82,h1=-0.35,h2=-0.2,b=0},  {f=0.82,h1=0.2, h2=0.35,b=0},
                                        {f=0.75,h1= 0.37,h2= 0.42,b=1},
                                        {f=0.75,h1=-0.42,h2=-0.37,b=1}}, 0 ),
    },
	paramtype = "light",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
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

minetest.register_node("lottpotion:brewer_active", {
	description = machine_name,
	drawtype = "nodebox",
     tiles = {"default_wood.png"},
	node_box = {
        type = "fixed",
            fixed = lottpotion.make_pipe( { {f=0.9,h1=-0.2,h2=0.2,b=0}, {f=0.75,h1=-0.50,h2=-0.35,b=0}, {f=0.75,h1=0.35,h2=0.5,b=0},
                                        {f=0.82,h1=-0.35,h2=-0.2,b=0},  {f=0.82,h1=0.2, h2=0.35,b=0},
                                        {f=0.75,h1= 0.37,h2= 0.42,b=1},
                                        {f=0.75,h1=-0.42,h2=-0.37,b=1}}, 0 ),
    },
	paramtype = "light",
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	drop = "lottpotion:brewer",
	groups = {cracky=2, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	can_dig = lottpotion.can_dig,
})

minetest.register_abm({
	nodenames = {"lottpotion:brewer", "lottpotion:brewer_active"},
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

		local result = lottpotion.get_brew_recipe("brew", inv:get_list("src"))

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
			lottpotion.swap_node(pos, "lottpotion:brewer_active")
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

		local recipe = lottpotion.get_brew_recipe("brew", inv:get_list("src"))

		if not recipe then
			if was_active then
				meta:set_string("infotext", ("%s is empty"):format(machine_name))
				lottpotion.swap_node(pos, "lottpotion:brewer")
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
			lottpotion.swap_node(pos, "lottpotion:brewer")
			meta:set_string("formspec", formspec)
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)

		inv:set_stack("fuel", 1, afterfuel.items[1])
	end,
})