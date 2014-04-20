-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file lifebar.lua
--! @brief mobf_lifebar implementation
--! @copyright Sapier
--! @author Sapier
--! @date 2013-02-14
--
--! @defgroup mobf_lifebar
--! @brief lifebar implements a visible lifebar showing health of a mob abov
--!        its head
--! @ingroup framework_int
--! @{
-- Contact: sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(mobf_lifebar == nil)
--! @class mobf_lifebar
--! @brief a simple lifebar implementation
--!@}
mobf_lifebar = {}

-------------------------------------------------------------------------------
-- @function [parent=#mobf_lifebar] init()
--
--! @brief register lifebar entity
--! @memberof mobf_lifebar
-------------------------------------------------------------------------------
function mobf_lifebar.init()
	minetest.register_entity(":mobf:lifebar",
		{
			physical        = false,
			collisionbox    = { 0,0,0,0,0,0 },
			visual          = "sprite",
			textures        = { "mobf_lb_64.png" },
			visual_size     = {x=1,y=0.2},
			groups = { immortal=1, },
			is_visible = true,
			initial_sprite_basepos = {x=0, y=0},

			lifetime = 0,
			initialized = false,

			on_step = function (self,dtime)
					self.lifetime = self.lifetime + dtime
					if not self.initialized then

						if self.lifetime > 1 then
							dbg_mobf.lifebar_lvl3("MOBF: lifebar not attached deleting")
							self.object:remove()
						end
					end

					--parent will reset lifetime while it's active
					if self.lifetime > 5 then
						self.object:remove()
					end
				end

		})
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_lifebar] add(entity)
--
--! @brief add a lifebat to an entity
--! @memberof mobf_lifebar
--
--! @param entity entity to add lifebar
--
--! @return reference to lifebar added
-------------------------------------------------------------------------------
function mobf_lifebar.add(entity)
	local pos = entity.object:getpos()
	local BS = 10

	local lifebar_offset = (MAX(entity.collisionbox[4]-entity.collisionbox[1],
								entity.collisionbox[6]-entity.collisionbox[3]) / 0.5) * 0.4
	lifebar_offset = lifebar_offset * lifebar_offset

	pos.y = pos.y + entity.collisionbox[5] + lifebar_offset

	local lifebar = minetest.add_entity(pos,"mobf:lifebar")

	if lifebar ~= nil then

		lifebar:set_attach(entity.object,"",{x=0,y=(entity.collisionbox[5] + 0.1) * BS,z=0},{x=0,y=-90,z=0})

		local luaentity = lifebar:get_luaentity()
		if luaentity ~= nil then
			dbg_mobf.lifebar_lvl3("MOBF: marking lifebar as initialized")
			luaentity.initialized = true
		else
			dbg_mobf.lifebar_lvl3("MOBF: unable to create lifebar entity")
		end
	end

	return lifebar
end


-------------------------------------------------------------------------------
-- @function [parent=#mobf_lifebar] del(lifebar)
--
--! @brief delete a lifebar
--! @memberof mobf_lifebar
--
--! @param lifebar lifebar do telete
-------------------------------------------------------------------------------
function mobf_lifebar.del(lifebar)
	if lifebar ~= nil then
		lifebar:set_detach()
		lifebar:remove()
	end
end

-------------------------------------------------------------------------------
-- name: set(lifebar,value)
--
--! @brief set value of a lifebar
--! @memberof mobf_lifebar
--! @private
--
--! @param lifebar lifebar do update
--! @param value (0-1) value of lifebar
-------------------------------------------------------------------------------
function mobf_lifebar.set(lifebar,value)
	if lifebar ~= nil then
		local modifiername = mobf_lifebar.get_imagename(value)
		dbg_mobf.lifebar_lvl2("MOBF: got modifier " .. modifiername .. " for value " .. value)
		lifebar:settexturemod(modifiername)
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_lifebar] get_imagename(value)
--
--! @brief calculate imagename from value
--! @memberof mobf_lifebar
--! @private
--
--! @param value to get image for
-------------------------------------------------------------------------------
function mobf_lifebar.get_imagename(value)

	local number = math.floor((value*32) +0.5)

	dbg_mobf.lifebar_lvl2("MOBF: calculated number: " .. number )

	if number < 5 then
		return "^mobf_lb_0" .. number * 2 .. ".png"
	else
		return "^mobf_lb_" .. number * 2 .. ".png"
	end
end