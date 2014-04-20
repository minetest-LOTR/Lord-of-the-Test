-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file mobf.lua
--! @brief class containing mob initialization functions
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--
--! @defgroup mobf Basic mob entity functions
--! @brief a component containing basic functions for mob handling and initialization
--! @ingroup framework_int
--! @{
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(mobf == nil)
--! @class mobf
--! @brief basic management component of mob functions
--!@}
mobf = {}

mobf.on_step_callbacks = {}
mobf.on_punch_callbacks = {}
mobf.on_rightclick_callbacks = {}


------------------------------------------------------------------------------
-- @function [parent=#mobf] register_on_step_callback(callback)
--
--! @brief make a new on_step callback known to mobf
--! @memberof mobf
--! @public
--
--! @param callback to make known to mobf
-------------------------------------------------------------------------------
function mobf.register_on_step_callback(callback)

	if callback.configcheck == nil or
		type(callback.configcheck) ~= "function" then
		return false
	end

	if callback.handler == nil or
		type(callback.configcheck) ~= "function" then
		return false
	end

	table.insert(mobf.on_step_callbacks,callback)
end


------------------------------------------------------------------------------
-- @function [parent=#mobf] init_on_step_callbacks(entity,now)
--
--! @brief initalize callbacks to be used on step
--! @memberof mobf
--! @private
--
--! @param entity entity to initialize on_step handler
--! @param now current time
-------------------------------------------------------------------------------
function mobf.init_on_step_callbacks(entity,now)
	entity.on_step_hooks = {}

	if #mobf.on_step_callbacks > 32 then
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF BUG!!!: "
			.. #mobf.on_step_callbacks
			.. " incredible high number of onstep callbacks registred!")
	end

	dbg_mobf.mobf_core_lvl2("MOBF: initializing " .. #mobf.on_step_callbacks
		..  " on_step callbacks for " .. entity.data.name
		.. " entity=" .. tostring(entity))
	for i = 1, #mobf.on_step_callbacks , 1 do
		if mobf.on_step_callbacks[i].configcheck(entity) then
			dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ") enabling callback "
				.. mobf.on_step_callbacks[i].name)
			table.insert(entity.on_step_hooks,mobf.on_step_callbacks[i].handler)
			if type(mobf.on_step_callbacks[i].init) == "function" then
				dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ")"
					.." executing init function for "
					.. mobf.on_step_callbacks[i].name)
				mobf.on_step_callbacks[i].init(entity,now)
			else
				dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ")"
					.." no init function defined")
			end
		else
			dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ") callback "
				.. mobf.on_step_callbacks[i].name
				.. " disabled due to config check")
		end
	end

end

------------------------------------------------------------------------------
-- @function [parent=#mobf] register_on_rightclick_callback(callback)
--
--! @brief make a new on_rightclick callback known to mobf
--! @memberof mobf
--! @public
--
--! @param callback to make known to mobf
-------------------------------------------------------------------------------
function mobf.register_on_rightclick_callback(callback)

	if callback.configcheck == nil or
		type(callback.configcheck) ~= "function" then
		return false
	end

	if callback.handler == nil or
		type(callback.configcheck) ~= "function" then
		return false
	end

	table.insert(mobf.on_rightclick_callbacks,callback)
end


------------------------------------------------------------------------------
-- @function [parent=#mobf] register_on_punch_callback(callback)
--
--! @brief make a new on_punch callback known to mobf
--! @memberof mobf
--! @public
--
--! @param callback the callback to register in mobf
-------------------------------------------------------------------------------
function mobf.register_on_punch_callback(callback)
	if callback.configcheck == nil or
		type(callback.configcheck) ~= "function" then
		return false
	end

	if callback.handler == nil or
		type(callback.configcheck) ~= "function" then
		return false
	end

	table.insert(mobf.on_punch_callbacks,callback)
end


------------------------------------------------------------------------------
-- @function [parent=#mobf] init_on_punch_callbacks(entity,now)
--
--! @brief initalize callbacks to be used on punch
--! @memberof mobf
--! @private
--
--! @param entity entity to initialize on_punch handler
--! @param now current time
-------------------------------------------------------------------------------
function mobf.init_on_punch_callbacks(entity,now)
	entity.on_punch_hooks = {}

	dbg_mobf.mobf_core_lvl2("MOBF: initializing " .. #mobf.on_punch_callbacks
		..  " on_punch callbacks for " .. entity.data.name
		.. " entity=" .. tostring(entity))
	for i = 1, #mobf.on_punch_callbacks , 1 do
		if mobf.on_punch_callbacks[i].configcheck(entity) and
			type(mobf.on_punch_callbacks[i].handler) == "function" then
			dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ") enabling callback "
				.. mobf.on_punch_callbacks[i].name)
			table.insert(entity.on_punch_hooks,mobf.on_punch_callbacks[i].handler)

			if type(mobf.on_punch_callbacks[i].init) == "function" then
				dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ")"
					.." executing init function for "
					.. mobf.on_punch_callbacks[i].name)
				mobf.on_punch_callbacks[i].init(entity,now)
			else
				dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ")"
					.." no init function defined")
			end
		else
			dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ") callback "
				.. mobf.on_punch_callbacks[i].name
				.. " disabled due to config check")
		end
	end
end

------------------------------------------------------------------------------
-- @function [parent=#mobf] init_on_rightclick_callbacks(entity,now)
--
--! @brief initalize callbacks to be used on punch
--! @memberof mobf
--! @private
--
--! @param entity entity to initialize on_punch handler
--! @param now current time
-------------------------------------------------------------------------------
function mobf.init_on_rightclick_callbacks(entity,now)
	entity.on_rightclick_hooks = {}

	dbg_mobf.mobf_core_lvl2("MOBF: initializing " .. #mobf.on_rightclick_callbacks
		..  " on_rightclick callbacks for " .. entity.data.name
		.. " entity=" .. tostring(entity))
	for i = 1, #mobf.on_rightclick_callbacks , 1 do
		if mobf.on_rightclick_callbacks[i].configcheck(entity) and
			type(mobf.on_rightclick_callbacks[i].handler) == "function" then
			dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ") enabling callback "
				.. mobf.on_rightclick_callbacks[i].name)
			table.insert(entity.on_rightclick_hooks,mobf.on_rightclick_callbacks[i])

			if type(mobf.on_rightclick_callbacks[i].init) == "function" then
				dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ")"
					.. " executing init function for "
					.. mobf.on_rightclick_callbacks[i].name)
				mobf.on_rightclick_callbacks[i].init(entity,now)
			else
				dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ")"
					.. "no init function defined")
			end
		else
			dbg_mobf.mobf_core_lvl2("MOBF:	(" .. i .. ") callback "
				.. mobf.on_rightclick_callbacks[i].name
				.. " disabled due to config check")
		end
	end
end

------------------------------------------------------------------------------
-- @function [parent=#mobf] get_basepos(entity)
--
--! @brief get basepos for an entity
--! @memberof mobf
--! @public
--
--! @param entity entity to fetch basepos
--! @return basepos of mob
-------------------------------------------------------------------------------
function mobf.get_basepos(entity)
	local pos = entity.object:getpos()
	local nodeatpos = minetest.get_node(pos)

	dbg_mobf.mobf_core_helper_lvl3("MOBF: " .. entity.data.name
		.. " Center Position: " .. printpos(pos) .. " is: " .. nodeatpos.name)

	-- if visual height is more than one block the center of base block is
	-- below the entities center
	if (entity.collisionbox[2] < -0.5) then
		pos.y = pos.y + (entity.collisionbox[2] + 0.5)
		dbg_mobf.mobf_core_helper_lvl3("MOBF: collision box lower end: "
			.. entity.collisionbox[2])
	end

	nodeatpos = minetest.get_node(pos)
	dbg_mobf.mobf_core_helper_lvl3("MOBF: Base Position: " .. printpos(pos)
		.. " is: " .. nodeatpos.name)

	return pos
end

------------------------------------------------------------------------------
-- @function [parent=#mobf] mobf_activate_handler(self,staticdata)
--
--! @brief hanlder called for basic mob initialization
--! @memberof mobf
--! @private
--
--! @param self entity to initialize onstep handler
--! @param staticdata data to use for initialization
-------------------------------------------------------------------------------
function mobf.activate_handler(self,staticdata)
	local starttime = mobf_get_time_ms()

	if mobf_step_quota.is_exceeded() then
		--mobf_print("MOBF: step quota exceeded for mob: "..
		--			self.data.name .." (" .. tostring(self) .. ")")
		return
	end
	--do some initial checks
	local pos = self.object:getpos()

	if pos == nil then
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF: mob at nil pos!")
	end

	local current_node = minetest.get_node(pos)

	if current_node == nil then
		mobf_bug_warning(LOGLEVEL_ERROR,
			"MOBF: trying to activate mob in nil node! removing")

		spawning.remove_uninitialized(self,staticdata)
		mobf_step_quota.consume(starttime)
		return
	end

	--restore saved data
	local preserved_data = mobf_deserialize_permanent_entity_data(staticdata)

	local objectlist = minetest.get_objects_inside_radius(pos,0.25)

	local cleaned_objectcount = 0

	for i=1,#objectlist,1 do
		local luaentity = objectlist[i]:get_luaentity()
		if luaentity ~= nil then
			if not luaentity.mobf_spawner and
				luaentity.name ~= "mobf:lifebar" then
				cleaned_objectcount = cleaned_objectcount + 1
			end
		else
			cleaned_objectcount = cleaned_objectcount + 1
		end
	end

	--honor replaced marker
	if (self.replaced ~= true and cleaned_objectcount > 1) or
		cleaned_objectcount > 2 then
		local spawner = "unknown"

		if preserved_data ~= nil and
			preserved_data.spawner ~= nil then
			spawner = preserved_data.spawner
		end

		mobf_bug_warning(LOGLEVEL_WARNING,
			"MOBF: trying to activate mob \"" ..self.data.name ..
			" at " .. printpos(pos) .. " (" .. tostring(self)
			.. ")"..
			"\" within something else!" ..
			" originaly spawned by: " .. spawner ..
			" --> removing")
		for i=1,#objectlist,1 do
			local luaentity = objectlist[i]:get_luaentity()
			if luaentity ~= nil then
				if luaentity.data ~= nil and
					luaentity.data.name ~= nil then
					dbg_mobf.mobf_core_helper_lvl3(
						i .. " LE: " .. luaentity.name .. " (" .. tostring(luaentity) .. ") " ..
						luaentity.data.name .. " " ..
						printpos(objectlist[i]:getpos()))
				else
					dbg_mobf.mobf_core_helper_lvl3(
						i .. " LE: " .. luaentity.name .. " (" .. tostring(luaentity) .. ") " ..
						dump(luaentity))
				end
			else
				dbg_mobf.mobf_core_helper_lvl3(
					i .. " " .. tostring(objectlist[i]) ..
					printpos(objectlist[i]:getpos()))
			end
		end
		spawning.remove_uninitialized(self,staticdata)
		mobf_step_quota.consume(starttime)
		return
	end

	--reset replaced marker
	self.replaced = nil

	if environment.is_media_element(current_node.name,self.environment.media) == false then
		minetest.log(LOGLEVEL_WARNING,"MOBF: trying to activate mob "
			.. self.data.name .. " at invalid position")
		minetest.log(LOGLEVEL_WARNING,"	Activation at: " .. printpos(pos) .. " "
			.. current_node.name .. " --> removing")
		--TODO try to move 1 block up
		spawning.remove_uninitialized(self,staticdata)
		mobf_step_quota.consume(starttime)
		return
	end

	--do initialization of dynamic modules
	local now = mobf_get_current_time()


	spawning.init_dynamic_data(self,now)

	mobf.init_on_step_callbacks(self,now)
	mobf.init_on_punch_callbacks(self,now)

	--initialize ride support
	mobf_ride.init(self)

	--check if this was a replacement mob
	if self.dyndata_delayed ~= nil then
		minetest.log(LOGLEVEL_ERROR,"MOBF: delayed activation for replacement mob."
			.."This shouldn't happen at all but if we can fix it")
		self.dynamic_data = dyndata_delayed.data
		self.object:set_hp(dyndata_delayed.health)
		self.object:setyaw(dyndata_delayed.entity_orientation)
		self.dyndata_delayed = nil
		self.dynamic_data.initialized = true
		mobf_step_quota.consume(starttime)
		return
	end

	if self.dynamic_data.spawning ~= nil then
		if mobf_pos_is_zero(preserved_data.spawnpoint) ~= true then
			self.dynamic_data.spawning.spawnpoint = preserved_data.spawnpoint
		else
			self.dynamic_data.spawning.spawnpoint = mobf_round_pos(pos)
		end
		self.dynamic_data.spawning.player_spawned = preserved_data.playerspawned

		if preserved_data.original_spawntime ~= -1 then
			self.dynamic_data.spawning.original_spawntime = preserved_data.original_spawntime
		end

		if preserved_data.spawner ~= nil then
			minetest.log(LOGLEVEL_INFO,"MOBF: setting spawner to: "
				.. preserved_data.spawner)
			self.dynamic_data.spawning.spawner = preserved_data.spawner
		end

		--only relevant if mob has different states
		if preserved_data.state ~= nil and
			self.dynamic_data.state ~= nil then
			minetest.log(LOGLEVEL_INFO,"MOBF: setting current state to: "
				.. preserved_data.state)
			self.dynamic_data.state.current =
				mob_state.get_state_by_name(self,preserved_data.state)
		end
	end

	self.dynamic_data.custom_persistent = preserved_data.custom_persistent

	local default_state = mob_state.get_state_by_name(self,"default")

	if self.dynamic_data.state.current == nil or
		(self.dynamic_data.state.current.state_mode ~= "auto" and
		self.dynamic_data.state.current.state_mode ~= "user_def" and
		self.dynamic_data.state.current.state_mode ~= nil) or
		(self.dynamic_data.state.current.HANDLER_precondition ~= nil and
			(not self.dynamic_data.state.current.HANDLER_precondition(self,self.dynamic_data.state.current))) then
		self.dynamic_data.state.current = default_state
	end

	--user defined states are locked per definition
	if self.dynamic_data.state.current.state_mode == "user_def" then
		mob_state.lock(self,true)
	end

	dbg_mobf.mobf_core_lvl2("MOBF: " .. self.data.name .. " restoring state: "
								.. self.dynamic_data.state.current.name)

	--initialize move gen
	if self.dynamic_data.state.current.movgen ~= nil then
		dbg_mobf.mobf_core_lvl1(
			"MOBF: setting movegen to: " .. self.dynamic_data.state.current.movgen)
		self.dynamic_data.current_movement_gen =
						getMovementGen(self.dynamic_data.state.current.movgen)
	else
		dbg_mobf.mobf_core_lvl1(
			"MOBF: setting movegen to: " .. default_state.movgen)
		self.dynamic_data.current_movement_gen =
										getMovementGen(default_state.movgen)
	end

	if self.dynamic_data.state.current.animation ~= nil then
		dbg_mobf.mobf_core_lvl1(
			"MOBF: setting animation to: " .. self.dynamic_data.state.current.animation)
		graphics.set_animation(self,self.dynamic_data.state.current.animation)
	else
		dbg_mobf.mobf_core_lvl1(
			"MOBF: setting animation to: " .. dump(default_state.animation))
		graphics.set_animation(self,default_state.animation)
	end

	mobf_assert_backtrace(self.dynamic_data.current_movement_gen ~= nil)

	--initialize movegen entity,current time, permanent data
	self.dynamic_data.current_movement_gen.init_dynamic_data(self,now,preserved_data)

	--call enter state fct
	if self.dynamic_data.state.current.HANDLER_enter_state ~= nil then
		self.dynamic_data.state.current.HANDLER_enter_state(self)
	end

	--initialize armor groups
	if self.data.generic.armor_groups ~= nil then
		self.object:set_armor_groups(self.data.generic.armor_groups)
	end

	--initialize factions
	mobf_factions.setupentity(self,preserved_data.factions)

	--initialize height level
	environment.fix_base_pos(self, self.collisionbox[2] * -1)

	--custom on activate handler
	if (self.data.generic.custom_on_activate_handler ~= nil) then
		self.data.generic.custom_on_activate_handler(self)
	end

	--check may need data present after initialization has completed
	mobf.init_on_rightclick_callbacks(self,now)

	--add lifebar
	if minetest.world_setting_get("mobf_lifebar") then
		self.lifebar = mobf_lifebar.add(self)
		mobf_lifebar.set(self.lifebar,self.object:get_hp()/self.hp_max)
	end

	self.dynamic_data.initialized = true

	if self.dynamic_data.delayed_placement ~= nil then
		self.dynamic_data.spawning.player_spawned =
			self.dynamic_data.delayed_placement.player_spawned

		self.dynamic_data.spawning.spawner =
			self.dynamic_data.delayed_placement.spawner

		if self.dynamic_data.delayed_placement.callback ~= nil then
			self.dynamic_data.delayed_placement.callback(self,
					self.dynamic_data.delayed_placement.placer,
					self.dynamic_data.delayed_placement.pointed_thing)
		end

		self.dynamic_data.delayed_placement = nil
	end
	mobf_step_quota.consume(starttime)
end


------------------------------------------------------------------------------
-- @function [parent=#mobf] init_factions(entityn)
--
--! @brief register mob to factions nod
--! @memberof mobf
--! @private
--
--! @param entity entity to initialize
-------------------------------------------------------------------------------
function mobf.init_factions(entity)

	if not mobf_rtd.factions_available then
		return
	end


end

------------------------------------------------------------------------------
-- @function [parent=#mobf] register_entity(entityname,graphics)
--
--! @brief register an entity
--! @memberof mobf
--! @private
--
--! @param name of entity to add
--! @param graphics graphics to use for entity
--! @param mob data to use
-------------------------------------------------------------------------------
function mobf.register_entity(name, graphics, mob)
	dbg_mobf.mobf_core_lvl1("MOBF: registering new entity: " .. name)
	mobf_print("MOBF: registering new entity: \"" .. name .. "\"")

	mobf_assert_backtrace(environment_list[mob.generic.envid] ~= nil)
	minetest.register_entity(name,
			 {
				physical        = true,
				collisionbox    = graphics.collisionbox,
				visual          = graphics.visual,
				textures        = graphics.textures,
				visual_size     = graphics.visual_size,
				spritediv       = graphics.spritediv,
				mesh            = graphics.mesh,
				mode            = graphics.mode,
				initial_sprite_basepos 	= {x=0, y=0},
				makes_footstep_sound = true,
				automatic_rotate = true,
				groups          = mob.generic.groups,
				hp_max          = mob.generic.base_health,
				stepheight      = mob.generic.stepheight,
				automatic_face_movement_dir = true,



		--	actions to be done by mob on its own
			on_step = function(self, dtime)
				local starttime = mobf_get_time_ms()

				if self.removed == true then
					mobf_bug_warning(LOGLEVEL_ERROR,"MOBF: on_step: "
						.. self.data.name .. " on_step for removed entity???? ("
						.. tostring(self) .. ")")
					mobf_warn_long_fct(starttime,"on_step_total_removed","on_step_total")
					return
				end

				if self.dynamic_data == nil then
					mobf_bug_warning(LOGLEVEL_ERROR,"MOBF: on_step: "
						.. "no dynamic data available!")
					mobf_warn_long_fct(starttime,"on_step_total_no_dyn","on_step_total")
					return
				end

				if (self.dynamic_data.initialized ~= true) then
					if entity_at_loaded_pos(self.object:getpos(),self.data.name) then
						mobf.activate_handler(self,self.dynamic_data.last_static_data)

						--if quota is exceeded activation is delayed don't continue
						--until initialization is done
						if self.dynamic_data.initialized ~= true then
							return
						end
						self.dynamic_data.last_static_data = nil
					else
						mobf_warn_long_fct(starttime,"on_step_total_no_init","on_step_total")
						return
					end
				end


				--do special ride callback
				if mobf_ride.on_step_callback(self) then
					mobf_warn_long_fct(starttime,"on_step_total_ride_cb","on_step_total")
					return
				end

				self.current_dtime = self.current_dtime + dtime

				if self.lifebar ~= nil then
					local luaentity = self.lifebar:get_luaentity()
					if luaentity ~= nil then
						luaentity.lifetime = 0
					else
						mobf_bug_warning(LOGLEVEL_ERROR,"MOBF: on_step: "
						.. "trying to update lifebar but no luaentity present!")
						self.lifebar = nil
					end
				end

				if mobf_step_quota.is_exceeded() then
					return
				end

				local quotatime = mobf_get_time_ms()

				local now = mobf_get_current_time()

				if self.current_dtime < 0.25 then
					mobf_warn_long_fct(starttime,"on_step_total_pre_update","on_step_total")
					mobf_step_quota.consume(quotatime)
					return
				end

				--check lifetime
				if spawning.lifecycle_callback(self,now) == false then
					mobf_warn_long_fct(starttime,"on_step_total_lifecycle","on_step_total")
					mobf_step_quota.consume(quotatime)
					return
				end

				local movestart = mobf_get_time_ms()
				--movement generator
				self.dynamic_data.current_movement_gen.callback(self,now)

				mobf_warn_long_fct(movestart,"on_step_movement","movement")

				if self.on_step_hooks ~= nil then
					if #self.on_step_hooks > 32 then
						mobf_bug_warning(LOGLEVEL_ERROR,"MOBF BUG!!!: "
							.. tostring(self)
							.. " incredible high number of onstep hooks! "
							.. #self.on_step_hooks .. " ohlist: "
							.. tostring(self.on_step_hooks))
					end

					--dynamic modules
					for i = 1, #self.on_step_hooks, 1 do
						local cb_starttime = mobf_get_time_ms()
						--check return value if on_step hook tells us to stop any other processing
						if self.on_step_hooks[i](self,now,self.current_dtime) == false then
							dbg_mobf.mobf_core_lvl1("MOBF: on_step: " .. self.data.name
								.. " aborting callback processing entity=" .. tostring(self))
							break
						end
						mobf_warn_long_fct(cb_starttime,"callback_os_" .. self.data.name .. "_" .. i,"callback nr " .. i)
					end
				end

				mobf_warn_long_fct(starttime,"on_step_" .. self.data.name .. "_total","on_step_total")
				self.current_dtime = 0
				mobf_step_quota.consume(quotatime)
				end,

		--player <-> mob interaction
			on_punch = function(self, hitter, time_from_last_punch, tool_capabilities, dir)
				local starttime = mobf_get_time_ms()
				local now = mobf_get_current_time()

				if self.dynamic_data.initialized == false then
					return
				end

				for i = 1, #self.on_punch_hooks, 1 do
					if self.on_punch_hooks[i](self,hitter,now,
							time_from_last_punch, tool_capabilities, dir) then
						mobf_warn_long_fct(starttime,"onpunch_total","onpunch_total")
						return
					end
					mobf_warn_long_fct(starttime,"callback nr " .. i,
						"callback_op_".. self.data.name .. "_" .. i)
				end
				mobf_warn_long_fct(starttime,"onpunch_total","onpunch_total")
				end,

		--rightclick handler
			on_rightclick = mobf.rightclick_handler,

		--do basic mob initialization on activation
			on_activate = function(self,staticdata)
					local starttime = mobf_get_time_ms()
					self.dynamic_data = {}
					self.dynamic_data.initialized = false

					--check for replace in progress marker and transfer to entity
					if spawning.replacing_NOW then
						self.replaced = true
					end

					--make sure entity is in loaded area at initialization
					local pos = self.object:getpos()

					if pos ~= nil and
						entity_at_loaded_pos(pos,self.data.name) then
						mobf.activate_handler(self,staticdata)
					end

					if self.dynamic_data.initialized ~= true then
						minetest.log(LOGLEVEL_INFO,
							"MOBF: delaying activation")
						if self.dynamic_data.last_static_data == nil then
							self.dynamic_data.last_static_data = staticdata
						end
					end
					mobf_warn_long_fct(starttime,"onactivate_total_" .. self.data.name,"onactivate_total")
				end,

			getbasepos       = mobf.get_basepos,
			is_on_ground     = function(entity)

				local basepos = entity.getbasepos(entity)
				local posbelow = { x=basepos.x, y=basepos.y-1,z=basepos.z}

				for dx=-1,1 do
				for dz=-1,1 do
					local fp0 = posbelow
					local fp = { x= posbelow.x + (0.5*dx),
								  y= posbelow.y,
								  z= posbelow.z + (0.5*dz) }
					local n = minetest.get_node(fp)
					if not mobf_is_walkable(n) then
						return true
					end
				end
				end

				return false
				end,

		--prepare permanent data
			get_staticdata = function(self)
				return mobf_serialize_permanent_entity_data(self)
				end,

		--custom variables for each mob
			data                    = mob,
			environment             = environment_list[mob.generic.envid],
			current_dtime           = 0,
			}
		)
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf] rightclick_handler(entity,clicker)
--
--! @brief handle rightclick of mob
--! @memberof mobf
--! @private
--
--! @param entity
--! @param clicker
--
--! @return true/false if handled or not
-------------------------------------------------------------------------------
function mobf.rightclick_handler(entity,clicker)
	local starttime = mobf_get_time_ms()

	if entity.dynamic_data.initialized == false then
		return
	end

	if #entity.on_rightclick_hooks > 1 then

		--get rightclick storage id
		local storage_id = mobf_global_data_store(entity)
		local y_pos = 0.25
		local buttons = ""

		local playername = clicker:get_player_name()

		for i = 1, #entity.on_rightclick_hooks, 1 do
			if entity.on_rightclick_hooks[i].privs == nil or
				minetest.check_player_privs(playername,
					entity.on_rightclick_hooks[i].privs) or
				minetest.is_singleplayer() then

				local callback_storage_id =
					mobf_global_data_store(entity.on_rightclick_hooks[i].handler)
				buttons = buttons .. "button_exit[0," .. y_pos .. ";2.5,0.5;" ..
					"mobfrightclick_" .. storage_id .. "_" ..
					callback_storage_id .. ";"

					if type(entity.on_rightclick_hooks[i].visiblename) == "function" then
						buttons = buttons ..
							entity.on_rightclick_hooks[i].visiblename(entity) .. "]"
					else
						buttons = buttons ..
							entity.on_rightclick_hooks[i].visiblename .. "]"
					end

				y_pos = y_pos + 0.75
			end
		end

		local y_size = y_pos
		local formspec = "size[2.5," .. y_size .. "]" ..
				buttons

		if playername ~= nil then
			--TODO start form close timer
			minetest.show_formspec(playername,"mobf_rightclick:main",formspec)
		end
		return true
	end

	if #entity.on_rightclick_hooks == 1 then
		entity.on_rightclick_hooks[1].handler(entity,clicker)
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf] rightclick_button_handler(player,formname,fields)
--
--! @brief handle button clicks as result of rightclick of mob
--! @memberof mobf
--! @private
--
--! @param player issuer of rightclick
--! @param formname name of form that has been clicked
--! @param fields fields passed to form
--
--! @return true/false if handled or not
-------------------------------------------------------------------------------
function mobf.rightclick_button_handler(player, formname, fields)

	if formname == "mobf_rightclick:main" then
		for k,v in pairs(fields) do
			local parts = string.split(k,"_")

			if parts[1] == "mobfrightclick" then
				local entity_store_id = parts[2]
				local callback_store_id = parts[3]

				dbg_mobf.mobf_core_lvl1("MOBF: rightclick button handler got: "
						.. dump(fields) .. " parted to: " .. dump(parts))

				local entity = mobf_global_data_get(entity_store_id)
				local callback = mobf_global_data_get(callback_store_id)

				if entity ~= nil and
					callback ~= nil then
					callback(entity,player)
				else
					dbg_mobf.mobf_core_lvl1("MOBF: unable to do callback: "
						.. dump(entity) .. " " .. dump(callback))
				end
			end
		end
		return true
	end
	return false
end



-------------------------------------------------------------------------------
-- @function [parent=#mobf] register_mob_item(mob)
--
--! @brief add mob item for catchable mobs
--! @memberof mobf
--! @private
--
--! @param name name of mob
--! @param modname name of mod mob is defined in
--! @param description description to use for mob
-------------------------------------------------------------------------------
function mobf.register_mob_item(name,modname,description)
	minetest.register_craftitem(modname..":"..name, {
		description = description,
		image = modname.."_"..name.."_item.png",
		on_place = function(item, placer, pointed_thing)
			if pointed_thing.type == "node" then
				local pos = pointed_thing.above

				local entity =
					spawning.spawn_and_check(modname..":"..name,pos,"item_spawner")

				if entity ~= nil then

					if entity.dynamic_data.spawning ~= nil then
						entity.dynamic_data.spawning.player_spawned = true

						if placer:is_player(placer) then
							minetest.log(LOGLEVEL_INFO,"MOBF: mob placed by "
								.. placer:get_player_name(placer))
							entity.dynamic_data.spawning.spawner =
								placer:get_player_name(placer)
						end

						if entity.data.generic.custom_on_place_handler ~= nil then
							entity.data.generic.custom_on_place_handler(entity,
															placer, pointed_thing)
						end
					else
						entity.dynamic_data.delayed_placement =  {
							player_spawned = true,
							spawner = placer:get_player_name(placer),
							placer = placer,
							pointed_thing = pointed_thing,
							calback = entity.data.generic.custom_on_place_handler
							}
					end

					item:take_item()
				end
				return item
				end
			end
		})
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf] blacklist_handling(mob)
--
--! @brief add mob item for catchable mobs
--! @memberof mobf
--! @public
--
--! @param mob
-------------------------------------------------------------------------------
function mobf.blacklisthandling(mob)
	local blacklisted = minetest.registered_entities[mob.modname.. ":"..mob.name]


	local on_activate_fct = nil

	--remove unknown animal objects
	if minetest.world_setting_get("mobf_delete_disabled_mobs") then
		on_activate_fct = function(self,staticdata)
				self.object:remove()
			end

		--cleanup spawners too
		if minetest.registered_entities[mob.modname.. ":"..mob.name] == nil and
			environment_list[mob.generic.envid] ~= nil and
			mobf_spawn_algorithms[mob.spawning.algorithm] ~= nil and
			type(mobf_spawn_algorithms[mob.spawning.algorithm].register_cleanup)
															== "function" then

			mobf_spawn_algorithms[mob.spawning.algorithm].register_cleanup(mob.modname.. ":" .. mob.name)

			if mob.spawning.algorithm_secondary ~= nil and
				type(mobf_spawn_algorithms[mob.spawning.algorithm_secondary].initialize_cleanup) == "function" then
					mobf_spawn_algorithms[mob.spawning.algorithm_secondary].initialize_cleanup(mob.modname.. ":" .. mob.name)
			end
		end
	else
		on_activate_fct = function(self,staticdata)
				self.object:setacceleration({x=0,y=0,z=0})
				self.object:setvelocity({x=0,y=0,z=0})
			end
	end

	if minetest.registered_entities[mob.modname.. ":"..mob.name] == nil then

		--cleanup mob entities
		minetest.register_entity(mob.modname.. ":"..mob.name,
			{
				on_activate = on_activate_fct
			})
	end


	if blacklisted == nil then
		minetest.log(LOGLEVEL_INFO,"MOBF: " .. mob.modname..
			":"..mob.name .. " was blacklisted")
	else
		minetest.log(LOGLEVEL_ERROR,"MOBF: " .. mob.modname..
			":"..mob.name .. " already known not registering mob with same name!")
	end
end