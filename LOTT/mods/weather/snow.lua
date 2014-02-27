-- Snow
minetest.register_globalstep(function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		local ppos = player:getpos()
		local strength = get_snow(ppos)
--print("p he=".. minetest.get_heat(ppos).." hu=".. minetest.get_humidity(ppos) .. " s=" .. strength)
		if strength > 0 then
		-- Make sure player is not in a cave/house...
		if minetest.env:get_node_light(ppos, 0.5) ~= 15 then return end

		local minp = addvectors(ppos, {x=-9, y=7, z=-9})
		local maxp = addvectors(ppos, {x= 9, y=7, z= 9})

		local minp_deep = addvectors(ppos, {x=-10, y=3.2, z=-10})
		local maxp_deep = addvectors(ppos, {x= 10, y=2.6, z= 10})

		local vel = {x=0, y=   -0.5, z=0}
		local acc = {x=0, y=   -0.5, z=0}

		minetest.add_particlespawner(5, 0.5,
			minp, maxp,
			vel, vel,
			acc, acc,
			5, 5,
			25, 25,
			false, "weather_snow.png", player:get_player_name())

		minetest.add_particlespawner(4, 0.5,
			minp_deep, maxp_deep,
			vel, vel,
			acc, acc,
			4, 4,
			25, 25,
			false, "weather_snow.png", player:get_player_name())
		end
	end
end)

local snow_box =
{
	type  = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
}


-- -[[ Enable this section if you have a very fast PC
minetest.register_abm({
	nodenames = {"group:crumbly", "group:snappy", "group:cracky", "group:choppy", "group:melts"},
	neighbors = {"air"},
	interval = 10.0, 
	chance = 80,
	--interval = 1.0, 
	--chance = 5,
	action = function (pos, node, active_object_count, active_object_count_wider)
		local amount = get_snow(pos)
		if amount == 0 then return end
		if minetest.registered_nodes[node.name].drawtype ~= "normal"
			and minetest.registered_nodes[node.name].drawtype ~= "nodebox"
			and minetest.registered_nodes[node.name].drawtype ~= "allfaces_optional" then return end
		local np = addvectors(pos, {x=0, y=1, z=0})
		if minetest.env:get_node_light(np, 0.5) ~= 15 then return end
		local addsnow = 1
		if minetest.env:get_node(pos).name == "default:snow" then
			if minetest.env:add_node_level(pos, 4) > 0 then
				minetest.env:add_node(pos, {name="default:ice"})
			else
				addsnow = 0
			end
		end
		if addsnow > 0 and minetest.env:get_node(np).name == "air" then
			minetest.env:add_node(np, {name="snow"})
			minetest.env:add_node_level(np)
		end
	end
})
--]]
