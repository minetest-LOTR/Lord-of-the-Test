arrows = {
	{"lottthrowing:arrow", "lottthrowing:arrow_entity"},
     {"lottthrowing:arrow_mithril", "lottthrowing:arrow_mithril_entity"},
	{"lottthrowing:arrow_fire", "lottthrowing:arrow_fire_entity"},
     {"lottthrowing:arrow_fire_blue", "lottthrowing:arrow_fire_blue_entity"},
     {"lottthrowing:arrow_magical", "lottthrowing:arrow_magical_entity"},
}

bolts = {
	{"lottthrowing:bolt", "lottthrowing:bolt_entity"},
     {"lottthrowing:bolt_mithril", "lottthrowing:bolt_mithril_entity"},
	{"lottthrowing:bolt_fire", "lottthrowing:bolt_fire_entity"},
}

local lottthrowing_shoot_arrow = function(itemstack, player)
	for _,arrow in ipairs(arrows) do
		if player:get_inventory():get_stack("main", player:get_wield_index()+1):get_name() == arrow[1] then
			if not minetest.setting_getbool("creative_mode") then
				player:get_inventory():remove_item("main", arrow[1])
			end
			local playerpos = player:getpos()
			local obj = minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, arrow[2])
			local dir = player:get_look_dir()
			obj:setvelocity({x=dir.x*19, y=dir.y*19, z=dir.z*19})
			obj:setacceleration({x=dir.x*-3, y=-10, z=dir.z*-3})
			obj:setyaw(player:get_look_yaw()+math.pi)
			minetest.sound_play("lottthrowing_sound", {pos=playerpos})
			if obj:get_luaentity().player == "" then
				obj:get_luaentity().player = player
			end
			obj:get_luaentity().node = player:get_inventory():get_stack("main", 1):get_name()
			return true
		end
	end
	return false
end

local lottthrowing_shoot_bolt = function(itemstack, player)
	for _,arrow in ipairs(bolts) do
		if player:get_inventory():get_stack("main", player:get_wield_index()+1):get_name() == arrow[1] then
			if not minetest.setting_getbool("creative_mode") then
				player:get_inventory():remove_item("main", arrow[1])
			end
			local playerpos = player:getpos()
			local obj = minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, arrow[2])
			local dir = player:get_look_dir()
			obj:setvelocity({x=dir.x*25, y=dir.y*25, z=dir.z*25})
			obj:setacceleration({x=dir.x*-1, y=-5, z=dir.z*-1})
			obj:setyaw(player:get_look_yaw()+math.pi)
			minetest.sound_play("lottthrowing_sound", {pos=playerpos})
			if obj:get_luaentity().player == "" then
				obj:get_luaentity().player = player
			end
			obj:get_luaentity().node = player:get_inventory():get_stack("main", 1):get_name()
			return true
		end
	end
	return false
end

minetest.register_tool("lottthrowing:bow_wood", {
	description = "Normal Wood Bow",
	inventory_image = "lottthrowing_bow_wood.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_arrow(itemstack, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/50)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:bow_wood_alder", {
	description = "Alder Wood Bow",
	inventory_image = "lottthrowing_bow_wood_alder.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_arrow(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/70)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:bow_wood_birch", {
	description = "Birch Wood Bow",
	inventory_image = "lottthrowing_bow_wood_birch.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_arrow(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/100)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:bow_wood_lebethron", {
	description = "Lebethron Wood Bow",
	inventory_image = "lottthrowing_bow_wood_lebethron.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_arrow(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/150)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:bow_wood_mallorn", {
	description = "Mallorn Bow",
	inventory_image = "lottthrowing_bow_wood_mallorn.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_arrow(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/300)
			end
		end
		return itemstack
	end,
})

minetest.register_craft({
	output = 'lottthrowing:bow_wood',
	recipe = {
		{'farming:string', 'default:wood', ''},
		{'farming:string', '', 'default:wood'},
		{'farming:string', 'default:wood', ''},
	}
})

minetest.register_craft({
	output = 'lottthrowing:bow_wood_alder',
	recipe = {
		{'farming:string', 'lottplants:alderwood', ''},
		{'farming:string', '', 'lottplants:alderwood'},
		{'farming:string', 'lottplants:alderwood', ''},
	}
})

minetest.register_craft({
	output = 'lottthrowing:bow_wood_birch',
	recipe = {
		{'farming:string', 'lottplants:birchwood', ''},
		{'farming:string', '', 'lottplants:birchwood'},
		{'farming:string', 'lottplants:birchwood', ''},
	}
})

minetest.register_craft({
	output = 'lottthrowing:bow_wood_lebethron',
	recipe = {
		{'farming:string', 'lottplants:lebethronwood', ''},
		{'farming:string', '', 'lottplants:lebethronwood'},
		{'farming:string', 'lottplants:lebethronwood', ''},
	}
})

minetest.register_craft({
	output = 'lottthrowing:bow_wood_mallorn',
	recipe = {
		{'farming:string', 'lottplants:mallornwood', ''},
		{'farming:string', '', 'lottplants:mallornwood'},
		{'farming:string', 'lottplants:mallornwood', ''},
	}
})

minetest.register_tool("lottthrowing:crossbow_wood", {
	description = "Wooden Crossbow",
	inventory_image = "lottthrowing_crossbow_wood.png",
     stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(itemstack, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/50)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_steel", {
	description = "Steel Crossbow",
	inventory_image = "lottthrowing_crossbow_steel.png",
     stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/70)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_tin", {
	description = "Tin Crossbow",
	inventory_image = "lottthrowing_crossbow_tin.png",
     stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/100)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_silver", {
	description = "Silver Crossbow",
	inventory_image = "lottthrowing_crossbow_silver.png",
     stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/150)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_gold", {
	description = "Gold Crossbow",
	inventory_image = "lottthrowing_crossbow_gold.png",
     stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/200)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_galvorn", {
	description = "Galvorn Crossbow",
	inventory_image = "lottthrowing_crossbow_galvorn.png",
     groups = {forbidden=1},
     stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/300)
			end
		end
		return itemstack
	end,
})

minetest.register_tool("lottthrowing:crossbow_mithril", {
	description = "Mithril Crossbow",
	inventory_image = "lottthrowing_crossbow_mithril.png",
     stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if lottthrowing_shoot_bolt(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/500)
			end
		end
		return itemstack
	end,
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_wood',
	recipe = {
		{'', 'farming:string', 'default:wood'},
		{'default:wood', 'default:wood', 'default:wood'},
		{'', 'farming:string', 'default:wood'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_steel',
	recipe = {
		{'', 'farming:string', 'default:steel_ingot'},
		{'default:wood', 'default:wood', 'default:steel_ingot'},
		{'', 'farming:string', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_tin',
	recipe = {
		{'', 'farming:string', 'lottores:tin_ingot'},
		{'default:wood', 'default:wood', 'lottores:tin_ingot'},
		{'', 'farming:string', 'lottores:tin_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_silver',
	recipe = {
		{'', 'farming:string', 'lottores:silver_ingot'},
		{'default:wood', 'default:wood', 'lottores:silver_ingot'},
		{'', 'farming:string', 'lottores:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_gold',
	recipe = {
		{'', 'farming:string', 'default:gold_ingot'},
		{'default:wood', 'default:wood', 'default:gold_ingot'},
		{'', 'farming:string', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_galvorn',
	recipe = {
		{'', 'farming:string', 'lottores:galvorn_ingot'},
		{'default:wood', 'default:wood', 'lottores:galvorn_ingot'},
		{'', 'farming:string', 'lottores:galvorn_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:crossbow_mithril',
	recipe = {
		{'', 'farming:string', 'lottores:mithril_ingot'},
		{'default:wood', 'default:wood', 'lottores:mithril_ingot'},
		{'', 'farming:string', 'lottores:mithril_ingot'},
	}
})

dofile(minetest.get_modpath("lottthrowing").."/arrow.lua")
dofile(minetest.get_modpath("lottthrowing").."/mithril_arrow.lua")
dofile(minetest.get_modpath("lottthrowing").."/fire_arrow.lua")
dofile(minetest.get_modpath("lottthrowing").."/bluefire_arrow.lua")
dofile(minetest.get_modpath("lottthrowing").."/magical_arrow.lua")

dofile(minetest.get_modpath("lottthrowing").."/bolt.lua")
dofile(minetest.get_modpath("lottthrowing").."/mithril_bolt.lua")
dofile(minetest.get_modpath("lottthrowing").."/fire_bolt.lua")


if minetest.setting_get("log_mods") then
	minetest.log("action", "lottthrowing loaded")
end

