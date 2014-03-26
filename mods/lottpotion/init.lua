lottpotion = {}

dofile(minetest.get_modpath("lottpotion").."/brewing.lua")
dofile(minetest.get_modpath("lottpotion").."/potionbrewing.lua")
dofile(minetest.get_modpath("lottpotion").."/cauldron.lua")
local Vec3 = dofile(minetest.get_modpath("lottpotion").."/lib/Vec3_1-0.lua")

function lottpotion.register_potion(iname, color, exptime, action, expaction)
	local rname = string.gsub(iname, "[-%[%]()1023456789 ]", "")
	minetest.register_craftitem(minetest.get_current_modname()..":"..rname:lower(), {
		description = iname.."",
		inventory_image = "lottpotion_bottle.png^lottpotion_"..color..".png",

		on_place = function(itemstack, user, pointed_thing)
			local cnt = 0
			if user:hud_get(0) and user:hud_get(1) and user:hud_get(2) and user:hud_get(3) then
				user:hud_remove(0)
				user:hud_remove(1)
				user:hud_remove(2)
				user:hud_remove(3)
				samepotion = false
			end
			local length1 = exptime+iname:len()
			local lottpotion_hud_1 = user:hud_add( {
				hud_elem_type = "statbar",
				position = {x=0.206, y=0.009},
				name = "Lottpotions HUD BG",
				scale = {x=1, y=1},
				number = length1*2+1,
				text = "lottpotion_hud_bg.png",
			})
			local length2 = iname:len()/100
			local lottpotion_hud_2 = user:hud_add( {
				hud_elem_type = "statbar",
				position = {x=0.206+length2, y=0.015},
				name = "Lottpotions HUD COUNTER",
				scale = {x=1, y=1},
				number = exptime,
				text = "lottpotion_hud_stat.png",
			})
			
						
			local lottpotion_hud_3 = user:hud_add( {
				hud_elem_type = "text",
				position = {x=0.21, y=0.01},
				number = 0xFFFFFF,
				name = "POTIONS HUD TEXT",
				text = iname..":",
				scale = {x=100, y=100},
			})
			
			local lottpotion_hud_4 = user:hud_add( {
				hud_elem_type = "image",
				position = {x=0.18, y=0.008},
				name = "POTIONS HUD BOTTLE",
				text = "lottpotion_bottle.png^lottpotion_"..color..".png",
				scale = {x=1, y=1},
			})
				local player = user

				local function timer(cnt, player)
					if cnt <= exptime and samepotion == true then
						player:hud_change(1, number, exptime-cnt)
						minetest.after(1, timer, cnt+1, player)
					else
						user:hud_remove(0)
						user:hud_remove(1)
						user:hud_remove(2)
						user:hud_remove(3)
						cnt = 0					
					end
				end
			samepotion = true
			timer(cnt, player)

			action(itemstack, user, pointed_thing)
  			 minetest.after(exptime, expaction, itemstack, user, pointed_thing)
  			 minetest.after(exptime, function(user)
					if user:hud_get(0) and user:hud_get(1) and user:hud_get(2) and user:hud_get(3) then
						user:hud_remove(0)
						user:hud_remove(1)
						user:hud_remove(2)
						user:hud_remove(3)
						cnt = 0
					end
				end, player)
				
  			 itemstack:take_item()
			minetest.add_particlespawner(30, 0.2,
				pointed_thing.above, pointed_thing.above,
				{x=1, y= 2, z=1}, {x=-1, y= 2, z=-1},
				{x=0.2, y=0.2, z=0.2}, {x=-0.2, y=0.5, z=-0.2},
				5, 10,
				1, 3,
				false, "lottpotion_"..color..".png")
  			 
  			 minetest.add_particlespawner(40, 0.1,
				pointed_thing.above, pointed_thing.above,
				{x=2, y=0.2, z=2}, {x=-2, y=0.5, z=-2},
				{x=0, y=-6, z=0}, {x=0, y=-10, z=0},
				0.5, 2,
				0.2, 5,
				true, "lottpotion_shatter.png")
				
				local dir = Vec3(user:get_look_dir()) *20
				minetest.add_particle(
				{x=user:getpos().x, y=user:getpos().y+1.5, z=user:getpos().z}, {x=dir.x, y=dir.y, z=dir.z}, {x=0, y=-10, z=0}, 0.2,
					6, false, "lottpotion_bottle.png^lottpotion_"..color..".png")
			return itemstack
			
		end,
	})
end

lottpotion.register_potion("Strong Athelas Brew", "darkgreen", 60,
function(itemstack, user, pointed_thing) 
	user:set_hp(user:get_hp()+16)
	user:set_physics_override(3, 1, 1)
end,

function(itemstack, user, pointed_thing)
	user:set_physics_override(1,nil,nil)
end)

lottpotion.register_potion("Weak Athelas Brew", "green", 30,
function(itemstack, user, pointed_thing) 
	user:set_hp(user:get_hp()+8)
	user:set_physics_override(3, 1, 1)
end,

function(itemstack, user, pointed_thing)
	user:set_physics_override(1,nil,nil)
end)

lottpotion.register_potion("Strong Orc Draught", "darkgrey", 1,
function(itemstack, user, pointed_thing) 
	user:set_hp(user:get_hp()-16)
end,

function(itemstack, user, pointed_thing)
	return true;
end)

lottpotion.register_potion("Weak Orc Draught", "grey", 1,
function(itemstack, user, pointed_thing) 
	user:set_hp(user:get_hp()-8)
end,

function(itemstack, user, pointed_thing)
	return true;
end)

lottpotion.register_potion("Ent Draught", "cyan", 60,
function(itemstack, user, pointed_thing) 
	user:set_physics_override(0.3, 1, 1)
	user:set_hp(user:get_hp()+20)
end,

function(itemstack, user, pointed_thing)
	user:set_physics_override(1,nil,nil)
end)

lottpotion.register_potion("Limpe", "yellow", 60,
function(itemstack, user, pointed_thing) 
	user:set_physics_override(1, 1, 1)
	user:set_hp(user:get_hp()+1)
end,

function(itemstack, user, pointed_thing)
	user:set_physics_override(1,nil,nil)
end)

lottpotion.register_potion("Miruvor", "miruvor", 60,
function(itemstack, user, pointed_thing) 
	user:set_hp(user:get_hp()+1)
	user:set_physics_override(3, 1, 1)
end,

function(itemstack, user, pointed_thing)
	user:set_physics_override(1,nil,nil)
end)

lottpotion.register_potion("Strong Wine", "strongwine", 60,
function(itemstack, user, pointed_thing)
	user:set_hp(user:get_hp()+16)
	user:set_physics_override(-0.1,1,1)
end,

function(itemstack, user, pointed_thing)
	user:set_physics_override(1,nil,nil)
end)

minetest.register_craftitem( "lottpotion:wine", {
	description = "Wine",
	inventory_image = "lottpotion_wine.png",
	wield_image = "lottpotion_wine.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craftitem( "lottpotion:beer", {
	description = "Beer",
	inventory_image = "lottpotion_beer.png",
	wield_image = "lottpotion_beer.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craftitem( "lottpotion:ale", {
	description = "Ale",
	inventory_image = "lottpotion_ale.png",
	wield_image = "lottpotion_ale.png",
	on_use = minetest.item_eat(5),
})

minetest.register_craftitem( "lottpotion:mead", {
	description = "Mead",
	inventory_image = "lottpotion_mead.png",
	wield_image = "lottpotion_mead.png",
	on_use = minetest.item_eat(5),
})

minetest.register_craftitem( "lottpotion:cider", {
	description = "Cider",
	inventory_image = "lottpotion_cider.png",
	wield_image = "lottpotion_cider.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	output = 'lottpotion:potion_bottle 1',
	recipe = {
		{'vessels:glass_bottle'},
	}
})

minetest.register_craft({
	output = 'lottpotion:glass 1',
	recipe = {
		{'vessels:drinking_glass'},
	}
})
