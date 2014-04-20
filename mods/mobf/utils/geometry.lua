-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file geometry.lua
--! @brief generic functions used in many different places
--! @copyright Sapier
--! @author Sapier
--! @date 2013-02-04
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @defgroup gen_func Generic functions
--! @brief functions for various tasks
--! @ingroup framework_int
--! @{

-------------------------------------------------------------------------------
-- name: mobf_calc_distance(pos1,pos2)
--
--! @brief calculate 3d distance between to points
--
--! @param pos1 first position
--! @param pos2 second position
--! @retval scalar value, distance
-------------------------------------------------------------------------------
function mobf_calc_distance(pos1,pos2)
	mobf_assert_backtrace(pos1 ~= nil)
	mobf_assert_backtrace(pos2 ~= nil)

	return math.sqrt( 	math.pow(pos1.x-pos2.x,2) +
				math.pow(pos1.y-pos2.y,2) +
				math.pow(pos1.z-pos2.z,2))
end

-------------------------------------------------------------------------------
-- name: mobf_calc_distance_2d(pos1,pos2)
--
--! @brief calculate 2d distance between to points
--
--! @param pos1 target position
--! @param pos2 start position
--! @return scalar value, distance
-------------------------------------------------------------------------------
function mobf_calc_distance_2d(pos1,pos2)
	return math.sqrt( math.pow(pos1.x-pos2.x,2) +
				math.pow(pos1.z-pos2.z,2))
end

-------------------------------------------------------------------------------
-- name: mobf_calc_direction(pos1,pos2)
--
--! @brief calculate direction angles from pos2 to pos1
--
--! @param start starting position
--! @param destination end position
--! @return anglexz,anglexy
-------------------------------------------------------------------------------
function mobf_calc_direction(start,destination)
	mobf_assert_backtrace(start ~= nil)
	mobf_assert_backtrace(destination ~= nil)

	local xdelta = destination.x - start.x
	local ydelta = destination.y - start.y
	local zdelta = destination.z - start.z

	local distance = math.sqrt(
							math.pow(xdelta,2) +
							math.pow(ydelta,2) +
							math.pow(zdelta,2)
							)

	local anglexz = math.atan2(zdelta,xdelta)
	local anglexy = math.acos(ydelta/distance)
	return anglexz,anglexy
end

-------------------------------------------------------------------------------
-- name: mobf_calc_scalar_speed(speedx,speedz)
--
--! @brief calculate scalar speed
--
--! @param speedx speed in direction x
--! @param speedz speed in direction z
--
--! @return scalar speed value
-------------------------------------------------------------------------------
function mobf_calc_scalar_speed(speedx,speedz)
	return math.sqrt(math.pow(speedx,2)+
	                          math.pow(speedz,2))
end

-------------------------------------------------------------------------------
-- name: mobf_calc_vector_components(dir_radians,absolute_speed)
--
--! @brief calculate calculate x and z components of a directed speed
--
--! @param dir_radians direction of movement radians
--! @param absolute_speed speed in direction
--
--! @return {x,z}
-------------------------------------------------------------------------------
function mobf_calc_vector_components(dir_radians,absolute_speed)

	local retval = {x=0,z=0}

	retval.x = absolute_speed * math.cos(dir_radians)
	retval.z = absolute_speed * math.sin(dir_radians)

	return retval
end

-------------------------------------------------------------------------------
-- name: mobf_calc_vector_components_3d(xzplane_radians,xy_plane_radians,absolute_speed)
--
--! @brief calculate calculate x and z components of a directed speed
--
--! @param xz_plane_radians direction of movement within x-z plane radians
--! @param xy_plane_radians direction of movement within x-y plane radians
--! @param absolute_speed speed in direction
--
--! @return {x,z}
-------------------------------------------------------------------------------
function mobf_calc_vector_components_3d(xz_plane_radians,xy_plane_radians,absolute_speed)

	local retval = {x=0,z=0,y=0}

	retval.x= absolute_speed * math.sin(xy_plane_radians) * math.cos(xz_plane_radians)
	retval.z= absolute_speed * math.sin(xy_plane_radians) * math.sin(xz_plane_radians)
	retval.y= absolute_speed * math.cos(xy_plane_radians)

	return retval
end

-------------------------------------------------------------------------------
-- name: mobf_get_direction(pos1,pos2)
--
--! @brief get normalized direction from pos1 to pos2
--
--! @param pos1 source point
--! @param pos2 destination point
--! @return xyz direction
-------------------------------------------------------------------------------
function mobf_get_direction(pos1,pos2)

	local x_raw = pos2.x -pos1.x
	local y_raw = pos2.y -pos1.y
	local z_raw = pos2.z -pos1.z


	local x_abs = math.abs(x_raw)
	local y_abs = math.abs(y_raw)
	local z_abs = math.abs(z_raw)

	if 	x_abs >= y_abs and
		x_abs >= z_abs then

		y_raw = y_raw * (1/x_abs)
		z_raw = z_raw * (1/x_abs)

		x_raw = x_raw/x_abs

	end

	if 	y_abs >= x_abs and
		y_abs >= z_abs then


		x_raw = x_raw * (1/y_abs)
		z_raw = z_raw * (1/y_abs)

		y_raw = y_raw/y_abs

	end

	if 	z_abs >= y_abs and
		z_abs >= x_abs then

		x_raw = x_raw * (1/z_abs)
		y_raw = y_raw * (1/z_abs)

		z_raw = z_raw/z_abs

	end

	return {x=x_raw,y=y_raw,z=z_raw}

end

-------------------------------------------------------------------------------
-- name: mobf_calc_yaw(x,z)
--
--! @brief calculate radians value of a 2 dimendional vector
--
--! @param x vector component 1
--! @param z vector component 2
--
--! @return radians value
-------------------------------------------------------------------------------
function mobf_calc_yaw(x,z)
	local direction = math.atan2(z,x)

	while direction < 0 do
		direction = direction + (2* math.pi)
	end

	while direction > (2*math.pi) do
		direction = direction - (2* math.pi)
	end

	return direction
end

-------------------------------------------------------------------------------
-- name: mobf_assert_backtrace(value)
--
--! @brief assert in case value is false
--
--! @param heightdiff height difference between shooter and target
--! @param time time to reach target
--! @param acceleration acceleration set for object
--
--! @return y-velocity at start
-------------------------------------------------------------------------------
function mobf_balistic_start_speed(heightdiff,time,acceleration)
	mobf_assert_backtrace(heightdiff ~= nil)
	mobf_assert_backtrace(time ~= nil)
	mobf_assert_backtrace(acceleration ~= nil)

	return (heightdiff - (acceleration/2) * (time*time)) / time
end

-------------------------------------------------------------------------------
-- name: mobf_calc_travel_time(distance,velocity,acceleration)
--
--! @brief assert in case value is false
--
--! @param distance distance to target
--! @param velocity to start with
--! @param acceleration acceleratio to use
--
--! @return time to target
-------------------------------------------------------------------------------
function mobf_calc_travel_time(distance,velocity,acceleration)
	mobf_assert_backtrace(distance ~= nil)
	mobf_assert_backtrace(velocity ~= nil)
	mobf_assert_backtrace(acceleration ~= nil)

	if acceleration == 0 then
		--print("no accel shortcut time calculation")
		return distance/velocity
	end

	local a = acceleration/2
	local b = velocity
	local c = -distance

	--print("a=" .. a .. " b=" .. b .. " c=" .. c)

	local det = b*b - 4*a*c

	--print("det=" .. det)

	if det < 0 then
		return nil
	end

	local ret1 = (-b + math.sqrt(det))/(2*a)
	local ret2 = (-b - math.sqrt(det))/(2*a)

	--print("x1=" .. ret1 .. " x2=" .. ret2)

	if ret1 > 0 then
		return ret1
	end

	return ret2
end

-------------------------------------------------------------------------------
-- name: mobf_same_quadrant(x1,z1,x2,z2)
--
--! @brief check if two points are in same quadrant
--
--! @param x1 x of point1
--! @param z1 z of point1
--! @param x2 x of point2
--! @param z2 z of point2
--
--! @return true/false
-------------------------------------------------------------------------------
function mobf_same_quadrant(x1,z1,x2,z2)

	if x1 > 0 and x2 < 0 or
		x1 < 0 and x2 >0 then
			return false
	end

	if z1 > 0 and z2 < 0 or
		z1 < 0 and z2 >0 then
			return false
	end

	return true

end


-------------------------------------------------------------------------------
-- name: mobf_gauss(center)
--
--! @brief calc random value based uppon gauss distribution around a value
--
--! @param center center value for distribution
--! @param max_deviation maximum deviation from center
--
--! @return gauss randomized value
-------------------------------------------------------------------------------
function mobf_gauss(center,max_deviation)

	local u1 = 2 * math.random() -1
	local u2 = 2 * math.random() -1

	local q = u1*u1 + u2*u2

	local maxtries = 0

	while (q == 0 or q >= 1) and maxtries < 10 do
		u1 = math.random()
		u2 = math.random() * -1
		q = u1*u1 + u2*u2

		maxtries = maxtries +1
	end

	--abort random generation
	if maxtries >= 10 then
		return center
	end

	local p = math.sqrt( (-2*math.log(q))/q )

	--calculate normalized value of max deviation
	if math.random() < 0.5 then
		retval = center + ( u1*p * (center*max_deviation))
	else
		retval = center + ( u2*p * (center*max_deviation))
	end

	return retval
end
--!@}