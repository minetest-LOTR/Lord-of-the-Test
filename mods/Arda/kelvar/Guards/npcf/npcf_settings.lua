npcf = {}
NPCF_ANIM_STAND = 1
NPCF_ANIM_SIT = 2
NPCF_ANIM_LAY = 3
NPCF_ANIM_WALK = 4
NPCF_ANIM_WALK_MINE = 5
NPCF_ANIM_MINE = 6
NPCF_SHOW_IN_CREATIVE = true
NPCF_SHOW_NAMETAGS = true
NPCF_BUILDER_REQ_MATERIALS = false
NPCF_DECO_FREE_ROAMING = true
NPCF_GUARD_ATTACK_PLAYERS = true
NPCF_DUPLICATE_REMOVAL_TIME = 10

local input = io.open(minetest.get_modpath("kelvar").."/Guards/npcf/npcf.conf", "r")
if input then
	dofile(minetest.get_modpath("kelvar").."/Guards/npcf/npcf.conf")
	input:close()
	input = nil
end
local timer = 0
local index = {}
input = io.open(NPCF_DATADIR.."/index.txt", "r")
if input then
	index = minetest.deserialize(input:read('*all'))
	io.close(input)
else
	os.execute("mkdir \""..NPCF_DATADIR.."\"")
	local output = io.open(NPCF_DATADIR.."/index.txt", 'w')
	if output then
		output:write(minetest.serialize(index))
		io.close(output)
	end
end
local default_npc = {
	hp_max = 60,
	physical = true,
	weight = 5,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	visual_size = {x=1, y=1},
	mesh = "character.x",
	textures = {"character.png"},
	colors = {},
	is_visible = true,
	makes_footstep_sound = true,
	automatic_rotate = false,
	stepheight = 0,
	automatic_face_movement_dir = false,
	armor_groups = {fleshy=100},
	animation = {
		stand_START = 0,
		stand_END = 79,
		sit_START = 81,
		sit_END = 160,
		lay_START = 162,
		lay_END = 166,
		walk_START = 168,
		walk_END = 187,
		mine_START = 189,
		mine_END = 198,
		walk_mine_START = 200,
		walk_mine_END = 219,
	},
	animation_speed = 30,
	decription = "Default NPC",
	inventory_image = "npcf_inv_top.png",
	show_nametag = true,
	nametag_color = "white",
	metadata = {},
	var = {},
}
local tough_npc = {
	hp_max = 120,
	physical = true,
	weight = 5,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	visual_size = {x=1, y=1},
	mesh = "character.x",
	textures = {"character.png"},
	colors = {},
	is_visible = true,
	makes_footstep_sound = true,
	automatic_rotate = false,
	stepheight = 0,
	automatic_face_movement_dir = false,
	armor_groups = {fleshy=100},
	animation = {
		stand_START = 0,
		stand_END = 79,
		sit_START = 81,
		sit_END = 160,
		lay_START = 162,
		lay_END = 166,
		walk_START = 168,
		walk_END = 187,
		mine_START = 189,
		mine_END = 198,
		walk_mine_START = 200,
		walk_mine_END = 219,
	},
	animation_speed = 30,
	decription = "Tough NPC",
	inventory_image = "npcf_inv_top.png",
	show_nametag = true,
	nametag_color = "white",
	metadata = {},
	var = {},
}
local weak_npc = {
	hp_max = 30,
	physical = true,
	weight = 5,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	visual_size = {x=1, y=1},
	mesh = "character.x",
	textures = {"character.png"},
	colors = {},
	is_visible = true,
	makes_footstep_sound = true,
	automatic_rotate = false,
	stepheight = 0,
	automatic_face_movement_dir = false,
	armor_groups = {fleshy=100},
	animation = {
		stand_START = 0,
		stand_END = 79,
		sit_START = 81,
		sit_END = 160,
		lay_START = 162,
		lay_END = 166,
		walk_START = 168,
		walk_END = 187,
		mine_START = 189,
		mine_END = 198,
		walk_mine_START = 200,
		walk_mine_END = 219,
	},
	animation_speed = 30,
	decription = "Weak NPC",
	inventory_image = "npcf_inv_top.png",
	show_nametag = true,
	nametag_color = "white",
	metadata = {},
	var = {},
}
local nametag = {
	npcf_id = "nametag",
	physical = false,
	collisionbox = {x=0, y=0, z=0},
	visual = "sprite",
	textures = {"npcf_tag_bg.png"},
	visual_size = {x=0.72, y=0.12, z=0.72},
	npc_name = nil,
	on_activate = function(self, staticdata, dtime_s)
		if staticdata == "expired" then
			self.object:remove()
		end
	end,
	get_staticdata = function(self)
		return "expired"
	end,
}
local form_reg = "size[8,3]"
	.."label[0,0;NPC Name, max 12 characters (A-Za-z0-9_-)]"
	.."field[0.5,1.5;7.5,0.5;name;Name;]"
	.."button_exit[5,2.5;2,0.5;cancel;Cancel]"
	.."button_exit[7,2.5;1,0.5;submit;Ok]"

local function get_valid_player_name(player)
	if player then
		if player:is_player() then
			local player_name = player:get_player_name()
			if minetest.get_player_by_name(player_name) then
				return player_name
			end
		end
	end
end

local function get_valid_npc_name(npc_name)
	return npc_name:len() <= 12 and npc_name:match("^[A-Za-z0-9%_%-]+$")
end

local function get_valid_entity(luaentity)
	if luaentity then
		if luaentity.name and luaentity.owner and luaentity.origin then
			return true
		end
	end
end

local function add_nametag(parent)
	if parent.npc_name then
		local pos = parent.object:getpos()
		local tag = minetest.add_entity(pos, "kelvar:nametag")
		if tag then
			local color = "W"
			if minetest.get_modpath("textcolors") then
				local c = string.upper(parent.nametag_color:sub(1,1))
				if string.match("RGBCYMW", c) then
					color = c
				end
			end
			local texture = "npcf_tag_bg.png"
			local x = math.floor(66 - ((parent.npc_name:len() * 11) / 2))
			local i = 0
			parent.npc_name:gsub(".", function(char)
				if char:byte() > 64 and char:byte() < 91 then
					char = "U"..char
				end
				texture = texture.."^[combine:84x14:"..(x+i)..",0="..color.."_"..char..".png"
				i = i + 11
			end)
			tag:set_attach(parent.object, "", {x=0,y=9,z=0}, {x=0,y=0,z=0})
			tag = tag:get_luaentity() 
			tag.npc_name = parent.npc_name
			tag.object:set_properties({textures={texture}})
		end
	end
end

function npcf:register_npc(name, def)
	for k,v in pairs(default_npc) do
		if not def[k] then
			def[k] = v
		end
	end
	minetest.register_entity(name, {
		hp_max = def.hp_max,
		physical = def.physical,
		weight = def.weight,
		collisionbox = def.collisionbox,
		visual = def.visual,
		visual_size = def.visual_size,
		mesh = def.mesh,
		textures = def.textures,
		colors = def.colors,
		is_visible = def.is_visible,
		makes_footstep_sound = def.makes_footstep_sound,
		automatic_rotate = def.automatic_rotate,
		stepheight = def.stepheight,
		automatic_face_movement_dir = def.automatic_face_movement_dir,
		armor_groups = def.armor_groups,
		on_receive_fields = def.on_receive_fields,
		animation = def.animation,
		animation_speed = def.animation_speed,
		decription = def.description,
		show_nametag = def.show_nametag,
		nametag_color = def.nametag_color,
		metadata = def.metadata,
		properties = {textures = def.textures},
		var = def.var,
		npcf_id = "npc",
		npc_name = nil,
		owner = nil,
		origin = {},
		timer = 0,
		state = NPCF_ANIM_STAND,
		on_activate = function(self, staticdata, dtime_s)
			self.object:set_armor_groups(self.armor_groups)
			if staticdata then
				local npc = minetest.deserialize(staticdata)
				if npc then
					if npc.npc_name and npc.owner and npc.origin then
						self.npc_name = npc.npc_name
						self.owner = npc.owner
						self.origin = npc.origin
						if npc.origin.pos then
							self.object:setpos(npc.origin.pos)
						end
					else
						self.object:remove()
						minetest.log("action", "Removed unknown npc")
						return
					end
					if npc.metadata then
						self.metadata = npc.metadata
					end
					if npc.properties then
						self.properties = npc.properties
						self.object:set_properties(npc.properties)
					end
					if NPCF_SHOW_NAMETAGS == true and self.show_nametag == true then
						add_nametag(self)
					end
				end
			end
			local x = self.animation.stand_START
			local y = self.animation.stand_END
			local speed = self.animation_speed
			if x and y then
				self.object:set_animation({x=x, y=y}, speed)
			end
			if type(def.on_construct) == "function" then
				def.on_construct(self)
			end
			minetest.after(0.5, function()
				if get_valid_entity(self) then
					if type(def.on_activate) == "function" then
						def.on_activate(self, staticdata, dtime_s)
					end
				else
					self.object:remove()
				end
			end)
		end,
		on_rightclick = function(self, clicker)
			if get_valid_entity(self) then
				local player_name = get_valid_player_name(clicker)
				if player_name then
					local ctrl = clicker:get_player_control()
					if ctrl.sneak then
						local yaw = npcf:get_face_direction(self.object:getpos(), clicker:getpos())
						self.object:setyaw(yaw)
						self.origin.yaw = yaw
						return
					end
					minetest.chat_send_player(player_name, self.npc_name)
					if type(def.on_rightclick) == "function" then
						def.on_rightclick(self, clicker)
					end
				end
			end
		end,
		on_punch = function(self, hitter)
			if get_valid_entity(self) then
				if hitter:is_player() then
					local player_name = get_valid_player_name(hitter)
					if player_name == self.owner then
						local ctrl = hitter:get_player_control()
						if ctrl.sneak then
							local yaw = hitter:get_look_yaw() - math.pi * 0.5
							local v = npcf:get_walk_velocity(0.1,0, yaw)
							local pos = self.object:getpos()
							pos = vector.add(v, pos)
							self.object:setpos(pos)
							self.origin.pos = pos
						end
					end
				end
				if type(def.on_punch) == "function" then
					def.on_punch(self, hitter)
				end
			end
		end,
		on_step = function(self, dtime)
			self.timer = self.timer + dtime
			if type(def.on_step) == "function" and get_valid_entity(self) then
				def.on_step(self, dtime)
			end
		end,
		on_tell = function(self, sender, message)
			if type(def.on_tell) == "function" and get_valid_entity(self) then
				local player = minetest.get_player_by_name(sender)
				local senderpos	
				if player then
					senderpos = player:getpos()
				else
					senderpos = {0,0,0}
				end
				def.on_tell(self, sender, senderpos, message)
			end
		end,
		get_staticdata = function(self)
			local npc_data = {
				name = self.name,
				npc_name = self.npc_name,
				owner = self.owner,
				origin = self.origin,
				pos = self.object:getpos(),
				properties = self.properties,
				metadata = self.metadata,
			}
			return minetest.serialize(npc_data)
		end,
	})
	local groups = {falling_node=1}
	if NPCF_SHOW_IN_CREATIVE == false then
		groups.not_in_creative_inventory=1
	end
	minetest.register_node(name.."_spawner", {
		description = def.description,
		inventory_image = minetest.inventorycube("npcf_inv_top.png", def.inventory_image, def.inventory_image),
		tiles = {"npcf_inv_top.png", def.inventory_image, def.inventory_image},
		paramtype2 = "facedir",
		groups = groups,
		sounds = default.node_sound_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", form_reg)
			meta:set_string("infotext", def.description.." spawner")
		end,
		after_place_node = function(pos, placer, itemstack)
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", placer:get_player_name())
			itemstack:take_item()
			return itemstack
		end,
		on_punch = function(pos, node, puncher)
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			local player_name = puncher:get_player_name()
			local admin = minetest.check_player_privs(player_name, {server=true})
			if admin or player_name == owner then
				minetest.remove_node(pos)
				if player_name == owner then
					puncher:get_inventory():add_item("main", node)
				end
			end
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if fields.cancel then
				return
			end
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			local player_name = sender:get_player_name()
			if player_name == owner then
				if get_valid_npc_name(fields.name) then
					if index[fields.name] then
						minetest.chat_send_player(player_name, "Error: Name Already Taken!")
						return
					end
				else
					minetest.chat_send_player(player_name, "Error: Invalid NPC Name!")
					return
				end
				minetest.remove_node(pos)
				local npc_pos = {x=pos.x, y=pos.y + 0.5, z=pos.z}
				local yaw = sender:get_look_yaw() + math.pi * 0.5
				local luaentity = npcf:spawn(npc_pos, name, {
					owner = player_name,
					npc_name = fields.name,
					origin = {pos=npc_pos, yaw=yaw}
				})
				if luaentity and type(def.on_registration) == "function" then
					def.on_registration(luaentity, pos, sender)
				end
			end
		end,
	})
end

function npcf:register_tnpc(name, def)
	for k,v in pairs(tough_npc) do
		if not def[k] then
			def[k] = v
		end
	end
	minetest.register_entity(name, {
		hp_max = def.hp_max,
		physical = def.physical,
		weight = def.weight,
		collisionbox = def.collisionbox,
		visual = def.visual,
		visual_size = def.visual_size,
		mesh = def.mesh,
		textures = def.textures,
		colors = def.colors,
		is_visible = def.is_visible,
		makes_footstep_sound = def.makes_footstep_sound,
		automatic_rotate = def.automatic_rotate,
		stepheight = def.stepheight,
		automatic_face_movement_dir = def.automatic_face_movement_dir,
		armor_groups = def.armor_groups,
		on_receive_fields = def.on_receive_fields,
		animation = def.animation,
		animation_speed = def.animation_speed,
		decription = def.description,
		show_nametag = def.show_nametag,
		nametag_color = def.nametag_color,
		metadata = def.metadata,
		properties = {textures = def.textures},
		var = def.var,
		npcf_id = "npc",
		npc_name = nil,
		owner = nil,
		origin = {},
		timer = 0,
		state = NPCF_ANIM_STAND,
		on_activate = function(self, staticdata, dtime_s)
			self.object:set_armor_groups(self.armor_groups)
			if staticdata then
				local npc = minetest.deserialize(staticdata)
				if npc then
					if npc.npc_name and npc.owner and npc.origin then
						self.npc_name = npc.npc_name
						self.owner = npc.owner
						self.origin = npc.origin
						if npc.origin.pos then
							self.object:setpos(npc.origin.pos)
						end
					else
						self.object:remove()
						minetest.log("action", "Removed unknown npc")
						return
					end
					if npc.metadata then
						self.metadata = npc.metadata
					end
					if npc.properties then
						self.properties = npc.properties
						self.object:set_properties(npc.properties)
					end
					if NPCF_SHOW_NAMETAGS == true and self.show_nametag == true then
						add_nametag(self)
					end
				end
			end
			local x = self.animation.stand_START
			local y = self.animation.stand_END
			local speed = self.animation_speed
			if x and y then
				self.object:set_animation({x=x, y=y}, speed)
			end
			if type(def.on_construct) == "function" then
				def.on_construct(self)
			end
			minetest.after(0.5, function()
				if get_valid_entity(self) then
					if type(def.on_activate) == "function" then
						def.on_activate(self, staticdata, dtime_s)
					end
				else
					self.object:remove()
				end
			end)
		end,
		on_rightclick = function(self, clicker)
			if get_valid_entity(self) then
				local player_name = get_valid_player_name(clicker)
				if player_name then
					local ctrl = clicker:get_player_control()
					if ctrl.sneak then
						local yaw = npcf:get_face_direction(self.object:getpos(), clicker:getpos())
						self.object:setyaw(yaw)
						self.origin.yaw = yaw
						return
					end
					minetest.chat_send_player(player_name, self.npc_name)
					if type(def.on_rightclick) == "function" then
						def.on_rightclick(self, clicker)
					end
				end
			end
		end,
		on_punch = function(self, hitter)
			if get_valid_entity(self) then
				if hitter:is_player() then
					local player_name = get_valid_player_name(hitter)
					if player_name == self.owner then
						local ctrl = hitter:get_player_control()
						if ctrl.sneak then
							local yaw = hitter:get_look_yaw() - math.pi * 0.5
							local v = npcf:get_walk_velocity(0.1,0, yaw)
							local pos = self.object:getpos()
							pos = vector.add(v, pos)
							self.object:setpos(pos)
							self.origin.pos = pos
						end
					end
				end
				if type(def.on_punch) == "function" then
					def.on_punch(self, hitter)
				end
			end
		end,
		on_step = function(self, dtime)
			self.timer = self.timer + dtime
			if type(def.on_step) == "function" and get_valid_entity(self) then
				def.on_step(self, dtime)
			end
		end,
		on_tell = function(self, sender, message)
			if type(def.on_tell) == "function" and get_valid_entity(self) then
				local player = minetest.get_player_by_name(sender)
				local senderpos	
				if player then
					senderpos = player:getpos()
				else
					senderpos = {0,0,0}
				end
				def.on_tell(self, sender, senderpos, message)
			end
		end,
		get_staticdata = function(self)
			local npc_data = {
				name = self.name,
				npc_name = self.npc_name,
				owner = self.owner,
				origin = self.origin,
				pos = self.object:getpos(),
				properties = self.properties,
				metadata = self.metadata,
			}
			return minetest.serialize(npc_data)
		end,
	})
	local groups = {falling_node=1}
	if NPCF_SHOW_IN_CREATIVE == false then
		groups.not_in_creative_inventory=1
	end
	minetest.register_node(name.."_spawner", {
		description = def.description,
		inventory_image = minetest.inventorycube("npcf_inv_top.png", def.inventory_image, def.inventory_image),
		tiles = {"npcf_inv_top.png", def.inventory_image, def.inventory_image},
		paramtype2 = "facedir",
		groups = groups,
		sounds = default.node_sound_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", form_reg)
			meta:set_string("infotext", def.description.." spawner")
		end,
		after_place_node = function(pos, placer, itemstack)
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", placer:get_player_name())
			itemstack:take_item()
			return itemstack
		end,
		on_punch = function(pos, node, puncher)
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			local player_name = puncher:get_player_name()
			local admin = minetest.check_player_privs(player_name, {server=true})
			if admin or player_name == owner then
				minetest.remove_node(pos)
				if player_name == owner then
					puncher:get_inventory():add_item("main", node)
				end
			end
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if fields.cancel then
				return
			end
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			local player_name = sender:get_player_name()
			if player_name == owner then
				if get_valid_npc_name(fields.name) then
					if index[fields.name] then
						minetest.chat_send_player(player_name, "Error: Name Already Taken!")
						return
					end
				else
					minetest.chat_send_player(player_name, "Error: Invalid NPC Name!")
					return
				end
				minetest.remove_node(pos)
				local npc_pos = {x=pos.x, y=pos.y + 0.5, z=pos.z}
				local yaw = sender:get_look_yaw() + math.pi * 0.5
				local luaentity = npcf:spawn(npc_pos, name, {
					owner = player_name,
					npc_name = fields.name,
					origin = {pos=npc_pos, yaw=yaw}
				})
				if luaentity and type(def.on_registration) == "function" then
					def.on_registration(luaentity, pos, sender)
				end
			end
		end,
	})
end

function npcf:register_wnpc(name, def)
	for k,v in pairs(weak_npc) do
		if not def[k] then
			def[k] = v
		end
	end
	minetest.register_entity(name, {
		hp_max = def.hp_max,
		physical = def.physical,
		weight = def.weight,
		collisionbox = def.collisionbox,
		visual = def.visual,
		visual_size = def.visual_size,
		mesh = def.mesh,
		textures = def.textures,
		colors = def.colors,
		is_visible = def.is_visible,
		makes_footstep_sound = def.makes_footstep_sound,
		automatic_rotate = def.automatic_rotate,
		stepheight = def.stepheight,
		automatic_face_movement_dir = def.automatic_face_movement_dir,
		armor_groups = def.armor_groups,
		on_receive_fields = def.on_receive_fields,
		animation = def.animation,
		animation_speed = def.animation_speed,
		decription = def.description,
		show_nametag = def.show_nametag,
		nametag_color = def.nametag_color,
		metadata = def.metadata,
		properties = {textures = def.textures},
		var = def.var,
		npcf_id = "npc",
		npc_name = nil,
		owner = nil,
		origin = {},
		timer = 0,
		state = NPCF_ANIM_STAND,
		on_activate = function(self, staticdata, dtime_s)
			self.object:set_armor_groups(self.armor_groups)
			if staticdata then
				local npc = minetest.deserialize(staticdata)
				if npc then
					if npc.npc_name and npc.owner and npc.origin then
						self.npc_name = npc.npc_name
						self.owner = npc.owner
						self.origin = npc.origin
						if npc.origin.pos then
							self.object:setpos(npc.origin.pos)
						end
					else
						self.object:remove()
						minetest.log("action", "Removed unknown npc")
						return
					end
					if npc.metadata then
						self.metadata = npc.metadata
					end
					if npc.properties then
						self.properties = npc.properties
						self.object:set_properties(npc.properties)
					end
					if NPCF_SHOW_NAMETAGS == true and self.show_nametag == true then
						add_nametag(self)
					end
				end
			end
			local x = self.animation.stand_START
			local y = self.animation.stand_END
			local speed = self.animation_speed
			if x and y then
				self.object:set_animation({x=x, y=y}, speed)
			end
			if type(def.on_construct) == "function" then
				def.on_construct(self)
			end
			minetest.after(0.5, function()
				if get_valid_entity(self) then
					if type(def.on_activate) == "function" then
						def.on_activate(self, staticdata, dtime_s)
					end
				else
					self.object:remove()
				end
			end)
		end,
		on_rightclick = function(self, clicker)
			if get_valid_entity(self) then
				local player_name = get_valid_player_name(clicker)
				if player_name then
					local ctrl = clicker:get_player_control()
					if ctrl.sneak then
						local yaw = npcf:get_face_direction(self.object:getpos(), clicker:getpos())
						self.object:setyaw(yaw)
						self.origin.yaw = yaw
						return
					end
					minetest.chat_send_player(player_name, self.npc_name)
					if type(def.on_rightclick) == "function" then
						def.on_rightclick(self, clicker)
					end
				end
			end
		end,
		on_punch = function(self, hitter)
			if get_valid_entity(self) then
				if hitter:is_player() then
					local player_name = get_valid_player_name(hitter)
					if player_name == self.owner then
						local ctrl = hitter:get_player_control()
						if ctrl.sneak then
							local yaw = hitter:get_look_yaw() - math.pi * 0.5
							local v = npcf:get_walk_velocity(0.1,0, yaw)
							local pos = self.object:getpos()
							pos = vector.add(v, pos)
							self.object:setpos(pos)
							self.origin.pos = pos
						end
					end
				end
				if type(def.on_punch) == "function" then
					def.on_punch(self, hitter)
				end
			end
		end,
		on_step = function(self, dtime)
			self.timer = self.timer + dtime
			if type(def.on_step) == "function" and get_valid_entity(self) then
				def.on_step(self, dtime)
			end
		end,
		on_tell = function(self, sender, message)
			if type(def.on_tell) == "function" and get_valid_entity(self) then
				local player = minetest.get_player_by_name(sender)
				local senderpos	
				if player then
					senderpos = player:getpos()
				else
					senderpos = {0,0,0}
				end
				def.on_tell(self, sender, senderpos, message)
			end
		end,
		get_staticdata = function(self)
			local npc_data = {
				name = self.name,
				npc_name = self.npc_name,
				owner = self.owner,
				origin = self.origin,
				pos = self.object:getpos(),
				properties = self.properties,
				metadata = self.metadata,
			}
			return minetest.serialize(npc_data)
		end,
	})
	local groups = {falling_node=1}
	if NPCF_SHOW_IN_CREATIVE == false then
		groups.not_in_creative_inventory=1
	end
	minetest.register_node(name.."_spawner", {
		description = def.description,
		inventory_image = minetest.inventorycube("npcf_inv_top.png", def.inventory_image, def.inventory_image),
		tiles = {"npcf_inv_top.png", def.inventory_image, def.inventory_image},
		paramtype2 = "facedir",
		groups = groups,
		sounds = default.node_sound_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", form_reg)
			meta:set_string("infotext", def.description.." spawner")
		end,
		after_place_node = function(pos, placer, itemstack)
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", placer:get_player_name())
			itemstack:take_item()
			return itemstack
		end,
		on_punch = function(pos, node, puncher)
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			local player_name = puncher:get_player_name()
			local admin = minetest.check_player_privs(player_name, {server=true})
			if admin or player_name == owner then
				minetest.remove_node(pos)
				if player_name == owner then
					puncher:get_inventory():add_item("main", node)
				end
			end
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if fields.cancel then
				return
			end
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			local player_name = sender:get_player_name()
			if player_name == owner then
				if get_valid_npc_name(fields.name) then
					if index[fields.name] then
						minetest.chat_send_player(player_name, "Error: Name Already Taken!")
						return
					end
				else
					minetest.chat_send_player(player_name, "Error: Invalid NPC Name!")
					return
				end
				minetest.remove_node(pos)
				local npc_pos = {x=pos.x, y=pos.y + 0.5, z=pos.z}
				local yaw = sender:get_look_yaw() + math.pi * 0.5
				local luaentity = npcf:spawn(npc_pos, name, {
					owner = player_name,
					npc_name = fields.name,
					origin = {pos=npc_pos, yaw=yaw}
				})
				if luaentity and type(def.on_registration) == "function" then
					def.on_registration(luaentity, pos, sender)
				end
			end
		end,
	})
end

function npcf:spawn(pos, name, def)
	if pos and name and def.npc_name and def.owner then
		if get_valid_npc_name(def.npc_name) and index[def.npc_name] == nil then
			local entity = minetest.add_entity(pos, name)
			if entity then
				local luaentity = entity:get_luaentity()
				if luaentity then
					index[def.npc_name] = def.owner
					luaentity.owner = def.owner 
					luaentity.npc_name = def.npc_name
					luaentity.origin = def.origin or {pos=pos, yaw=0}
					if def.origin then
						luaentity.object:setyaw(luaentity.origin.yaw)
					end
					if npcf:save(luaentity) then
						local output = io.open(NPCF_DATADIR.."/index.txt", 'w')
						if output then
							output:write(minetest.serialize(index))
							io.close(output)
							if NPCF_SHOW_NAMETAGS == true and luaentity.show_nametag == true then
								add_nametag(luaentity)
							end
							return luaentity
						else
							minetest.log("error", "Failed to add "..def.npc_name.." to NPC index")
						end
					else
						minetest.log("error", "Failed to save NPC "..def.npc_name)
					end
				end
			end
		end
	end
end

function npcf:clear(npc_name)
	if get_valid_npc_name(npc_name) then
		for _,ref in pairs(minetest.luaentities) do
			if ref.object and ref.npc_name == npc_name then
				ref.object:remove()
			end
		end
	end
end

function npcf:load(npc_name, pos)
	if get_valid_npc_name(npc_name) then
		npcf:clear(npc_name)
		local input = io.open(NPCF_DATADIR.."/"..npc_name..".npc", "r")
		if input then
			local data = minetest.deserialize(input:read('*all'))
			io.close(input)
			if data then
				if pos and data.origin then
					data.origin.pos = pos
				end
				if data.origin.pos then
					local npc = minetest.add_entity(data.origin.pos, data.name)
					if npc then
						local luaentity = npc:get_luaentity()
						if luaentity then
							luaentity.owner = data.owner
							luaentity.npc_name = npc_name
							luaentity.origin = data.origin
							luaentity.animation = data.animation
							luaentity.metadata = data.metadata
							luaentity.object:setyaw(data.origin.yaw)
							luaentity.properties = data.properties
							luaentity.object:set_properties(data.properties)
							if NPCF_SHOW_NAMETAGS == true and luaentity.show_nametag == true then
								add_nametag(luaentity)
							end
							return 1
						end
					end
				end
			end
		end
		minetest.log("error", "Failed to load "..npc_name)
		return
	end
	minetest.log("error", "Attempt to load invalid NPC")
end

function npcf:save(luaentity)
	if get_valid_entity(luaentity) then
		local npc = {
			name = luaentity.name,
			owner = luaentity.owner,
			origin = luaentity.origin,
			animation = luaentity.animation,
			metadata = luaentity.metadata,
			properties = luaentity.properties,
		}
		local npc_name = luaentity.npc_name
		local output = io.open(NPCF_DATADIR.."/"..npc_name..".npc", 'w')
		if output then
			output:write(minetest.serialize(npc))
			io.close(output)
			return 1
		end
		minetest.log("error", "Failed to save NPC "..npc_name)
		return
	end
	minetest.log("error", "Attempt to save invalid NPC")
end

function npcf:set_animation(luaentity, state)
	if get_valid_entity(luaentity) and state then
		if state ~= luaentity.state then
			local speed = luaentity.animation_speed
			local anim = luaentity.animation
			if speed and anim then
				if state == NPCF_ANIM_STAND and anim.stand_START and anim.stand_END then
					luaentity.object:set_animation({x=anim.stand_START, y=anim.stand_END}, speed)
				elseif state == NPCF_ANIM_SIT and anim.sit_START and anim.sit_END then
					luaentity.object:set_animation({x=anim.sit_START, y=anim.sit_END}, speed)
				elseif state == NPCF_ANIM_LAY and anim.lay_START and anim.lay_END then
					luaentity.object:set_animation({x=anim.lay_START, y=anim.lay_END}, speed)
				elseif state == NPCF_ANIM_WALK and anim.walk_START and anim.walk_END then
					luaentity.object:set_animation({x=anim.walk_START, y=anim.walk_END}, speed)
				elseif state == NPCF_ANIM_WALK_MINE and anim.walk_mine_START and anim.walk_mine_END then
					luaentity.object:set_animation({x=anim.walk_mine_START, y=anim.walk_mine_END}, speed)
				elseif state == NPCF_ANIM_MINE and anim.mine_START and anim.mine_END then
					luaentity.object:set_animation({x=anim.mine_START, y=anim.mine_END}, speed)
				end
				luaentity.state = state
			end
		end
	end
end

function npcf:get_index()
	return index
end

function npcf:get_luaentity(npc_name)
	if get_valid_npc_name(npc_name) then
		for _,ref in pairs(minetest.luaentities) do
			if ref.object then
				if ref.npcf_id == "npc" and ref.npc_name == npc_name then
					return ref.object:get_luaentity()
				end
			end
		end
	end
end

function npcf:get_face_direction(v1, v2)
	if v1 and v2 then
		if v1.x and v2.x and v1.z and v2.z then
			dx = v1.x - v2.x
			dz = v2.z - v1.z
			return math.atan2(dx, dz)
		end
	end
end

function npcf:get_walk_velocity(speed, y, yaw)
	if speed and y and yaw then
		if speed > 0 then
			yaw = yaw + math.pi * 0.5
			local x = math.cos(yaw) * speed
			local z = math.sin(yaw) * speed
			return {x=x, y=y, z=z}
		end
		return {x=0, y=y, z=0}
	end
end

function npcf:show_formspec(player_name, npc_name, formspec)
	if player_name and npc_name and formspec then
		minetest.show_formspec(player_name, "npcf_"..npc_name, formspec)
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname and not fields.quit then
		local npc_name = formname:gsub("npcf_", "")
		if npc_name ~= formname then
			local luaentity = npcf:get_luaentity(npc_name)
			if luaentity then
				for k,v in pairs(fields) do
					if k ~= "" then
						v = string.gsub(v, "^CHG:", "")
						luaentity.metadata[k] = v
					end
				end
				if type(luaentity.on_receive_fields) == "function" then
					luaentity.on_receive_fields(luaentity, fields, player)
				end
			end
		end
	end
end)

minetest.register_entity("kelvar:nametag", nametag)

-- Duplicate Entity Removal (experimental)

if NPCF_DUPLICATE_REMOVAL_TIME > 0 then
	minetest.register_globalstep(function(dtime)
		timer = timer + dtime
		if timer > NPCF_DUPLICATE_REMOVAL_TIME then
			timer = 0
			local dupes = {}
			for _,ref in pairs(minetest.luaentities) do
				local to_remove = false
				if ref.object then
					if ref.npcf_id == "npc" then
						if ref.owner == nil or ref.npc_name == nil then
							to_remove = true
						elseif dupes[ref.npc_name] then
							to_remove = true
						else
							dupes[ref.npc_name] = 1
						end
					end
					local pos = ref.object:getpos()
					if to_remove == true then
						ref.object:remove()
						local pos_str = minetest.pos_to_string(pos)
						minetest.log("action", "Removed duplicate npc at "..pos_str)
						if NPCF_SHOW_NAMETAGS == true then
							for _,object in ipairs(minetest.get_objects_inside_radius(pos, 1)) do
								local luaentity = object:get_luaentity()
								if luaentity then
									if luaentity.npcf_id == "nametag" then
										luaentity.object:remove()
										minetest.log("action", "Removed duplicate nametag at "..pos_str)
										break
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

