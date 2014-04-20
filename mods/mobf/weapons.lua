-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file weapons.lua
--! @brief weapon related functions
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup weapons Weapons
--! @brief weapon entitys predefined by mob framework (can be extended by mod)
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(weapons_spacer == nil)
local weapons_spacer = {} --unused to fix lua doxygen bug only

-------------------------------------------------------------------------------
-- name: mobf_init_weapons = function(self, dtime)
--
--! @brief initialize weapons handled by mobf mod
--
-------------------------------------------------------------------------------
function mobf_init_weapons()
	minetest.register_entity(":mobf:fireball_entity", MOBF_FIREBALL_ENTITY)
	minetest.register_entity(":mobf:plasmaball_entity", MOBF_PLASMABALL_ENTITY)
	minetest.register_entity(":mobf:arrow_entity", MOBF_ARROW_ENTITY)
end

-------------------------------------------------------------------------------
-- name: mobf_do_area_damage(pos,immune,damage_groups,range) 
--
--! @brief damage all objects within a certain range
--
--! @param pos cennter of damage area
--! @param immune object immune to damage
--! @param damage_groups list of damage groups to do damage to
--! @param range range around pos
-------------------------------------------------------------------------------
function mobf_do_area_damage(pos,immune,damage_groups,range)
	--damage objects within inner blast radius
	mobf_assert_backtrace(type(range) ~= "table")

	objs = minetest.get_objects_inside_radius(pos, range)
	for k, obj in pairs(objs) do

		--don't do damage to issuer
		if obj ~= immune and obj ~= nil then
			
			--TODO as long as minetest still crashes without puncher use this workaround
			
			local worst_damage = 0
			if type(damage_groups) == "table" then
				for k,v in pairs(damage_groups) do
					if v > worst_damage then
						worst_damage = v
					end
				end
			elseif type(damage_groups) == "number" then
				worst_damage =  damage_groups
			else
				mobf_assert_backtrace("invalid damage_groups" == "selected")
			end

			
			local current_hp = obj:get_hp()
			obj:set_hp(current_hp - worst_damage)
			
			--punch
			--obj:punch(nil, 1.0, {
			--	full_punch_interval=1.0,
			--	damage_groups = damage_groups,
			--}, nil)
		end
	end
end


-------------------------------------------------------------------------------
-- name: mobf_do_node_damage(pos,immune_list,range,chance)
--
--! @brief damage all nodes within a certain range
--
--! @param pos center of area
--! @param immune_list list of nodes immune to damage
--! @param range range to do damage
--! @param chance chance damage is done to a node
-------------------------------------------------------------------------------
function mobf_do_node_damage(pos,immune_list,range,chance)
	--do node damage
	for i=pos.x-range, pos.x+range, 1 do
		for j=pos.y-range, pos.y+range, 1 do
			for k=pos.z-range,pos.z+range,1 do
				--TODO create a little bit more sophisticated blast resistance
				if math.random() < chance then
					local toremove = minetest.get_node({x=i,y=j,z=k})

					if toremove ~= nil then
						local immune = false
					
						if immune_list ~= nil then
							for i,v in ipairs(immune_list) do
								if (torremove.name == v) then
									immune = true
								end
							end
						end


						if immune ~= true then					
							minetest.remove_node({x=i,y=j,z=k})
						end
					end
				end
			end
		end
	end
end

mobf_assert_backtrace(MOBF_FIREBALL_ENTITY == nil)
--! @class MOBF_FIREBALL_ENTITY
--! @ingroup weapons
--! @brief a fireball weapon entity
MOBF_FIREBALL_ENTITY = {
	physical = false,
	textures = {"animals_fireball.png"},
	collisionbox = {0,0,0,0,0,0},

	damage_range = 4,
	velocity = 3,
	gravity = -0.01,

	damage_outer = {
					fleshy=4,
					},
	damage_inner = {
					fleshy=8,
					},

	owner = 0,
	lifetime = 30,
	created = -1,
}


-------------------------------------------------------------------------------
-- name: MOBF_FIREBALL_ENTITY.on_activate = function(self, staticdata)
--
--! @brief onactivate callback for fireball
--! @memberof MOBF_FIREBALL_ENTITY
--! @private
--
--! @param self fireball itself
--! @param staticdata 
-------------------------------------------------------------------------------
function MOBF_FIREBALL_ENTITY.on_activate(self,staticdata)
	self.created = mobf_get_current_time()
end

-------------------------------------------------------------------------------
-- name: MOBF_FIREBALL_ENTITY.surfacefire = function(self, staticdata)
--
--! @brief place fire on surfaces around pos
--! @memberof MOBF_FIREBALL_ENTITY
--! @private
--
--! @param pos position to place fire around
--! @param range square around pos to set on fire
-------------------------------------------------------------------------------
function MOBF_FIREBALL_ENTITY.surfacefire(pos,range)

	if mobf_rtd.fire_enabled then
		--start fire on any surface within inner damage range
		for i=pos.x-range/2, pos.x+range/2, 1 do
		for j=pos.y-range/2, pos.y+range/2, 1 do
		for k=pos.z-range/2, pos.z+range/2, 1 do
		
			local current = minetest.get_node({x=i,y=j,z=k})
			local ontop  = minetest.get_node({x=i,y=j+1,z=k})
			
			--print("put fire? " .. printpos({x=i,y=j,z=k}) .. " " .. current.name .. " " ..ontop.name)
			
			if (current.name ~= "air") and
				(current.name ~= "fire:basic_flame") and
				(ontop.name == "air") then
				minetest.set_node({x=i,y=j+1,z=k}, {name="fire:basic_flame"})
			end
					
		end
		end
		end
	else
		minetest.log(LOGLEVEL_ERROR,"MOBF: A fireball without fire mod??!? You're kidding!!")
	end
end

-------------------------------------------------------------------------------
-- name: MOBF_FIREBALL_ENTITY.on_step = function(self, dtime)
--
--! @brief onstep callback for fireball
--! @memberof MOBF_FIREBALL_ENTITY
--! @private
--
--! @param self fireball itself
--! @param dtime time since last callback
-------------------------------------------------------------------------------
function MOBF_FIREBALL_ENTITY.on_step(self, dtime)
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)


	--detect hit
	local objs=minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)

	local hit = false

	for k, obj in pairs(objs) do
		if obj:get_entity_name() ~= "mobf:fireball_entity" and
			obj ~= self.owner then
			hit=true
		end
	end


	if hit then
		--damage objects within inner blast radius
		mobf_do_area_damage(pos,self.owner,self.damage_outer,self.damage_range/4)

		--damage all objects within blast radius
		mobf_do_area_damage(pos,self.owner,self.damage_inner,self.damage_range/2)
		
		MOBF_FIREBALL_ENTITY.surfacefire(pos,self.damage_range)

		self.object:remove()
	end

	-- vanish when hitting a node
	if node.name ~= "air" then
		MOBF_FIREBALL_ENTITY.surfacefire(pos,self.damage_range)
		self.object:remove()
	end

	--remove after lifetime has passed
	if self.created > 0 and
		self.created + self.lifetime < mobf_get_current_time() then
		self.object:remove()
	end
end


mobf_assert_backtrace(MOBF_PLASMABALL_ENTITY == nil)
--! @class MOBF_PLASMABALL_ENTITY
--! @ingroup weapons
--! @brief a plasmaball weapon entity
MOBF_PLASMABALL_ENTITY = {
	physical = false,
	textures = {"animals_plasmaball.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},

	damage_range = 2,
	velocity = 4,
	gravity = -0.001,

	damage = {
			fleshy=4,
			},
			
	damage_pass = {
			fleshy=2,
			},

	owner = 0,
	lifetime = 30,
	created = -1,
}

-------------------------------------------------------------------------------
-- name: MOBF_PLASMABALL_ENTITY.on_activate = function(self, staticdata)
--
--! @brief onactivate callback for plasmaball
--! @memberof MOBF_PLASMABALL_ENTITY
--! @private
--
--! @param self fireball itself
--! @param staticdata 
-------------------------------------------------------------------------------
function MOBF_PLASMABALL_ENTITY.on_activate(self,staticdata)
	self.created = mobf_get_current_time()
end


-------------------------------------------------------------------------------
-- name: MOBF_PLASMABALL_ENTITY.on_step = function(self, dtime)
--
--! @brief onstep callback for plasmaball
--! @memberof MOBF_PLASMABALL_ENTITY
--! @private
--
--! @param self plasmaball itself
--! @param dtime time since last callback
-------------------------------------------------------------------------------
function MOBF_PLASMABALL_ENTITY.on_step(self, dtime)
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)


	--detect hit
	local objs=minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)

	local hit = false

	for k, obj in pairs(objs) do
		if obj:get_entity_name() ~= "mobf:plasmaball_entity" and
			obj ~= self.owner then
			hit=true
		end
	end

	--damage all objects not hit but at least passed
	mobf_do_area_damage(pos,self.owner,self.damage_pass,2)

	if hit then
		--damage objects within inner blast radius
		mobf_do_area_damage(pos,self.owner,self.damage,self.damage_range/4)

		--damage all objects within blast radius
		mobf_do_area_damage(pos,self.owner,self.damage,self.damage_range/2)
	end

	-- vanish when hitting a node
	if node.name ~= "air" or
		hit then

		--replace this loop by minetest.find_node_near?
		--do node damage
		for i=pos.x-1, pos.x+1, 1 do
			for j=pos.y-1, pos.y+1, 1 do
				for k=pos.z-1,pos.z+1,1 do
					--TODO create a little bit more sophisticated blast resistance
					if math.random() < 0.5 then
						local toremove = minetest.get_node({x=i,y=j,z=k})

						if toremove ~= nil and
							toremove.name ~= "default:stone" and
							toremove.name ~= "default:cobble" then
						
							minetest.remove_node({x=i,y=j,z=k})
						end
					end
				end
			end
		end

		self.object:remove()
	end

	--remove after lifetime has passed
	if self.created > 0 and
		self.created + self.lifetime < mobf_get_current_time() then
		self.object:remove()
	end
end

-- -----------------------------------------------------------------------------
-- Code Below is by far extent taken from throwing mod by PilzAdam
-- -----------------------------------------------------------------------------

mobf_assert_backtrace(MOBF_ARROW_ENTITY == nil)
--! @class MOBF_ARROW_ENTITY
--! @ingroup weapons
--! @brief a arrow entity
MOBF_ARROW_ENTITY={
	physical = false,
	timer=0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"mobf:arrow_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
	
	velocity =6,
	damage_groups = {
					fleshy=3,
					daemon=1.5
					},
	gravity  =9.81,
}

-------------------------------------------------------------------------------
-- name: MOBF_ARROW_ENTITY.on_step = function(self, dtime)
--
--! @brief onstep callback for arrow
--! @memberof MOBF_ARROW_ENTITY
--! @private
--
--! @param self arrow itself
--! @param dtime time since last callback
-------------------------------------------------------------------------------
MOBF_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer>0.2 then
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil and
				obj ~= self.owner then
				if obj:get_luaentity().name ~= "mobf:arrow_entity" and 
					obj:get_luaentity().name ~= "__builtin:item" then
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						damage_groups = self.damage_groups,
					}, nil)
					self.object:remove()
				end
			else
				--punch a player
				obj:punch(self.object, 1.0, {
					full_punch_interval=1.0,
					damage_groups = self.damage_groups,
				}, nil)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x~=nil then
		if node.name ~= "air" then
			minetest.add_item(self.lastpos, 'mobf:arrow')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end


-- moved due to doxygen problems
minetest.register_node("mobf:arrow_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- Shaft
			{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
			--Spitze
			{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
			{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
			--Federn
			{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
			{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
			{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
			{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},
			
			{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
			{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
			{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
			{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
		}
	},
	tiles = {"mobf_arrow.png", "mobf_arrow.png", "mobf_arrow_back.png",
			"mobf_arrow_front.png", "mobf_arrow_2.png", "mobf_arrow.png"},
	groups = {not_in_creative_inventory=1},
})
	
local mods = minetest.get_modnames()
if mobf_contains(mods,"throwing") then
	print("throwing mod found2!")
	minetest.register_alias("mobf:arrow", "throwing:arrow")
end
