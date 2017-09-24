-- Geomoria mapgen.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)


local DEBUG
local max_depth = 31000
local geomoria_depth = geomoria.geomoria_depth
local ground_nodes = geomoria.ground_nodes
local math_random = math.random


local data = {}
local p2data = {}


local fissure_noise_map, damage_noise_map
local fissure_noise, damage_noise = {}, {}


local function generate(p_minp, p_maxp, seed)
  if not (p_minp and p_maxp and seed) then
    return
  end

  local minp, maxp = p_minp, p_maxp
  local avg = (minp.y + maxp.y) / 2
  local csize = vector.add(vector.subtract(maxp, minp), 1)

  if not geomoria.in_range(minp, maxp) then
    return
  end

  local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
  if not (vm and emin and emax) then
    return
  end

  vm:get_data(data)
  p2data = vm:get_param2_data()
  local heightmap
  local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})

  if geomoria.exit_stair(minp, maxp) and minp.y < 200 and avg > geomoria_depth * 80 - 32 then
    heightmap = minetest.get_mapgen_object("heightmap")
  end

  if geomoria.add_fissures then
    if not (damage_noise_map and fissure_noise_map) then
      damage_noise_map = minetest.get_perlin_map({offset = 0, scale = 0.5, seed = -6827, spread = {x = 200, y = 200, z = 200}, octaves = 3, persist = 0.8, lacunarity = 2}, csize)
      fissure_noise_map = minetest.get_perlin_map({offset = 0, scale = 1, seed = -8402, spread = {x = 8, y = 64, z = 8}, octaves = 3, persist = 0.5, lacunarity = 2}, csize)

      if not (damage_noise_map and fissure_noise_map) then
        return
      end
    end

    damage_noise = damage_noise_map:get2dMap_flat({x=minp.x, y=minp.z}, damage_noise)
    fissure_noise = fissure_noise_map:get3dMap_flat(minp, fissure_noise)
  end

  local write, wetness = geomoria.geomorph(minp, maxp, data, p2data, area, node, heightmap, seed)

  if not write then
    return
  end

  if not wetness then
    wetness = 0
  end

  if not DEBUG and fissure_noise and not ((minp.y + maxp.y) / 2 > geomoria.geomoria_depth * 80 - 32) then
    local index = 1
    local index2 = 1
    for z = minp.z, maxp.z do
      for y = minp.y, maxp.y do
        local ivm = area:index(minp.x, y, z)
        local taper = 0
        --local taper = math.abs(30 - (y - minp.y)) / 50 - 0.7
        local dy = y - minp.y
        if dy < 20 then
          taper = (20 - dy) / 40
        elseif dy > 59 then
          taper = (dy - 59) / 40
        end

        for x = minp.x, maxp.x do
          local damage = fissure_noise[index] - damage_noise[index2 + x - minp.x] - taper
          if damage > geomoria.damage_level then
            if data[ivm] ~= node['default:water_source'] and data[ivm] ~= node['default:water_source'] then
              data[ivm] = node['air']
            end
          elseif (data[ivm] == node['default:stone'] or data[ivm] == node['default:stone_block']) and damage > geomoria.damage_level - 0.5 then
            if (wetness > 0 and math_random(2) == 1) or (wetness == 0 and math_random(10) == 1) then
              if minetest.registered_items['fun_caves:glowing_fungal_stone'] and math_random(4) == 1 then
                data[ivm] = node['fun_caves:glowing_fungal_stone']
              else
                data[ivm] = node['default:mossycobble']
              end
            else
              data[ivm] = node['default:cobble']
            end
          end

          ivm = ivm + 1
          index = index + 1
        end
      end
      index2 = index2 + csize.x
    end
  end

  if write then
    vm:set_data(data)
    vm:set_param2_data(p2data)

    if DEBUG then
      vm:set_lighting({day = 14, night = 14})
    else
      vm:set_lighting({day = 0, night = 0}, minp, maxp)
      vm:calc_lighting()
    end
    vm:update_liquids()
    vm:write_to_map()
  end
end


if geomoria.path then
  dofile(geomoria.path .. "/geomorph.lua")
end


local function pgenerate(...)
  local status, err = pcall(generate, ...)
  --local status, err = true
  --generate(...)
  if not status then
    print('Geomoria: Could not generate terrain:')
    print(dump(err))
    collectgarbage("collect")
  end
end


minetest.register_on_generated(pgenerate)
