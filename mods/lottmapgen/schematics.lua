lottmapgen = {}

local lottmapgen_list = {
    { "Angmar Fort", "angmarfort"},
    { "Gondor Fort", "gondorfort"},
    { "Rohan Fort", "rohanfort"},
    { "Orc Fort", "orcfort"},
    { "Mallorn House", "mallornhouse"},
    { "Mirkwood House", "mirkhouse"},
    { "Hobbit Hole", "hobbithole"},
}

for i in ipairs(lottmapgen_list) do
    local builddesc = lottmapgen_list[i][1]
    local build = lottmapgen_list[i][2]

minetest.register_node("lottmapgen:"..build, {
        description = builddesc,
        tiles = {"lottother_air.png"},
	   is_ground_content = true,
	   groups = {not_in_creative_inventory =1},
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
          end
     end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:gondorfort","lottmapgen:hobbithole","lottmapgen:orcfort","lottmapgen:rohanfort","lottmapgen:mallornhouse"},
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