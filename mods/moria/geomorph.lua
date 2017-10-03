-- Geomoria geomorph.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)


--newnode = geomoria.clone_node("air")
--newnode.light_source = 14
--minetest.register_node("geomoria:bright_air", newnode)


local building_stone = 'geomoria:stone'
local building_stone_no_spawn = 'geomoria:stone2'
if geomoria.generate_ores then
  building_stone = 'default:stone'
  building_stone_no_spawn = 'default:stone'
end


geomoria.geomorph = function(minp, maxp, data, p2data, area, node, heightmap, seed)
  if not (minp and maxp and data and p2data and area and node and type(data) == 'table' and type(p2data) == 'table') then
    return
  end

  if minp.y >= 200 then
    return
  end

  local csize = vector.add(vector.subtract(maxp, minp), 1)
  local write
  local wetness = 0

  local avg = (minp.y + maxp.y) / 2
  local out_of_range
  if avg > geomoria.geomoria_depth * 80 - 32 then
    out_of_range = true
  end

  local index = 0
  local index3d = 0

  local bc = {}
  bc.x = math.floor((minp.x + 32) / 8000)
  bc.y = math.floor((minp.y + 32) / 8000)
  bc.z = math.floor((minp.z + 32) / 8000)
  local pr = PcgRandom((seed % 64000) + (bc.x % 100) * 10000 + (bc.y % 100) * 100 + (bc.z % 100))

  local plan_name = geomoria.plans_keys[pr:next(1, #geomoria.plans_keys)]
  local plan = geomoria.plans[plan_name]
  local rot = pr:next(1, 4) - 1

  local exit_stair = geomoria.exit_stair(minp, maxp)
  if out_of_range then
    plan = geomoria.stair_height
    rot = 0
  elseif exit_stair then
    plan = geomoria.stair_base
    rot = 0
  end

  if not plan then
    print('Geomoria: Failed to select a plan.')
  end

  if not out_of_range then
    for _, item in pairs(plan) do
      if item.act == 'fill' or item.act == 'stair' or item.act == 'ladder' or item.act == 'cylinder' or item.act == 'sphere' then
        local coords = item.coords

        if not (coords and item.node and type(coords) == 'table' and type(item.node) == 'string' and #coords == 6) then
          print('Geomoria: Invalid plan')
          print(dump(item))
          return
        end

        local min_x, max_x, min_z, max_z, dy

        if rot == 0 then
          min_x, max_x = coords[1], coords[1] + coords[2] - 1
          min_z, max_z = coords[5], coords[5] + coords[6] - 1
        elseif rot == 1 then
          min_x, max_x = coords[5], coords[5] + coords[6] - 1
          min_z, max_z = csize.x - (coords[1] + coords[2]), csize.x - coords[1] - 1
        elseif rot == 2 then
          min_x, max_x = csize.x - (coords[1] + coords[2]), csize.x - coords[1] - 1
          min_z, max_z = csize.z - (coords[5] + coords[6]), csize.z - coords[5] - 1
        elseif rot == 3 then
          min_x, max_x = csize.z - (coords[5] + coords[6]), csize.z - coords[5] - 1
          min_z, max_z = coords[1], coords[1] + coords[2] - 1
        end

        local min_y = coords[3]
        local max_y = coords[3] + coords[4] - 1
        if item.act == 'stair' then
          max_y = max_y + 4
        end

        for dz = min_z - 2, max_z + 2 do
          for dy = min_y - 2, max_y + 2 do
            for dx = min_x - 2, max_x + 2 do
              if dx >= 0 and dx <= 79 and dy >= 0 and dy <= 79 and dz >= 0 and dz <= 79 then
                local ivm = area:index(minp.x + dx, minp.y + dy, minp.z + dz)
                if dy <= min_y then
                  data[ivm] = node[building_stone]
                else
                  data[ivm] = node[building_stone_no_spawn]
                end
              end
            end
          end
        end
      end
    end
  end

  for _, item in pairs(plan) do
    if item.param then
      if item.param == 'wet' then
        wetness = 1
      elseif item.param == 'dry' then
        wetness = -1
      end
      --elseif item.hook and type(item.hook) == 'function' then
      --  local n, pos = item.hook(item.hook_params)
      --  if type(n) == 'number' and type(pos) == 'table' and type(pos.x) == 'number' and type(pos.y) == 'number' and type(pos.z) == 'number' then
      --    local ivm = area:index(minp.x + pos.x, minp.y + pos.y, minp.z + pos.z)
      --    data[ivm] = node[item.line]
      --  else
      --    print("Geomoria: Could not interpret hook return values")
      --  end
    elseif item.act == 'fill' or item.act == 'stair' or item.act == 'ladder' or item.act == 'cylinder' or item.act == 'sphere' then
      local coords = item.coords
      local p2 = item.param2

      if p2 and item.act == 'ladder' then
        -- 2 X+   3 X-   4 Z+   5 Z-
        local tran = '4253'
        local fp2 = tran:find(tostring(p2)) - 1
        p2 = (fp2 + rot) % 4
        p2 = tonumber(tran:sub(p2 + 1, p2 + 1))
      elseif p2 and p2 < 4 then
        --p2 = math.floor(p2 / 4) * 4 + (p2 + rot) % 4
        p2 = (p2 + rot) % 4
      elseif p2 then
        --
      else
        p2 = nil
      end

      local min_x, max_x, min_z, max_z, dy

      if rot == 0 then
        min_x, max_x = coords[1], coords[1] + coords[2] - 1
        min_z, max_z = coords[5], coords[5] + coords[6] - 1
      elseif rot == 1 then
        min_x, max_x = coords[5], coords[5] + coords[6] - 1
        min_z, max_z = csize.x - (coords[1] + coords[2]), csize.x - coords[1] - 1
      elseif rot == 2 then
        min_x, max_x = csize.x - (coords[1] + coords[2]), csize.x - coords[1] - 1
        min_z, max_z = csize.z - (coords[5] + coords[6]), csize.z - coords[5] - 1
      elseif rot == 3 then
        min_x, max_x = csize.z - (coords[5] + coords[6]), csize.z - coords[5] - 1
        min_z, max_z = coords[1], coords[1] + coords[2] - 1
      end

      if item.act == 'fill' or item.act == 'ladder' then
        if item.line then
          for dz = min_z - 1, max_z + 1 do
            for dy = coords[3] - 1, coords[3] + coords[4] do
              for dx = min_x - 1, max_x + 1 do
                local ivm = area:index(minp.x + dx, minp.y + dy, minp.z + dz)
                data[ivm] = node[item.line]
              end
            end
          end
        end
        if item.floor then
          for dz = min_z - 1, max_z + 1 do
            for dx = min_x - 1, max_x + 1 do
              local ivm = area:index(minp.x + dx, minp.y + coords[3] - 1, minp.z + dz)
              data[ivm] = node[item.floor]
            end
          end
        end

        if geomoria.cheap_lighting and item.node == 'air' then
          if coords[4] < 13 and coords[2] > 10 and coords[6] > 10 then
            for dz = min_z, max_z do
              for dx = min_x, max_x do
                if dx % 8 == 0 and dz % 8 == 0 then
                  local ivm = area:index(minp.x + dx, minp.y + coords[3] + coords[4], minp.z + dz)
                  if data[ivm] == node[building_stone] or data[ivm] == node[building_stone_no_spawn] or data[ivm] == node['default:stone_block'] then
                    data[ivm] = node['default:meselamp']
                  end
                end
              end
            end
          else
            local alt = minp.y + coords[3] + math.floor(coords[4] / 2)
            for dz = min_z - 1, max_z + 1, max_z - min_z + 2 do
              for dx = min_x, max_x do
                if dx % 10 == 0 then
                  local ivm = area:index(minp.x + dx, alt, minp.z + dz)
                  if data[ivm] == node[building_stone] or data[ivm] == node[building_stone_no_spawn] or data[ivm] == node['default:stone_block'] then
                    data[ivm] = node['default:meselamp']
                  end
                end
              end
            end
            for dz = min_z, max_z do
              for dx = min_x - 1, max_x + 1, max_x - min_x + 2 do
                if dz % 10 == 0 then
                  local ivm = area:index(minp.x + dx, alt, minp.z + dz)
                  if data[ivm] == node[building_stone] or data[ivm] == node[building_stone_no_spawn] or data[ivm] == node['default:stone_block'] then
                    data[ivm] = node['default:meselamp']
                  end
                end
              end
            end
          end
        end

        for dz = min_z, max_z do
          for dx = min_x, max_x do
            local height
            if heightmap then
              height = heightmap[dz * csize.x + dx + 1]
              if item.node == 'air' then
                height = height + 4
              end
            end
            for dy = coords[3], coords[3] + coords[4] - 1 do
              if not height or (minp.y + dy) < height then
                if not item.random or math.random(item.random) == 1 then
                  local ivm = area:index(minp.x + dx, minp.y + dy, minp.z + dz)
                  data[ivm] = node[item.node]
                  p2data[ivm] = p2
                end
              end
            end
          end
        end

        if item.treasure and math.random(item.treasure) == 1 then
          local x = minp.x + min_x + math.random(max_x - min_x + 1) - 1
          local y = minp.y + coords[3]
          local z = minp.z + min_z + math.random(max_z - min_z + 1) - 1
          local n = geomoria.treasure_chest_hook({x=x, y=y, z=z}, min_x, max_x, min_z, max_z, data, area, node)
          if n and type(n) == 'number' then
            local ivm = area:index(x, y, z)
            data[ivm] = n
          end
        end

        write = true
      elseif item.act == 'stair' then
        for dz = min_z, max_z do
          for dx = min_x, max_x do
            if p2 == 0 then
              dy = coords[3] + dz - min_z
            elseif p2 == 1 then
              dy = coords[3] + dx - min_x
            elseif p2 == 2 then
              dy = coords[3] + max_z - dz
            elseif p2 == 3 then
              dy = coords[3] + max_x - dx
            end

            local height
            if heightmap then
              height = heightmap[dz * csize.x + dx + 1]
            end

            local y1 = item.depth and dy - item.depth or coords[3]
            y1 = math.max(y1, coords[3])
            for y = y1, dy - 1 do
              if not height or (minp.y + y) <= height then
                local ivm = area:index(minp.x + dx, minp.y + y, minp.z + dz)
                data[ivm] = node[building_stone]
              end
            end

            y1 = item.height and dy + item.height or coords[3] + coords[4] + 2
            y1 = math.min(y1, coords[3] + coords[4] + 2)
            for y = dy + 1, y1 do
              if not height or (minp.y + y) <= (height + 4) then
                local ivm = area:index(minp.x + dx, minp.y + y, minp.z + dz)
                data[ivm] = node['air']
              end
            end

            if not height or (minp.y + dy) <= height then
              local ivm = area:index(minp.x + dx, minp.y + dy, minp.z + dz)
              data[ivm] = node[item.node]
              p2data[ivm] = p2
            end
          end
        end
        write = true
      elseif item.act == 'cylinder' then
        local ax = item.axis
        if ax ~= 'y' and (rot == 1 or rot == 3) then
          if ax == 'z' then
            ax = 'x'
          else
            ax = 'z'
          end
        end

        local r2 = (coords[4] / 2) ^ 2
        if ax == 'y' then
          r2 = (coords[2] / 2) ^ 2
        end

        local rx = (min_x + max_x) / 2
        local ry = (coords[3] + coords[3] + coords[4] - 1) / 2
        local rz = (min_z + max_z) / 2

        min_x = math.max(min_x, 0)
        local min_y = math.max(coords[3], 0)
        min_z = math.max(min_z, 0)
        max_x = math.min(max_x, csize.x - 1)
        local max_y = math.min(coords[3] + coords[4] - 1, csize.y - 1)
        max_z = math.min(max_z, csize.z - 1)

        for dz = min_z, max_z do
          for dy = min_y, max_y do
            for dx = min_x, max_x do
              if (ax == 'x' and (rz - dz) ^ 2 + (ry - dy) ^ 2 <= r2) or
                (ax == 'y' and (rx - dx) ^ 2 + (rz - dz) ^ 2 <= r2) or
                (ax == 'z' and (rx - dx) ^ 2 + (ry - dy) ^ 2 <= r2) then
                if not item.random or math.random(item.random) == 1 then
                  local ivm = area:index(minp.x + dx, minp.y + dy, minp.z + dz)
                  data[ivm] = node[item.node]
                  p2data[ivm] = p2
                end
              end
            end
          end
        end

        write = true
      elseif item.act == 'sphere' then
        local r2 = (coords[2] / 2) ^ 2

        local rx = (min_x + max_x) / 2
        local ry = (coords[3] + coords[3] + coords[4] - 1) / 2
        local rz = (min_z + max_z) / 2

        min_x = math.max(min_x, 0)
        local min_y = math.max(coords[3], 0)
        min_z = math.max(min_z, 0)
        max_x = math.min(max_x, csize.x - 1)
        local max_y = math.min(coords[3] + coords[4] - 1, csize.y - 1)
        max_z = math.min(max_z, csize.z - 1)

        for dz = min_z, max_z do
          for dy = min_y, max_y do
            for dx = min_x, max_x do
              if (rz - dz) ^ 2 + (ry - dy) ^ 2 + (rx - dx) ^ 2 <= r2 then
                if not item.random or math.random(item.random) == 1 then
                  local ivm = area:index(minp.x + dx, minp.y + dy, minp.z + dz)
                  data[ivm] = node[item.node]
                  p2data[ivm] = p2
                end
              end
            end
          end
        end

        write = true
      end
    end
  end

  return write, wetness
end
