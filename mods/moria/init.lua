-- Geomoria init.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

geomoria = {}
geomoria.version = "1.0"
geomoria.path = minetest.get_modpath(minetest.get_current_modname())
geomoria.world = minetest.get_worldpath()
geomoria.plans = {}
geomoria.plans_keys = {}
geomoria.geomoria_depth = -1

geomoria.min_x = -31000
geomoria.min_z = -31000
geomoria.max_x = 31000
geomoria.max_z = 31000

-- Dungeon overgeneration puts mossycobble in inappropriate places.
minetest.set_mapgen_setting('mg_flags', "nodungeons", true)

geomoria.generate_ores = minetest.setting_getbool('geomoria_generate_ores')
if geomoria.generate_ores == nil then
  geomoria.generate_ores = false
end

geomoria.add_fissures = minetest.setting_getbool('geomoria_add_fissures')
if geomoria.add_fissures == nil then
  geomoria.add_fissures = true
end

geomoria.cheap_lighting = minetest.setting_getbool('geomoria_cheap_lighting')
if geomoria.cheap_lighting == nil then
  geomoria.cheap_lighting = false
end

geomoria.damage_level = minetest.setting_getbool('geomoria_damage_level')
geomoria.damage_level = (13 - (geomoria.damage_level or 5)) / 10


local treasure_chest = 'default:chest'
if minetest.registered_items['booty:coffer'] then
  treasure_chest = 'booty:coffer'
end
-- Using this old reference will NOT call the hook function.
geomoria.treasure_chest = treasure_chest


-- This can be overridden to do complicated treasure placement.
--  'pos' is the coordinate where a chest would go.
--  'min/max' values are the coordinates of the room or hall.
--  'data' is the mapgen data for that chunk.
--  'area' is the VoxelArea structure for the chunk.
-- The function may return the get_content_id value for a node,
--  which will be placed via voxelmanip.
--
-- If you override this, it might make sense to save the original
--  function and call it, in case someone else overrides it.
--  However, there can be only one return value.
if minetest.registered_items['booty:coffer'] then
  function geomoria.treasure_chest_hook(pos, min_x, max_x, min_z, max_z, data, area, node)
    minetest.after(0, function(pos)
      local n = minetest.get_node_or_nil(pos)
      if not n then
        print('Booty: Failed to place treasure at '..dump(pos))
      elseif n.name ~= 'air' then
        booty.place_chest(pos)
      end
    end, pos)
  end
else
  function geomoria.treasure_chest_hook(pos, min_x, max_x, min_z, max_z, data, area, node)
    return node[treasure_chest]
  end
end


geomoria.default_exits = {
  {act = 'fill', node = 'air', coords = {0, 1, 21, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {0, 1, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {0, 1, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {79, 1, 21, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {79, 1, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {79, 1, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 0, 1}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 0, 1}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 3, 0, 1}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 79, 1}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 79, 1}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 3, 79, 1}},
  {act = 'fill', node = 'air', coords = {0, 1, 51, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {79, 1, 51, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {39, 2, 51, 3, 0, 1}},
  {act = 'fill', node = 'air', coords = {39, 2, 51, 3, 79, 1}},
}


function geomoria.exit_stair(minp, maxp)
  local csize = vector.add(vector.subtract(maxp, minp), 1)
  return (minp.z % (csize.z * 10)) < csize.z and (minp.x % (csize.x * 10)) < csize.x
end


function geomoria.in_range(minp, maxp)
  local avg = (minp.y + maxp.y) / 2

  if geomoria.min_x and geomoria.min_z and geomoria.max_x and geomoria.max_z and (minp.x < geomoria.min_x or minp.z < geomoria.min_z or maxp.x > geomoria.max_x or maxp.z > geomoria.max_z) then
    return
  end

  if avg < (geomoria.geomoria_depth - 1) * 80 - 32 or (not geomoria.exit_stair(minp, maxp) and avg > geomoria.geomoria_depth * 80 - 32) then
    return
  end

  return true
end


if minetest.get_modpath('squaresville') then
  geomoria.clone_node = squaresville.clone_node
  geomoria.node = squaresville.node
  dofile(geomoria.path .. '/geomorph.lua')
else
  -- This table looks up nodes that aren't already stored.
  geomoria.node = setmetatable({}, {
    __index = function(t, k)
      if not (t and k and type(t) == 'table') then
        return
      end

      t[k] = minetest.get_content_id(k)
      return t[k]
    end
  })

  function geomoria.clone_node(name)
    if not (name and type(name) == 'string') then
      return
    end

    local node = minetest.registered_nodes[name]
    local node2 = table.copy(node)
    return node2
  end

  dofile(geomoria.path .. "/mapgen.lua")
end


dofile(geomoria.path .. "/plans.lua")


do
  local node = geomoria.clone_node('default:stone')
  node.walkable = false
  minetest.register_node('geomoria:false_wall', node)

  node = geomoria.clone_node('default:stone_block')
  node.walkable = false
  minetest.register_node('geomoria:false_wall_block', node)

  -- This just prevents ore spawns in the walls.
  node = geomoria.clone_node('default:stone')
  node.drop = 'default:cobble'
  minetest.register_node('geomoria:stone', node)
  node = table.copy(node)
  minetest.register_node('geomoria:stone2', node)

  geomoria.ground_nodes = {}
  local ground_nodes_names = {
    'default:desert_stone',
    'default:dirt',
    'default:dirt_with_dry_grass',
    'default:dirt_with_grass',
    'default:dirt_with_snow',
    'default:sand',
    'default:sandstone',
    'default:stone',
  }
  for _, i in pairs(ground_nodes_names) do
    geomoria.ground_nodes[geomoria.node[i]] = true
  end
end
dofile(geomoria.path .. "/fill_chest.lua")
minetest.register_craftitem("geomoria:gold_pile", {
  description = "Pile of Gold",
  inventory_image = "gold.png",
  group = {
    "not_in_creative_inventory"
  },
  stack_max = 99,
})
