gul = {}

dofile(minetest.get_modpath("gul").."/potions/cauldron.lua")

gul = {
	players = {},
	effects = {
		phys_override = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					gul.grant(time, user:get_player_name(), fname.."_"..flags.type..sdata.type, name, flags)
					itemstack:take_item()
					return itemstack
				end,
				gul = {
					speed = 0,
					jump = 0,
					gravity = 0,
					air = 0,
				},
			}
			return def
		end,
		fixhp = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					for i=0, (sdata.time or 0) do
						minetest.after(i, function()
							local hp = user:get_hp()
							if flags.inv==true then
								hp = hp - (sdata.hp or 3)
							else
								hp = hp + (sdata.hp or 3)
							end
							hp = math.min(20, hp)
							hp = math.max(0, hp)
							user:set_hp(hp)
						end)
					end
					itemstack:take_item()
					return itemstack
				end,
			}
			def.mobs = {
				on_near = def.on_use,
			}
			return def
		end,
		air = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					local gul_e = gul.players[user:get_player_name()]
					gul_e.air = gul_e.air + (sdata.time or 0)
					for i=0, (sdata.time or 0) do
						minetest.after(i, function()
							local br = user:get_breath()
							if flags.inv==true then
								br = br - (sdata.br or 3)
							else
								br = br + (sdata.br or 3)
							end
							br = math.min(11, br)
							br = math.max(0, br)
							user:set_breath(br)
							
							if i==(sdata.time or 0) then
								gul_e.air = gul_e.air - (sdata.time or 0)
							end
						end)
					end
					itemstack:take_item()
					return itemstack
				end,
			}
			return def
		end,
	},
	grant = function(time, playername, potion_name, type, flags)
		local rootdef = minetest.registered_items[potion_name]
		if rootdef == nil then
			return
		end
		if rootdef.gul == nil then
			return
		end
		local def = {}
		for name, val in pairs(rootdef.gul) do
			def[name] = val
		end
		if flags.inv==true then
			def.gravity = 0 - def.gravity
			def.speed = 0 - def.speed
			def.jump = 0 - def.jump
		end
		gul.addPrefs(playername, def.speed, def.jump, def.gravity)
		gul.refresh(playername)
		minetest.chat_send_player(playername, "You are under the effects of the "..type.." potion.")
		minetest.after(time, function()
			gul.addPrefs(playername, 0-def.speed, 0-def.jump, 0-def.gravity)
			gul.refresh(playername)
			minetest.chat_send_player(playername, "The effects of the "..type.." potion have worn off.")
		end)
	end,
	addPrefs = function(playername, speed, jump, gravity)
		local prefs = gul.players[playername]
		prefs.speed = prefs.speed + speed
		prefs.jump = prefs.jump + jump
		prefs.gravity = prefs.gravity + gravity
	end,
	refresh = function(playername)
		if minetest.get_player_by_name(playername)~=nil then
			local prefs = gul.players[playername]
			minetest.get_player_by_name(playername):set_physics_override(prefs.speed, prefs.jump, prefs.gravity)
		end
	end,
	register_potion = function(sname, name, fname, time, def)
		local tps = {"power", "corruption"}
		for t=1, #tps do
			for i=1, #def.types do
				local sdata = def.types[i]
				local item_def = {
					description = name.." (Strength: "..tps[t]..sdata.type..")",
					inventory_image = "gul_bottle.png^gul_"..(def.texture or sname)..".png^gul_"..tps[t]..sdata.type..".png",
					drawtype = "plantlike",
					paramtype = "light",
					walkable = false,
					groups = {dig_immediate=3,attached_node=1,vessel=1},
                         sounds = default.node_sound_glass_defaults(),
				}
				item_def.tiles = {item_def.inventory_image}
				local flags = {
					inv = false,
					type = tps[t],
				}
				if t == 2 then
					flags.inv = true
				end
				for name, val in pairs(gul.effects[def.effect](sname, name, fname, time, sdata, flags)) do
					item_def[name] = val
				end
				for name, val in pairs(sdata.set) do
					item_def[name] = val
				end
				for name, val in pairs(sdata.effects) do
					item_def.gul[name] = val
				end
                    minetest.register_node(fname.."_"..tps[t]..sdata.type, item_def)
				--potions.register_liquid(i..tps[t]..sname, name.." ("..tps[t].." "..i..")", item_def.on_use)
				if minetest.get_modpath("curwe")~=nil then
					gul.register_arrow(fname.."_"..tps[t]..sdata.type, i..tps[t]..sname, name.." ("..tps[t].." "..i..")", item_def.on_use,
							item_def.description, item_def.inventory_image)
				end
			end
		end
	end,
}
dofile(minetest.get_modpath("gul").."/arrows.lua")
     
gul.register_potion("athelasbrew", "Athelas Brew", "gul:athelasbrew", 100, {
	effect = "fixhp",
	types = {
		{
			type = 1,
               hp = 1,
               time = 20, 
			set = {},
			effects = {
			},
		},
		{
			type = 2,
               hp = 2,
               time = 50, 
			set = {},
			effects = {
			},
		},
		{
			type = 3,
               hp = 4,
               time = 100, 
			set = {},
			effects = {
			},
		},
	}
})
   
gul.register_potion("limpe", "Limpe", "gul:limpe", 240, {
	effect = "air",
	types = {
		{
			type = 1,
			br = 2,
               hp = 10,
               time = 60,
			set = {},
			effects = {
			},
		},
		{
			type = 2,
			br = 5,
               time = 120,
			set = {},
			effects = {
			},
		},
		{
			type = 3,
			br = 10,
               time = 240,
			set = {},
			effects = {
			},
		},
	}
})

gul.register_potion("miruvor", "Miruvor", "gul:miruvor", 240, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			time = 60,
			effects = {
				jump = 0.3,
			},
		},
		{
			type = 2,
			set = {},
			time = 120,
			effects = {
				jump = 0.6,
			},
		},
		{
			type = 3,
			set = {},
			time = 240,
			effects = {
				jump = 1.0,
			},
		},
	}
})

gul.register_potion("spiderpoison", "Spider Poison", "gul:spiderpoison", 20, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			effects = {
                    speed = -0.2,
                    jump = -0.2,
			},
		},
		{
			type = 2,
			set = {},
			effects = {
                    speed = -0.5,
                    jump = -0.5,
			},
		},
		{
			type = 3,
			set = {},
			effects = {
                    speed = -1,
                    jump = -1,
			},
		},
	}
})

gul.register_potion("orcdraught", "Orc Draught", "gul:orcdraught", 100, {
	effect = "fixhp",
	types = {
		{
			type = 1,
               hp = -1,
               time = 20, 
			set = {},
			effects = {
			},
		},
		{
			type = 2,
               hp = -1,
               time = 50, 
			set = {},
			effects = {
			},
		},
		{
			type = 3,
               hp = -1,
               time = 100, 
			set = {},
			effects = {
			},
		},
	}
})

gul.register_potion("entdraught", "Ent Draught", "gul:entdraught", 240, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			effects = {
                    speed = 1,
                    jump = -0.2,
			},
		},
		{
			type = 2,
			set = {},
			effects = {
                    speed = 2,
                    jump = -0.5,
			},
		},
		{
			type = 3,
			set = {},
			effects = {
                    speed = 3,
                    jump = -1,
			},
		},
	}
})

minetest.register_on_joinplayer(function(player)
	gul.players[player:get_player_name()] = {
		speed = 1,
		jump = 1,
		gravity = 1,
		air = 0,
	}
end)

minetest.register_chatcommand("effect", {
	params = "none",
	description = "get effect info",
	func = function(name, param)
		minetest.chat_send_player(name, "effects:")
		local gul_e = gul.players[name]
		if gul_e~=nil then
			for potion_name, val in pairs(gul_e) do
				minetest.chat_send_player(name, potion_name .. "=" .. val)
			end
		end
	end,
})

minetest.register_craftitem( "gul:wine", {
	description = "Wine",
	inventory_image = "gul_wine.png",
	wield_image = "gul_wine.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craftitem( "gul:beer", {
	description = "Beer",
	inventory_image = "gul_beer.png",
	wield_image = "gul_beer.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craftitem( "gul:ale", {
	description = "Ale",
	inventory_image = "gul_ale.png",
	wield_image = "gul_ale.png",
	on_use = minetest.item_eat(5),
})

minetest.register_craftitem( "gul:mead", {
	description = "Mead",
	inventory_image = "gul_mead.png",
	wield_image = "gul_mead.png",
	on_use = minetest.item_eat(5),
})

minetest.register_craftitem( "gul:cider", {
	description = "Cider",
	inventory_image = "gul_cider.png",
	wield_image = "gul_cider.png",
	on_use = minetest.item_eat(4),
})

function gul.can_dig(pos, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if not inv:is_empty("src") or not inv:is_empty("dst") or not inv:is_empty("fuel") or
	   not inv:is_empty("upgrade1") or not inv:is_empty("upgrade2") then
		minetest.chat_send_player(player:get_player_name(),
			"Brewer cannot be removed because it is not empty")
		return false
	else
		return true
	end
end

function gul.swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name ~= name then
		node.name = name
		minetest.swap_node(pos, node)
	end
	return node.name
end

dofile(minetest.get_modpath("gul").."/potions/potionbrewing.lua")
dofile(minetest.get_modpath("gul").."/potions/brewing.lua")