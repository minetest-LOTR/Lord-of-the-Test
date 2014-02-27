-- Rain
minetest.register_globalstep(function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		local ppos = player:getpos()
		local strength = get_rain(ppos)
		if strength > 0 then

		-- Make sure player is not in a cave/house...
		if minetest.env:get_node_light(ppos, 0.5) ~= 15 then return end

		local minp = addvectors(ppos, {x=-9, y=7, z=-9})
		local maxp = addvectors(ppos, {x= 9, y=7, z= 9})

		local vel = {x=0, y=   -4, z=0}
		local acc = {x=0, y=-9.81, z=0}

-- only after https://github.com/minetest/minetest/pull/675
		freeminer.add_particlespawner({amount=20, time=0.5,
			minpos=minp, maxpos=maxp,
			minvel=vel, maxvel=vel,
			minacc=acc, maxacc=acc,
			minexptime=0.8, maxexptime=0.8,
			minsize=25, maxsize=25,
			collisiondetection=false, vertical=true, texture="weather_rain.png", player=player:get_player_name()})
		end
--[[ old, pre vertical rain
		minetest.add_particlespawner(25, 0.5,
			minp, maxp,
			vel, vel,
			acc, acc,
			0.8, 0.8,
			25, 25,
			false, "weather_rain.png", player:get_player_name())
		end
]]--
	end
end)

minetest.register_abm({
	nodenames = {"group:crumbly", "group:snappy", "group:cracky", "group:choppy", "group:water"},
	neighbors = {"air"},
	interval = 10.0, 
	chance = 80,
	action = function (pos, node, active_object_count, active_object_count_wider)
		-- todo! chance must depend on rain value
		local amount = get_rain(pos)
		if amount == 0 then return end
		if minetest.registered_nodes[node.name].drawtype ~= "normal"
			and minetest.registered_nodes[node.name].drawtype ~= "nodebox"
			and minetest.registered_nodes[node.name].drawtype ~= "flowingliquid"
			and minetest.registered_nodes[node.name].drawtype ~= "liquid"
			and minetest.registered_nodes[node.name].drawtype ~= "allfaces_optional" then  return end
		local np = addvectors(pos, {x=0, y=1, z=0})
		if minetest.env:get_node_light(np, 0.5) == 15 then
			if minetest.env:get_node(pos).name == "default:water_flowing" then
				minetest.env:add_node_level(pos, 1)
			elseif minetest.env:get_node(np).name == "air" then
				minetest.env:add_node(np, {name="water_flowing"})
				minetest.env:add_node_level(np)
			end
		end
	end
})

-- evaporate
minetest.register_abm({
	nodenames = {"default:water_flowing"},
	neighbors = {"air"},
	interval = 10.0, 
	chance = 10,
	action = function (pos, node, active_object_count, active_object_count_wider)
		-- todo! chance must depend on humidity
		if get_rain(pos) > 0 or minetest.get_humidity(pos) > 90 then return end
		local np = addvectors(pos, {x=0, y=1, z=0})
		--if minetest.env:get_node_light(np, 0.5) == 15 then
		if minetest.env:get_node(np).name == "air" then
			minetest.env:add_node_level(pos, -1)
		end
	end
})
