-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file api.lua
--! @brief api functions to be used by other mods
--! @copyright Sapier
--! @author Sapier
--! @date 2012-12-27
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- @function mobf_register_on_death_callback(callback)
--
--! @brief get version of mob framework
--! @ingroup framework_mob
--
--! @param callback callback to register
--! @return true/false
-------------------------------------------------------------------------------
function mobf_register_on_death_callback(callback)
	return fighting.register_on_death_callback(callback)
end

-------------------------------------------------------------------------------
-- @function mobf_get_mob_definition(mobname)
--
--! @brief get COPY of mob definition
--! @ingroup framework_mob
--
--! @return mobf version
-------------------------------------------------------------------------------
function mobf_get_mob_definition(mobname)

	if mobf_rtd.registred_mob_data[mobname] ~= nil then
		local copy = minetest.serialize(mobf_rtd.registred_mob_data[mobname])
		return minetest.deserialize(copy)
	end
	return nil
end

-------------------------------------------------------------------------------
-- @function mobf_get_version()
--
--! @brief get version of mob framework
--! @ingroup framework_mob
--
--! @return mobf version
-------------------------------------------------------------------------------
function mobf_get_version()
	return mobf_version
end

------------------------------------------------------------------------------
-- @function mobf_add_mob(mob)
--
--! @brief register a mob within mob framework
--! @ingroup framework_mob
--
--! @param mob a mob declaration
-------------------------------------------------------------------------------
function mobf_add_mob(mob)

	if mob.name == nil or
		mob.modname == nil then
		minetest.log(LOGLEVEL_ERROR,"MOBF: name and modname are mandatory for ALL mobs!")
		return false
	end

	--check if mob may be added
	if mobf_contains(mobf_rtd.registred_mob,mob.modname.. ":"..mob.name) then
		mobf.blacklisthandling(mob)
		return false
	end

	--if a random drop is specified for this mob register it
	if mob.random_drop ~= nil then
		random_drop.register(mob.random_drop)
	end

	--create default entity
	minetest.log(LOGLEVEL_INFO,"MOBF: adding: " .. mob.name)
	mob_state.prepare_states(mob)

	mobf.register_entity(":" .. mob.modname .. ":"..mob.name,
							graphics.graphics_by_statename(mob,"default"), mob)

	--add compatibility entity to replace old __default entities by new ones
	minetest.log(LOGLEVEL_INFO,"MOBF: registering compatibility entity: >" ..
					":" .. mob.modname .. ":"..mob.name .. "__default" .. "<")
	minetest.register_entity(":" .. mob.modname .. ":"..mob.name .. "__default",
			{
			replacement_name = mob.modname .. ":"..mob.name,
			on_activate = function(self,staticdata)

					local pos = self.object:getpos()

					if pos ~= nil then
						local newobject = minetest.add_entity(pos,self.replacement_name)
						local spawned_entity = mobf_find_entity(newobject)

						if spawned_entity ~= nil then
						spawned_entity.dynamic_data.initialized = false
						spawned_entity.dynamic_data.last_static_data = staticdata
						end
					end
					self.object:remove()
				end,
			})

	mobf.register_mob_item(mob.name,mob.modname,mob.generic.description)

	--check if a movement pattern was specified
	if mobf_rtd.movement_patterns[mob.movement.pattern] == nil then
		minetest.log(LOGLEVEL_WARNING,"MOBF: no movement pattern specified!")
	end

	spawning.register_mob(mob)

	--register factions required by mob
	mobf_factions.setupmob(mob.factions)

	if mob.generic.stepheight == nil then
		mob.generic.stepheight = 0
	end

	--register mob name to internal data structures
	table.insert(mobf_rtd.registred_mob,mob.modname.. ":"..mob.name)
	mobf_rtd.registred_mob_data[mob.modname.. ":"..mob.name] = mob;

	return true
end

------------------------------------------------------------------------------
-- @function mobf_is_known_mob(name)
--
--! @brief check if mob of name is known
--! @ingroup framework_mob
--
--! @param name name to check if it's a mob
--! @return true/false
-------------------------------------------------------------------------------
function mobf_is_known_mob(name)
	for i,val in ipairs(mobf_rtd.registred_mob) do
		if name == val then
			return true
		end
	end

	return false
end

------------------------------------------------------------------------------
-- @function mobf_register_environment(name,environment)
--
--! @brief register an environment to mob framework
--! @ingroup framework_mob
--
--! @param name of environment
--! @param environment specification
--! @return true/false
-------------------------------------------------------------------------------
function mobf_register_environment(name,environment)
	return environment.register(name,environment)
end

------------------------------------------------------------------------------
-- @function mobf_probab_movgen_register_pattern(pattern)
--
--! @brief register an movement pattern for probabilistic movement gen
--! @ingroup framework_mob
--
--! @param pattern to register (see pattern specification)
--! @return true/false
-------------------------------------------------------------------------------
function mobf_probab_movgen_register_pattern(pattern)
	return movement_gen.register_pattern(pattern)
end
