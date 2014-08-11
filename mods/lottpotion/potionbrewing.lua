local function swap_node(pos,name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos,node)
end

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




-- Potion Brewer

potionbrewer_formspec =
	"size[8,9]"..
	"label[0,0;Potion Brewer Inactive]"..
	"image[2,2;1,1;default_furnace_fire_bg.png]"..
	"list[current_name;fuel;2,3;1,1;]"..
	"list[current_name;src;2,1;1,1;]"..
	"list[current_name;src2;3,1;1,1;]"..
	"list[current_name;dst;5,1;2,2;]"..
	"list[current_player;main;0,5;8,4;]"

minetest.register_node("lottpotion:potion_brewer", {
	description = "Potion Brewer",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottpotion_potion_brewer.png"},
	inventory_image = {"lottpotion_potion_brewer.png"},
	wield_image = {"lottpotion_potion_brewer.png"},
	paramtype = "light",
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", potionbrewer_formspec)
		meta:set_string("infotext", "Potion Brewer Inactive")
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
		    minetest.chat_send_player(player:get_player_name(), "Potion Brewer cannot be removed because it is not empty");
		    return false
		else
		    return true
		end
	end,
})

minetest.register_node("lottpotion:potion_brewer_active", {
	description = "Potion Brewer",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottpotion_potion_brewer_active.png"},
    inventory_image = {"lottpotion_potion_brewer.png"},
	wield_image = {"lottpotion_potion_brewer.png"},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
	light_source = 8,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	drop = "lottpotion:potion_brewer",
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
	nodenames = {"lottpotion:potion_brewer","lottpotion:potion_brewer_active"},
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
		   recipe = lottpotion.get_potion_brewing_recipe(src_item1,src_item2)
		end

		local was_active = false

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
		   was_active = true
		   meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
		   meta:set_float("src_time", meta:get_float("src_time") + 1)
		   if recipe and meta:get_float("src_time") == 100 then
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
			 print("Potion Brewer Inventory Full!")
		      end
		      meta:set_string("src_time", 0)
		   end
		end
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
		   local percent = math.floor(meta:get_float("fuel_time") /
					   meta:get_float("fuel_totaltime") * 100)
		   meta:set_string("infotext","Potion Brewer Active: "..percent.."%")
		   swap_node(pos,"lottpotion:potion_brewer_active")
		   meta:set_string("formspec",
				   "size[8,9]"..
				      "label[0,0; Potion Brewer Active]"..
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
		   recipe = lottpotion.get_potion_brewing_recipe(src_item1,src_item2)
		end

		if recipe==nil then
		   if was_active then
		      meta:set_string("infotext","Potion Brewer is Empty")
		      swap_node(pos,"lottpotion:potion_brewer")
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
		   meta:set_string("infotext","Potion Brewer out of heat")
		   swap_node(pos,"lottpotion:potion_brewer")
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

lottpotion.potion_brewing_recipes = {}

lottpotion.register_potion_brewing_recipe = function(brew1, count1, brew2, count2, result, count3)
				   lottpotion.potion_brewing_recipes[brew1..brew2] = { src1_count = count1, src2_count = count2, dst_name = result, dst_count = count3 }
				   if unified_inventory then
				      unified_inventory.register_craft(
					 {
					    type = "potion",
					    output = result.." "..count3,
					    items = {brew1.." "..count1,brew2.." "..count2},
					    width = 2,
					 })
				   end
				end

lottpotion.get_potion_brewing_recipe = function(brew1, brew2)
			      if lottpotion.potion_brewing_recipes[brew1.name..brew2.name]
				 and brew1.count >= lottpotion.potion_brewing_recipes[brew1.name..brew2.name].src1_count
				 and brew2.count >= lottpotion.potion_brewing_recipes[brew1.name..brew2.name].src2_count then
				 return lottpotion.potion_brewing_recipes[brew1.name..brew2.name]
			      elseif lottpotion.potion_brewing_recipes[brew2.name..brew1.name]
				 and brew2.count >= lottpotion.potion_brewing_recipes[brew2.name..brew1.name].src1_count
				 and brew1.count >= lottpotion.potion_brewing_recipes[brew2.name..brew1.name].src2_count then
				 return lottpotion.potion_brewing_recipes[brew2.name..brew1.name]
			      else
				 return nil
			      end
			   end

--Base Potion
lottpotion.register_potion_brewing_recipe("lottplants:seregon_fake",1, "lottpotion:glass_bottle_water",1, "lottpotion:glass_bottle_seregon",1)
lottpotion.register_potion_brewing_recipe("default:mese_crystal_fragment",1, "lottpotion:glass_bottle_water",1, "lottpotion:glass_bottle_mese",1)
lottpotion.register_potion_brewing_recipe("lottores:geodes_crystal_1",1, "lottpotion:glass_bottle_water",1, "lottpotion:glass_bottle_geodes",1)
--Potion
----Orc Draught
lottpotion.register_potion_brewing_recipe("lottmobs:meat_raw",5, "lottpotion:glass_bottle_seregon",1, "lottpotion:orcdraught_power1",1)
lottpotion.register_potion_brewing_recipe("lottpotion:orcdraught_power2",1, "lottmobs:meat_raw",5, "lottpotion:orcdraught_power3",1)
lottpotion.register_potion_brewing_recipe("lottmobs:meat_raw",5, "lottpotion:orcdraught_power1",1, "lottpotion:orcdraught_power2",1)
----Spider Poison
lottpotion.register_potion_brewing_recipe("lottmobs:spiderpoison",2, "lottpotion:glass_bottle_seregon",1, "lottpotion:spiderpoison_power1",1)
lottpotion.register_potion_brewing_recipe("lottpotion:spiderpoison_power2",1, "lottmobs:spiderpoison",2, "lottpotion:spiderpoison_power3",1)
lottpotion.register_potion_brewing_recipe("lottmobs:spiderpoison",2, "lottpotion:spiderpoison_power1",1, "lottpotion:spiderpoison_power2",1)
----Limpe
lottpotion.register_potion_brewing_recipe("lottplants:yavannamireleaf",10, "lottpotion:glass_bottle_mese",1, "lottpotion:limpe_power1",1)
lottpotion.register_potion_brewing_recipe("lottpotion:limpe_power2",1, "lottplants:yavannamireleaf",10, "lottpotion:limpe_power3",1)
lottpotion.register_potion_brewing_recipe("lottplants:yavannamireleaf",10, "lottpotion:limpe_power1",1, "lottpotion:limpe_power2",1)
----Miruvor
lottpotion.register_potion_brewing_recipe("lottplants:yavannamirefruit",2, "lottpotion:glass_bottle_mese",1, "lottpotion:miruvor_power1",1)
lottpotion.register_potion_brewing_recipe("lottpotion:miruvor_power2",1, "lottplants:yavannamirefruit",2, "lottpotion:miruvor_power3",1)
lottpotion.register_potion_brewing_recipe("lottplants:yavannamirefruit",2, "lottpotion:miruvor_power1",1, "lottpotion:miruvor_power2",1)
--Athelas Brew
lottpotion.register_potion_brewing_recipe("lottfarming:athelas",3, "lottpotion:glass_bottle_geodes",1, "lottpotion:athelasbrew_power1",1)
lottpotion.register_potion_brewing_recipe("lottpotion:athelasbrew_power2",1, "lottfarming:athelas",3, "lottpotion:athelasbrew_power3",1)
lottpotion.register_potion_brewing_recipe("lottfarming:athelas",3, "lottpotion:athelasbrew_power1",1, "lottpotion:athelasbrew_power2",1)
--Ent Draught
lottpotion.register_potion_brewing_recipe("default:leaves",10, "lottpotion:glass_bottle_geodes",1, "lottpotion:entdraught_power1",1)
lottpotion.register_potion_brewing_recipe("lottpotion:entdraught_power2",1, "default:leaves",10, "lottpotion:entdraught_power3",1)
lottpotion.register_potion_brewing_recipe("default:leaves",10, "lottpotion:entdraught_power1",1, "lottpotion:entdraught_power2",1)


potion_brewing_recipes = {}
registered_recipes_count = 1

function register_potion_brewing_recipe (string1,count1, string2,count2, string3,count3)
   potion_brewing_recipes[registered_recipes_count]={}
   potion_brewing_recipes[registered_recipes_count].src1_name=string1
   potion_brewing_recipes[registered_recipes_count].src1_count=count1
   potion_brewing_recipes[registered_recipes_count].src2_name=string2
   potion_brewing_recipes[registered_recipes_count].src2_count=count2
   potion_brewing_recipes[registered_recipes_count].dst_name=string3
   potion_brewing_recipes[registered_recipes_count].dst_count=count3
   registered_recipes_count=registered_recipes_count+1
   potion_brewing_recipes[registered_recipes_count]={}
   potion_brewing_recipes[registered_recipes_count].src1_name=string2
   potion_brewing_recipes[registered_recipes_count].src1_count=count2
   potion_brewing_recipes[registered_recipes_count].src2_name=string1
   potion_brewing_recipes[registered_recipes_count].src2_count=count1
   potion_brewing_recipes[registered_recipes_count].dst_name=string3
   potion_brewing_recipes[registered_recipes_count].dst_count=count3
   registered_recipes_count=registered_recipes_count+1
   if unified_inventory then
      unified_inventory.register_craft({
		  type = "potion",
		  output = string3.." "..count3,
		  items = {string1.." "..count1,string2.." "..count2},
		  width = 2,
	       })
   end
end

--Base Potion
register_potion_brewing_recipe ("lottplants:seregon_fake",1, "lottpotion:glass_bottle_water",1, "lottpotion:glass_bottle_seregon",1)
register_potion_brewing_recipe ("default:mese_crystal_fragment",1, "lottpotion:glass_bottle_water",1, "lottpotion:glass_bottle_mese",1)
register_potion_brewing_recipe ("lottores:geodes_crystal_1",1, "lottpotion:glass_bottle_water",1, "lottpotion:glass_bottle_geodes",1)
--Potion
----Orc Draught
register_potion_brewing_recipe ("lottmobs:meat_raw",5, "lottpotion:glass_bottle_seregon",1, "lottpotion:orcdraught_power1",1)
register_potion_brewing_recipe ("lottpotion:orcdraught_power2",1, "lottmobs:meat_raw",5, "lottpotion:orcdraught_power3",1)
register_potion_brewing_recipe ("lottmobs:meat_raw",5, "lottpotion:orcdraught_power1",1, "lottpotion:orcdraught_power2",1)
----Spider Poison
register_potion_brewing_recipe ("lottmobs:spiderpoison",2, "lottpotion:glass_bottle_seregon",1, "lottpotion:spiderpoison_power1",1)
register_potion_brewing_recipe ("lottpotion:spiderpoison_power2",1, "lottmobs:spiderpoison",2, "lottpotion:spiderpoison_power3",1)
register_potion_brewing_recipe ("lottmobs:spiderpoison",2, "lottpotion:spiderpoison_power1",1, "lottpotion:spiderpoison_power2",1)
----Limpe
register_potion_brewing_recipe ("lottplants:yavannamireleaf",10, "lottpotion:glass_bottle_mese",1, "lottpotion:limpe_power1",1)
register_potion_brewing_recipe ("lottpotion:limpe_power2",1, "lottplants:yavannamireleaf",10, "lottpotion:limpe_power3",1)
register_potion_brewing_recipe ("lottplants:yavannamireleaf",10, "lottpotion:limpe_power1",1, "lottpotion:limpe_power2",1)
----Miruvor
register_potion_brewing_recipe ("lottplants:yavannamirefruit",2, "lottpotion:glass_bottle_mese",1, "lottpotion:miruvor_power1",1)
register_potion_brewing_recipe ("lottpotion:miruvor_power2",1, "lottplants:yavannamirefruit",2, "lottpotion:miruvor_power3",1)
register_potion_brewing_recipe ("lottplants:yavannamirefruit",2, "lottpotion:miruvor_power1",1, "lottpotion:miruvor_power2",1)
--Athelas Brew
register_potion_brewing_recipe ("lottfarming:athelas",3, "lottpotion:glass_bottle_geodes",1, "lottpotion:athelasbrew_power1",1)
register_potion_brewing_recipe ("lottpotion:athelasbrew_power2",1, "lottfarming:athelas",3, "lottpotion:athelasbrew_power3",1)
register_potion_brewing_recipe ("lottfarming:athelas",3, "lottpotion:athelasbrew_power1",1, "lottpotion:athelasbrew_power2",1)
--Ent Draught
register_potion_brewing_recipe ("default:leaves",10, "lottpotion:glass_bottle_geodes",1, "lottpotion:entdraught_power1",1)
register_potion_brewing_recipe ("lottpotion:entdraught_power2",1, "default:leaves",10, "lottpotion:entdraught_power3",1)
register_potion_brewing_recipe ("default:leaves",10, "lottpotion:entdraught_power1",1, "lottpotion:entdraught_power2",1)


minetest.register_craft({
	output = 'lottpotion:potion_brewer',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
		{'group:stone', 'group:stone', 'group:stone'},
	}
})