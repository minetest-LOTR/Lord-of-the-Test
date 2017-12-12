-- An inventorycube function that generates from a tiles table!
local function invcube(tiles)
	local top = tiles[1]
	local left = tiles[3] or tiles[2] or tiles[1]
	local right = tiles[5] or tiles[4] or tiles[3] or tiles[2] or tiles[1]
	-- For dirt with grasses...
	if type(left) == "table" then
		left = left.name
	end
	if type(right) == "table" then
		right = right.name
	end
	return minetest.inventorycube(top, left, right)
end

local wields = {}

local c = 0
minetest.register_globalstep(function(dtime)
	c = c + dtime
	if c > 4.5 then
		c = 0
		local t = minetest.get_us_time()
		for _, player in pairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			local textures = lottplayer.textures[name]
			if not textures then
				return
			end
			local item_name = player:get_wielded_item():get_name()
			local item = minetest.registered_items[item_name]
			if wields[name] ~= item_name then
				wields[name] = item_name
				if not item or item_name == "" then
					textures[4] = "blank.png"
				elseif item.wield_image ~= "" then
					textures[4] = item.wield_image
				elseif item.inventory_image ~= "" then
					textures[4] = item.inventory_image
				elseif item.tiles then
					if type(item.tiles) ~= "table" then
						return
					end
					textures[4] = invcube(item.tiles)
				else
					textures[4] = "blank.png"
				end
				player:set_properties({textures = textures})
			end
		end
		--print("Took " .. minetest.get_us_time() - t  .. " us")
	end
end)
