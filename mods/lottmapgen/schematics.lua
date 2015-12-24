lottmapgen = {}

local areas_mod = minetest.get_modpath("areas")
local protect_houses = minetest.setting_getbool("protect_structures") or true

local lottmapgen_list = {
    { "Angmar Fort", "angmarfort"},
    { "Gondor Fort", "gondorfort"},
    { "Rohan Fort", "rohanfort"},
    { "Orc Fort", "orcfort"},
    { "Mallorn House", "mallornhouse"},
    { "Lorien House", "lorienhouse"}, --Different version of "mallornhouse", made by fireuser
    { "Mirkwood House", "mirkhouse"},
    { "Hobbit Hole", "hobbithole"},
}

for i in ipairs(lottmapgen_list) do
    local builddesc = lottmapgen_list[i][1]
    local build = lottmapgen_list[i][2]
    minetest.register_node("lottmapgen:"..build, {
        description = builddesc,
        drawtype = "glasslike",
        walkable = false,
        tiles = {"lottother_air.png"},
        pointable = false,
        sunlight_propagates = true,
        is_ground_content = true,
        groups = {not_in_creative_inventory = 1},
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.above then
                local file = io.open(minetest.get_modpath("lottmapgen").."/schems/"..build..".we")
                local value = file:read("*a")
                file:close()
                local p = pointed_thing.above
                p.x = p.x - 5
                p.z = p.z - 2
                local count = worldedit.deserialize(pointed_thing.above, value)
                itemstack:take_item()
            end
            return itemstack
        end,
    })
end

minetest.register_abm({
    nodenames = {"lottmapgen:lorienhouse"},
    interval = 1,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("lottmapgen").."/schems/lorienhouse.we")
               local value = file:read("*a")
               file:close()
               local p = pos
               p.x = p.x - 5
               p.z = p.z - 2
               local count = worldedit.deserialize(pos, value)
               if areas_mod ~= nil and protect_houses == true then
                    local pos1 = {x = pos.x - 2, y = pos.y - 15, z = pos.z - 2}
                    local pos2 = {x = pos.x + 12, y = pos.y + 45, z = pos.z + 12}
                    areas:add("Elven Guard", "Elven House", pos1, pos2, nil)
                    areas:save()
               end
          end
     end,
})

minetest.register_abm({
    nodenames = {"lottmapgen:mallornhouse"},
    interval = 1,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("lottmapgen").."/schems/mallornhouse.we")
               local value = file:read("*a")
               file:close()
               local p = pos
               p.x = p.x - 5
               p.z = p.z - 2
               local count = worldedit.deserialize(pos, value)
               if areas_mod ~= nil and protect_houses == true then
                    local pos1 = {x = pos.x - 3, y = pos.y - 15, z = pos.z - 3}
                    local pos2 = {x = pos.x + 10, y = pos.y + 35, z = pos.z + 10}
                    areas:add("Elven Guard", "Elven House", pos1, pos2, nil)
                    areas:save()
               end
          end
     end,
})

minetest.register_abm({
    nodenames = {"lottmapgen:angmarfort"},
    	interval = 5,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("lottmapgen").."/schems/angmarfort.we")
               local value = file:read("*a")
               file:close()
               local p = pos
               p.x = p.x - 5
               p.z = p.z - 2
               local count = worldedit.deserialize(pos, value)
               if areas_mod ~= nil and protect_houses == true then
                   local pos1 = {x = pos.x - 4, y = pos.y - 15, z = pos.z - 4}
                   local pos2 = {x = pos.x + 22, y = pos.y + 25, z = pos.z + 22}
                   areas:add("Orc Guard", "Angmar Fort", pos1, pos2, nil)
                   areas:save()
               end
          end
     end,
})

minetest.register_abm({
    nodenames = {"lottmapgen:gondorfort"},
	interval = 1,
	chance = 1,
    action = function(pos)
        if pos then
               local file = io.open(minetest.get_modpath("lottmapgen").."/schems/gondorfort.we")
               local value = file:read("*a")
               file:close()
               local p = pos
               p.x = p.x - 5
               p.z = p.z - 2
               local count = worldedit.deserialize(pos, value)
               if areas_mod ~= nil and protect_houses == true then
                   local pos1 = {x = pos.x + 2, y = pos.y - 15, z = pos.z - 5}
                   local pos2 = {x = pos.x + 23, y = pos.y + 35, z = pos.z + 24}
                   areas:add("Gondor Guard", "Gondor Castle", pos1, pos2, nil)
                   areas:save()
               end
          end
     end,
})

minetest.register_abm({
    nodenames = {"lottmapgen:hobbithole"},
    	interval = 1,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("lottmapgen").."/schems/hobbithole.we")
               local value = file:read("*a")
               file:close()
               local p = pos
               p.x = p.x - 5
               p.z = p.z - 2
               local count = worldedit.deserialize(pos, value)
               if areas_mod ~= nil and protect_houses == true then
                   local pos1 = {x = pos.x, y = pos.y - 15, z = pos.z}
                   local pos2 = {x = pos.x + 30, y = pos.y + 10, z = pos.z + 20}
                   areas:add("Hobbit Family", "Hobbit Hole", pos1, pos2, nil)
                   areas:save()
               end
          end
     end,
})

minetest.register_abm({
    nodenames = {"lottmapgen:orcfort"},
    interval = 1,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("lottmapgen").."/schems/orcfort.we")
               local value = file:read("*a")
               file:close()
               local p = pos
               p.x = p.x - 5
               p.z = p.z - 2
               local count = worldedit.deserialize(pos, value)
               if areas_mod ~= nil and protect_houses == true then
                   local pos1 = {x = pos.x - 4, y = pos.y - 15, z = pos.z - 4}
                   local pos2 = {x = pos.x + 26, y = pos.y + 45, z = pos.z + 26}
                   areas:add("Orc Guard", "Orc Fort", pos1, pos2, nil)
                   areas:save()
               end
          end
     end,
})

minetest.register_abm({
    nodenames = {"lottmapgen:mirkhouse"},
    interval = 5,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("lottmapgen").."/schems/mirkhouse.we")
               local value = file:read("*a")
               file:close()
               local p = pos
               p.x = p.x - 5
               p.z = p.z - 2
               local count = worldedit.deserialize(pos, value)
               if areas_mod ~= nil and protect_houses == true then
                   local pos1 = {x = pos.x - 4, y = pos.y - 15, z = pos.z - 4}
                   local pos2 = {x = pos.x + 15, y = pos.y + 30, z = pos.z + 15}
                   areas:add("Elven Guard", "Elven House", pos1, pos2, nil)
                   areas:save()
               end
          end
     end,
})

minetest.register_abm({
    nodenames = {"lottmapgen:rohanfort"},
    interval = 1,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("lottmapgen").."/schems/rohanfort.we")
               local value = file:read("*a")
               file:close()
               local p = pos
               p.x = p.x - 5
               p.z = p.z - 2
               local count = worldedit.deserialize(pos, value)
               if areas_mod ~= nil and protect_houses == true then
                   local pos1 = {x = pos.x - 4, y = pos.y - 15, z = pos.z - 4}
                   local pos2 = {x = pos.x + 29, y = pos.y + 25, z = pos.z + 29}
                   areas:add("Rohan Guard", "Rohan Fort", pos1, pos2, nil)
                   areas:save()
               end
          end
     end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:gondorfort","lottmapgen:hobbithole","lottmapgen:orcfort","lottmapgen:rohanfort","lottmapgen:mallornhouse","lottmapgen:lorienhouse"},
	interval = 4,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:remove_node(pos)
	end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:angmarfort","lottmapgen:mirkhouse"},
	interval = 8,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:remove_node(pos)
	end,
})
