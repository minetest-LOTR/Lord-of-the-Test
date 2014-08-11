local function swap_node(pos,name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos,node)
end

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

brewer_formspec =
	"size[8,9]"..
	"label[0,0;Brewer Inactive]"..
	"image[2,2;1,1;default_furnace_fire_bg.png]"..
	"list[current_name;fuel;2,3;1,1;]"..
	"list[current_name;src;2,1;1,1;]"..
	"list[current_name;src2;3,1;1,1;]"..
	"list[current_name;dst;5,1;2,2;]"..
	"list[current_player;main;0,5;8,4;]"

minetest.register_node("lottpotion:brewer", {
	description = "Brewer",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	inventory_image = {"default_wood.png"},
	wield_image = {"default_wood.png"},
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
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", brewer_formspec)
		meta:set_string("infotext", "Brewer Inactive")
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("src2", 1)
		inv:set_size("dst", 4)
	end,
	    can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("src") or not inv:is_empty("dst") or not inv:is_empty("upgrade1") or not inv:is_empty("upgrade2") then
		    minetest.chat_send_player(player:get_player_name(), "Brewer cannot be removed because it is not empty");
		    return false
		else
		    return true
		end
	end,
})

minetest.register_node("lottpotion:brewer_active", {
	description = "Brewer",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	inventory_image = {"default_wood.png"},
	wield_image = {"default_wood.png"},
	node_box = {
        type = "fixed",
            fixed = lottpotion.make_pipe( { {f=0.9,h1=-0.2,h2=0.2,b=0}, {f=0.75,h1=-0.50,h2=-0.35,b=0}, {f=0.75,h1=0.35,h2=0.5,b=0},
                                        {f=0.82,h1=-0.35,h2=-0.2,b=0},  {f=0.82,h1=0.2, h2=0.35,b=0},
                                        {f=0.75,h1= 0.37,h2= 0.42,b=1},
                                        {f=0.75,h1=-0.42,h2=-0.37,b=1}}, 0 ),
    },
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
	light_source = 8,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	drop = "lottpotion:brewer",
	groups = {cracky=2, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	    can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("src") or not inv:is_empty("dst") or not inv:is_empty("upgrade1") or not inv:is_empty("upgrade2") then
		    minetest.chat_send_player(player:get_player_name(), "Potion Brewer cannot be removed because it is not empty");
		    return false
		else
		    return true
		end
	end,
})

minetest.register_abm({
	nodenames = {"lottpotion:brewer","lottpotion:brewer_active"},
	interval = 1,
	chance = 1,

	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		for i, name in pairs({
				"fuel_totaltime",
				"fuel_time",
				"src_totaltime",
				"src_time"
		}) do
			if meta:get_string(name) == "" then
				meta:set_float(name, 0.0)
			end
		end

		local inv    = meta:get_inventory()
		local recipe = nil

		-- Get what to cook if anything
		local srcstack = inv:get_stack("src", 1)
		if srcstack then src_item1=srcstack:to_table() end

		local src2stack = inv:get_stack("src2", 1)
		if src2stack then src_item2=src2stack:to_table() end

		if src_item1 and src_item2 then
		   recipe = lottpotion.get_brewing_recipe(src_item1,src_item2)
		end

		local was_active = false

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
		   was_active = true
		   meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
		   meta:set_float("src_time", meta:get_float("src_time") + 1)
		   if recipe and meta:get_float("src_time") == 6 then
		      -- check if there's room for output in "dst" list
		      local dst_stack = { name=recipe.dst_name, count=recipe.dst_count}
		      if inv:room_for_item("dst",dst_stack) then
			 -- Take stuff from "src" list
			 srcstack:take_item(recipe.src1_count)
			 inv:set_stack("src", 1, srcstack)
			 src2stack:take_item(recipe.src2_count)
			 inv:set_stack("src2", 1, src2stack)
			 -- Put result in "dst" list
			 inv:add_item("dst",dst_stack)
		      else
			 print("Brewer Inventory Full!")
		      end
		      meta:set_string("src_time", 0)
		   end
		end

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
		   local percent = math.floor(meta:get_float("fuel_time") /
					   meta:get_float("fuel_totaltime") * 100)
		   meta:set_string("infotext","Brewer Active: "..percent.."%")
		   swap_node(pos,"lottpotion:brewer_active")
		   meta:set_string("formspec",
				   "size[8,9]"..
				      "label[0,0; Brewer Active]"..
				      "image[2,2;1,1;default_furnace_fire_bg.png^[lowpart:"..
				      (100-percent)..":default_furnace_fire_fg.png]"..
				   "list[current_name;fuel;2,3;1,1;]"..
				   "list[current_name;src;2,1;1,1;]"..
				   "list[current_name;src2;3,1;1,1;]"..
				   "list[current_name;dst;5,1;2,2;]"..
				   "list[current_player;main;0,5;8,4;]")
		   return
		end
		srcstack = inv:get_stack("src", 1)
		if srcstack then src_item1=srcstack:to_table() end
		srcstack = inv:get_stack("src2", 1)
		if srcstack then src_item2=srcstack:to_table() end
		if src_item1 and src_item2 then
		   recipe = lottpotion.get_brewing_recipe(src_item1,src_item2)
		end

		if recipe==nil then
		   if was_active then
		      meta:set_string("infotext","Brewer is Empty")
		      swap_node(pos,"lottpotion:brewer")
		      meta:set_string("formspec", brewer_formspec)
		   end
		   return
		end
		local fuel = nil
		local fuellist = inv:get_list("fuel")

		if fuellist then
		   fuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end

		if fuel.time <= 0 then
		   meta:set_string("infotext","Brewer out of heat")
		   swap_node(pos,"lottpotion:brewer")
		   meta:set_string("formspec", brewer_formspec)
		   return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)

		local stack = inv:get_stack("fuel", 1)
		stack:take_item()
		inv:set_stack("fuel", 1, stack)
	     end,
     })

lottpotion.brewing_recipes = {}

lottpotion.register_brewing_recipe = function(brew1, count1, brew2, count2, result, count3)
				   lottpotion.brewing_recipes[brew1..brew2] = { src1_count = count1, src2_count = count2, dst_name = result, dst_count = count3 }
				   if unified_inventory then
				      unified_inventory.register_craft(
					 {
					    type = "brew",
					    output = result.." "..count3,
					    items = {brew1.." "..count1,brew2.." "..count2},
					    width = 2,
					 })
				   end
				end

lottpotion.get_brewing_recipe = function(brew1, brew2)
			      if lottpotion.brewing_recipes[brew1.name..brew2.name]
				 and brew1.count >= lottpotion.brewing_recipes[brew1.name..brew2.name].src1_count
				 and brew2.count >= lottpotion.brewing_recipes[brew1.name..brew2.name].src2_count then
				 return lottpotion.brewing_recipes[brew1.name..brew2.name]
			      elseif lottpotion.brewing_recipes[brew2.name..brew1.name]
				 and brew2.count >= lottpotion.brewing_recipes[brew2.name..brew1.name].src1_count
				 and brew1.count >= lottpotion.brewing_recipes[brew2.name..brew1.name].src2_count then
				 return lottpotion.brewing_recipes[brew2.name..brew1.name]
			      else
				 return nil
			      end
			   end

lottpotion.register_brewing_recipe("lottfarming:berries",5, "lottpotion:drinking_glass_water",1, "lottpotion:wine",1)
lottpotion.register_brewing_recipe("farming:wheat",3, "lottpotion:drinking_glass_water",1, "lottpotion:beer",1)
lottpotion.register_brewing_recipe("lottplants:honey",6, "lottpotion:drinking_glass_water",1, "lottpotion:mead",1)
lottpotion.register_brewing_recipe("default:apple",6, "lottpotion:drinking_glass_water",1, "lottpotion:cider",1)
lottpotion.register_brewing_recipe("lottfarming:barley",6, "lottpotion:drinking_glass_water",1, "lottpotion:ale",1)

brewing_recipes = {}
registered_recipes_count = 1

function register_brewing_recipe (string1,count1, string2,count2, string3,count3)
   brewing_recipes[registered_recipes_count]={}
   brewing_recipes[registered_recipes_count].src1_name=string1
   brewing_recipes[registered_recipes_count].src1_count=count1
   brewing_recipes[registered_recipes_count].src2_name=string2
   brewing_recipes[registered_recipes_count].src2_count=count2
   brewing_recipes[registered_recipes_count].dst_name=string3
   brewing_recipes[registered_recipes_count].dst_count=count3
   registered_recipes_count=registered_recipes_count+1
   brewing_recipes[registered_recipes_count]={}
   brewing_recipes[registered_recipes_count].src1_name=string2
   brewing_recipes[registered_recipes_count].src1_count=count2
   brewing_recipes[registered_recipes_count].src2_name=string1
   brewing_recipes[registered_recipes_count].src2_count=count1
   brewing_recipes[registered_recipes_count].dst_name=string3
   brewing_recipes[registered_recipes_count].dst_count=count3
   registered_recipes_count=registered_recipes_count+1
   if unified_inventory then
      unified_inventory.register_craft({
		  type = "brew",
		  output = string3.." "..count3,
		  items = {string1.." "..count1,string2.." "..count2},
		  width = 2,
	       })
   end
end

register_brewing_recipe ("lottfarming:berries",5, "lottpotion:drinking_glass_water",1, "lottpotion:wine",1)
register_brewing_recipe ("farming:wheat",3, "lottpotion:drinking_glass_water",1, "lottpotion:beer",1)
register_brewing_recipe ("lottplants:honey",6, "lottpotion:drinking_glass_water",1, "lottpotion:mead",1)
register_brewing_recipe ("default:apple",6, "lottpotion:drinking_glass_water",1, "lottpotion:cider",1)
register_brewing_recipe ("lottfarming:barley",6, "lottpotion:drinking_glass_water",1, "lottpotion:ale",1)

minetest.register_craft({
	output = 'lottpotion:brewer',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', '', 'group:wood'},
		{'group:wood', 'default:steel_ingot', 'group:wood'},
	}
})