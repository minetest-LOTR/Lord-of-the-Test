cemen = {}

local cemen_list = {
    { "Angmar Fort", "angmarfort"},
    { "Gondor Fort", "gondorfort"},
    { "Rohan Fort", "rohanfort"},
    { "Orc Fort", "orcfort"},
    { "Mallorn House", "mallornhouse"},
    { "Mirkwood House", "mirkhouse"},
    { "Hobbit Hole", "hobbithole"},
}

for i in ipairs(cemen_list) do
    local builddesc = cemen_list[i][1]
    local build = cemen_list[i][2]

minetest.register_node("cemen:"..build, {
        description = builddesc,
        tiles = {"cemen_air.png"},
	   is_ground_content = true,
	   groups = {not_in_creative_inventory =1},
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.above then
                local file = io.open(minetest.get_modpath("cemen").."/schems/"..build..".we")
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
    nodenames = {"cemen:mallornhouse"},
    	interval = 1,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("cemen").."/schems/mallornhouse.we")
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
    nodenames = {"cemen:angmarfort"},
    	interval = 5,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("cemen").."/schems/angmarfort.we")
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
    nodenames = {"cemen:gondorfort"},
    	interval = 1,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("cemen").."/schems/gondorfort.we")
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
    nodenames = {"cemen:hobbithole"},
    	interval = 1,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("cemen").."/schems/hobbithole.we")
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
    nodenames = {"cemen:orcfort"},
    	interval = 1,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("cemen").."/schems/orcfort.we")
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
    nodenames = {"cemen:mirkhouse"},
    	interval = 5,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("cemen").."/schems/mirkhouse.we")
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
    nodenames = {"cemen:rohanfort"},
    	interval = 1,
	chance = 1,
     action = function(pos)
          if pos then
               local file = io.open(minetest.get_modpath("cemen").."/schems/rohanfort.we")
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
	nodenames = {"cemen:gondorfort","cemen:hobbithole","cemen:orcfort","cemen:rohanfort","cemen:mallornhouse"},
	interval = 4,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:remove_node(pos)
	end,
})

minetest.register_abm({
	nodenames = {"cemen:angmarfort","cemen:mirkhouse"},
	interval = 8,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:remove_node(pos)
	end,
})