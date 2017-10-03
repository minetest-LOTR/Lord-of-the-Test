-- Geomoria plans.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)


-- Rotation:
-- 0 Z+   1 X+   2 Z-   3 X-
-- ladders:  2 X+   3 X-   4 Z+   5 Z-


local building_stone = 'geomoria:stone'
if geomoria.generate_ores then
  building_stone = 'default:stone'
end


local placeholder_y51 = {
  {act = 'fill', node = 'air', coords = {0, 80, 51, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {39, 2, 51, 3, 0, 80}},
}


local p = {
  {act = 'fill', node = 'air', line = 'default:stone_block', treasure = 1, coords = {1, 78, 21, 38, 1, 78}},
  {act = 'fill', node = 'default:stone_block', coords = {1, 78, 50, 1, 1, 78}},
  {act = 'fill', node = 'air', coords = {5, 70, 50, 1, 5, 70}},
  {act = 'stair', node = 'stairs:stair_stone', depth = 3, height = 4, param2 = 2, coords = {1, 2, 21, 30, 25, 30}},
  {act = 'stair', node = 'stairs:stair_stone', depth = 3, height = 4, param2 = 0, coords = {77, 2, 21, 30, 25, 30}},
}

for _, item in pairs(geomoria.default_exits) do
  table.insert(p, 2, table.copy(item))
end

for z = 7, 78, 9 do
  for x = 7, 78, 9 do
    local i = {act = 'fill', node = 'default:stone_block', coords = {z, 2, 21, 38, x, 2}}
    table.insert(p, i)
    if geomoria.cheap_lighting then
      for y = 25, 57, 9 do
        i = {act = 'fill', node = 'default:meselamp', coords = {z, 2, y, 1, x, 2}}
        table.insert(p, i)
      end
    end
  end
end

geomoria.plans['pillared room'] = table.copy(p)


p = {
  {param = 'wet'},
  {act = 'fill', node = 'air', coords = {20, 51, 12, 36, 11, 50}},
  {act = 'fill', node = 'default:water_source', treasure = 5, coords = {20, 51, 11, 10, 11, 50}},
  {act = 'fill', node = building_stone, coords = {38, 17, 11, 10, 30, 16}},
  {act = 'fill', node = building_stone, coords = {39, 2, 11, 10, 11, 19}},
  {act = 'fill', node = 'default:water_source', treasure = 3, coords = {49, 30, 11, 5, 62, 17}},
  {act = 'fill', node = 'default:water_source', coords = {17, 32, 11, 2, 69, 2}},
  {act = 'fill', node = 'default:water_source', coords = {43, 2, 11, 2, 61, 10}},
  {act = 'fill', node = 'default:water_source', coords = {17, 2, 11, 2, 23, 46}},
  {act = 'fill', node = 'default:water_source', treasure = 1, coords = {1, 18, 11, 5, 1, 22}},
  {act = 'fill', node = 'air', coords = {56, 8, 21, 5, 1, 5}},
  {act = 'fill', node = 'air', coords = {16, 8, 21, 5, 1, 5}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 0, 11}},
  {act = 'fill', node = 'air', coords = {1, 15, 21, 6, 42, 16}},
  {act = 'fill', node = 'air', coords = {9, 7, 21, 6, 22, 19}},
  {act = 'fill', node = 'air', coords = {1, 4, 21, 4, 31, 7}},
  {act = 'fill', node = 'air', coords = {1, 4, 21, 4, 22, 8}},
  {act = 'fill', node = 'air', coords = {0, 9, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {6, 10, 21, 3, 10, 2}},
  {act = 'fill', node = 'air', coords = {0, 16, 21, 3, 10, 2}},
  {act = 'fill', node = 'air', coords = {72, 7, 21, 4, 47, 11}},
  {act = 'fill', node = 'air', coords = {71, 8, 21, 6, 34, 12}},
  {act = 'fill', node = 'air', coords = {72, 7, 21, 5, 1, 32}},
  {act = 'fill', node = 'air', coords = {71, 9, 21, 2, 19, 2}},
  {act = 'fill', node = 'air', coords = {49, 30, 21, 6, 62, 17}},
  {act = 'fill', node = 'air', coords = {1, 30, 21, 6, 62, 17}},
  {act = 'fill', node = 'air', coords = {37, 6, 21, 4, 75, 4}},
  {act = 'fill', node = 'air', coords = {0, 20, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {71, 9, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {6, 2, 21, 3, 10, 32}},
  {act = 'fill', node = 'air', coords = {0, 16, 21, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {5, 1, 21, 2, 34, 2}},
  {act = 'fill', node = 'air', coords = {5, 1, 21, 2, 26, 2}},
  {act = 'fill', node = 'air', coords = {1, 14, 21, 3, 1, 9}},
  {act = 'fill', node = 'air', coords = {1, 4, 21, 3, 10, 8}},
  {act = 'fill', node = 'air', coords = {9, 7, 21, 3, 7, 11}},
  {act = 'fill', node = 'air', coords = {16, 44, 21, 3, 7, 2}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 5, 2}},
  {act = 'fill', node = 'air', coords = {58, 2, 21, 3, 5, 2}},
  {act = 'fill', node = 'air', coords = {21, 28, 21, 3, 73, 2}},
  {act = 'fill', node = 'air', coords = {16, 2, 21, 3, 56, 6}},
  {act = 'ladder', node = 'default:ladder_steel', param2 = 5, coords = {78, 1, 11, 10, 62, 1}},
  {act = 'ladder', node = 'default:ladder_steel', param2 = 4, coords = {20, 1, 21, 20, 60, 1}},

  {act = 'fill', node = 'air', coords = {20, 51, 41, 5, 61, 9}},
  {act = 'fill', node = 'air', coords = {11, 9, 41, 5, 11, 59}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, param2 = 2, coords = {16, 2, 21, 20, 36, 20}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 3, coords = {1, 10, 41, 10, 39, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 0, coords = {39, 2, 41, 10, 69, 10}},

  {act = 'fill', node = 'air', coords = {71, 8, 51, 3, 39, 2}},
  {act = 'stair', node = 'stairs:stair_stone', depth = 2, param2 = 2, coords = {69, 2, 41, 10, 51, 10}},
  {act = 'fill', node = 'air', coords = {69, 2, 51, 3, 13, 38}},
  {act = 'fill', node = 'air', coords = {61, 8, 51, 3, 13, 2}},
  {act = 'fill', node = 'air', coords = {61, 2, 31, 20, 13, 2}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {61, 2, 50, 1, 13, 2}},
  {act = 'fill', node = 'air', coords = {60, 8, 51, 4, 41, 10}},
  {act = 'fill', node = 'air', coords = {60, 8, 51, 4, 29, 10}},
  {act = 'fill', node = 'air', coords = {28, 24, 51, 6, 30, 25}},
  {act = 'fill', node = 'air', coords = {52, 8, 51, 3, 41, 3}},
  {act = 'fill', node = 'air', coords = {44, 8, 51, 3, 27, 3}},
  {act = 'fill', node = 'air', coords = {28, 8, 51, 3, 27, 3}},
  {act = 'fill', node = 'air', coords = {44, 8, 51, 3, 55, 3}},
  {act = 'fill', node = 'air', coords = {28, 8, 51, 3, 55, 3}},
  {act = 'fill', node = building_stone, coords = {37, 5, 51, 6, 40, 5}},
  {act = 'fill', node = 'air', coords = {68, 1, 51, 3, 34, 2}},
  {act = 'fill', node = 'air', coords = {68, 1, 51, 3, 44, 2}},
  {act = 'fill', node = 'air', coords = {39, 2, 51, 3, 1, 29}},
}

for _, item in pairs(geomoria.default_exits) do
  table.insert(p, 2, table.copy(item))
end

geomoria.plans['reservoir'] = table.copy(p)


p = {
  {act = 'fill', node = 'air', coords = {1, 2, 21, 3, 21, 40}},
  {act = 'fill', node = 'air', coords = {0, 7, 21, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {5, 70, 21, 3, 17, 2}},
  {act = 'fill', node = 'air', coords = {73, 7, 21, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {19, 42, 21, 6, 1, 14}},
  {act = 'fill', node = 'air', coords = {73, 5, 21, 3, 46, 11}},
  {act = 'fill', node = 'air', coords = {73, 5, 21, 3, 23, 11}},
  {act = 'fill', node = 'air', coords = {75, 5, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {71, 9, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {69, 2, 21, 3, 23, 38}},
  {act = 'fill', node = 'air', coords = {21, 50, 21, 3, 21, 2}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 21, 59}},
  {act = 'fill', node = 'air', coords = {39, 22, 21, 3, 77, 2}},
  {act = 'fill', node = 'air', coords = {44, 2, 21, 3, 75, 2}},
  {act = 'cylinder', node = 'air', axis = 'z', coords = {30, 10, 25, 10, 25, 50}},
  {act = 'cylinder', node = 'air', axis = 'z', coords = {40, 10, 25, 10, 25, 50}},
  {act = 'cylinder', node = 'air', axis = 'z', coords = {50, 10, 25, 10, 25, 50}},
  {act = 'fill', node = 'air', coords = {30, 30, 21, 8, 25, 50}},

  {act = 'fill', node = 'air', treasure = 8, coords = {24, 5, 21, 3, 64, 12}},
  {act = 'fill', node = 'air', treasure = 8, coords = {24, 5, 21, 3, 51, 12}},
  {act = 'fill', node = 'air', treasure = 8, coords = {24, 5, 21, 3, 38, 12}},
  {act = 'fill', node = 'air', treasure = 8, coords = {24, 5, 21, 3, 25, 12}},
  {act = 'fill', node = 'air', treasure = 8, coords = {61, 14, 21, 3, 64, 11}},
  {act = 'fill', node = 'air', treasure = 8, coords = {61, 5, 21, 3, 51, 12}},
  {act = 'fill', node = 'air', treasure = 8, coords = {61, 5, 21, 3, 38, 12}},
  {act = 'fill', node = 'air', treasure = 8, coords = {61, 5, 21, 3, 25, 12}},
  {act = 'fill', node = 'air', coords = {29, 1, 21, 3, 68, 2}},
  {act = 'fill', node = 'air', coords = {29, 1, 21, 3, 56, 2}},
  {act = 'fill', node = 'air', coords = {29, 1, 21, 3, 43, 2}},
  {act = 'fill', node = 'air', coords = {29, 1, 21, 3, 30, 2}},
  {act = 'fill', node = 'air', coords = {60, 1, 21, 3, 68, 2}},
  {act = 'fill', node = 'air', coords = {60, 1, 21, 3, 56, 2}},
  {act = 'fill', node = 'air', coords = {60, 1, 21, 3, 43, 2}},
  {act = 'fill', node = 'air', coords = {60, 1, 21, 3, 30, 2}},
  {act = 'fill', node = 'air', coords = {73, 2, 21, 3, 34, 12}},
  {act = 'fill', node = 'air', coords = {3, 16, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {11, 25, 31, 4, 13, 11}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 3, coords = {33, 10, 21, 10, 14, 1}},
  {act = 'fill', node = 'air', coords = {61, 14, 31, 4, 56, 19}},
  {act = 'ladder', node = 'default:ladder_steel', param2 = 4, coords = {63, 1, 21, 10, 74, 1}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 0, coords = {73, 2, 21, 10, 49, 10}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {6, 10, 21, 10, 57, 2}},
  {act = 'fill', node = 'air', coords = {16, 2, 31, 4, 24, 35}},
  {act = 'fill', node = 'air', treasure = 1, coords = {61, 2, 31, 4, 22, 34}},
  {act = 'fill', node = 'air', treasure = 3, coords = {36, 25, 31, 4, 22, 2}},
  {act = 'fill', node = 'air', coords = {3, 3, 21, 3, 57, 2}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {61, 2, 31, 4, 55, 1}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {36, 1, 31, 4, 22, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 2, coords = {67, 2, 31, 10, 46, 10}},

  {act = 'fill', node = 'air', coords = {55, 10, 41, 4, 37, 10}},
  {act = 'fill', node = 'air', coords = {13, 53, 41, 6, 16, 15}},
  {act = 'fill', node = 'air', treasure = 8, coords = {12, 9, 41, 4, 31, 5}},
  {act = 'fill', node = 'air', treasure = 8, coords = {23, 9, 41, 4, 31, 5}},
  {act = 'fill', node = 'air', treasure = 8, coords = {34, 9, 41, 4, 31, 5}},
  {act = 'fill', node = 'air', treasure = 8, coords = {45, 9, 41, 4, 31, 5}},
  {act = 'fill', node = 'air', treasure = 8, coords = {56, 9, 41, 4, 31, 5}},
  {act = 'fill', node = 'air', treasure = 8, coords = {12, 9, 41, 4, 11, 5}},
  {act = 'fill', node = 'air', treasure = 8, coords = {23, 9, 41, 4, 11, 5}},
  {act = 'fill', node = 'air', treasure = 8, coords = {34, 9, 41, 4, 11, 5}},
  {act = 'fill', node = 'air', treasure = 8, coords = {45, 9, 41, 4, 11, 5}},
  {act = 'fill', node = 'air', treasure = 8, coords = {56, 9, 41, 4, 11, 5}},
  {act = 'fill', node = 'air', coords = {67, 2, 41, 3, 25, 21}},
  {act = 'fill', node = 'air', coords = {65, 4, 41, 3, 22, 3}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {67, 10, 41, 10, 11, 2}},
  {act = 'fill', node = 'air', coords = {65, 2, 41, 3, 41, 2}},
  {act = 'fill', node = 'air', coords = {65, 2, 41, 3, 11, 2}},

  {act = 'fill', node = 'air', coords = {77, 2, 51, 3, 3, 38}},
  {act = 'fill', node = 'air', coords = {1, 76, 51, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {1, 78, 51, 3, 1, 2}},
  {act = 'fill', node = 'air', coords = {1, 2, 51, 3, 3, 36}},
  {act = 'fill', node = 'air', coords = {39, 2, 51, 3, 75, 4}},
}

for x = 9, 69, 15 do
  table.insert(p, {act = 'fill', node = 'air', coords = {x, 2, 51, 3, 41, 34}})
  for z = 44, 74, 6 do
    table.insert(p, {act = 'fill', node = 'air', treasure = 20, coords = {x - 6, 5, 51, 3, z - 2, 5}})
    table.insert(p, {act = 'fill', node = 'air', treasure = 20, coords = {x + 3, 5, 51, 3, z - 2, 5}})
    table.insert(p, {act = 'fill', node = 'air', coords = {x - 1, 1, 51, 2, z, 1}})
    table.insert(p, {act = 'fill', node = 'doors:door_wood_b', param2 = 3, coords = {x - 1, 1, 51, 1, z, 1}})
    table.insert(p, {act = 'fill', node = 'air', coords = {x + 2, 1, 51, 2, z, 1}})
    table.insert(p, {act = 'fill', node = 'doors:door_wood_a', param2 = 1, coords = {x + 2, 1, 51, 1, z, 1}})
  end
end

for _, item in pairs(geomoria.default_exits) do
  table.insert(p, 2, table.copy(item))
end

geomoria.plans['market'] = table.copy(p)


p = {
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 76, 4}},
  {act = 'fill', node = 'air', coords = {5, 16, 21, 3, 74, 2}},
  {act = 'fill', node = 'air', coords = {3, 2, 21, 3, 70, 6}},
  {act = 'fill', node = 'air', coords = {5, 20, 21, 3, 70, 2}},
  {act = 'fill', node = 'air', coords = {23, 2, 21, 3, 72, 6}},
  {act = 'fill', node = 'air', coords = {25, 5, 21, 3, 76, 2}},
  {act = 'fill', node = 'air', coords = {28, 2, 21, 3, 60, 16}},
  {act = 'fill', node = 'air', coords = {28, 27, 21, 3, 58, 2}},
  {act = 'fill', node = 'air', coords = {53, 2, 21, 3, 41, 17}},
  {act = 'fill', node = 'air', coords = {50, 5, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 73, 6}},
  {act = 'fill', node = 'air', coords = {32, 20, 21, 3, 71, 2}},
  {act = 'fill', node = 'air', coords = {52, 16, 21, 15, 63, 16}},
  {act = 'fill', node = 'air', coords = {75, 5, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {1, 2, 21, 3, 52, 15}},
  {act = 'fill', node = 'air', coords = {3, 8, 21, 3, 52, 2}},
  {act = 'fill', node = 'air', coords = {9, 2, 21, 3, 54, 9}},
  {act = 'fill', node = 'air', coords = {11, 14, 21, 3, 61, 2}},
  {act = 'fill', node = 'air', coords = {23, 2, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {13, 12, 21, 3, 57, 2}},
  {act = 'fill', node = 'air', coords = {13, 2, 21, 3, 55, 2}},
  {act = 'fill', node = 'air', coords = {13, 37, 21, 3, 53, 2}},
  {act = 'fill', node = 'air', coords = {48, 2, 21, 3, 50, 3}},
  {act = 'fill', node = 'air', coords = {0, 5, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {3, 2, 21, 3, 41, 9}},
  {act = 'fill', node = 'air', coords = {5, 25, 21, 3, 48, 2}},
  {act = 'fill', node = 'air', coords = {4, 4, 21, 3, 25, 2}},
  {act = 'fill', node = 'air', coords = {8, 2, 21, 3, 25, 19}},
  {act = 'fill', node = 'air', coords = {8, 13, 21, 3, 44, 2}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 23, 21}},
  {act = 'fill', node = 'air', coords = {21, 9, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', floor = 'default:stone_block', coords = {1, 78, 21, 15, 17, 6}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 0, 5}},
  {act = 'fill', node = 'air', coords = {2, 17, 21, 3, 3, 2}},
  {act = 'fill', node = 'air', coords = {2, 2, 21, 3, 5, 10}},
  {act = 'fill', node = 'air', coords = {4, 33, 21, 3, 13, 2}},
  {act = 'fill', node = 'air', coords = {6, 6, 21, 3, 9, 2}},
  {act = 'fill', node = 'air', coords = {6, 2, 21, 3, 11, 2}},
  {act = 'fill', node = 'air', coords = {35, 2, 21, 3, 11, 2}},
  {act = 'fill', node = 'air', coords = {35, 15, 21, 3, 9, 2}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 0, 17}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 3, 23, 13}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 3, 0, 17}},
  {act = 'fill', node = 'air', treasure = 3, coords = {59, 20, 21, 3, 36, 8}},
  {act = 'fill', node = 'air', treasure = 3, floor = 'default:stone_block', coords = {30, 20, 21, 15, 30, 20}},

  {act = 'fill', node = 'air', coords = {13, 2, 31, 3, 55, 22}},
  {act = 'fill', node = 'air', coords = {15, 2, 31, 3, 75, 2}},
  {act = 'fill', node = 'air', coords = {17, 2, 31, 3, 45, 32}},
  {act = 'fill', node = 'air', coords = {4, 11, 31, 3, 53, 2}},
  {act = 'fill', node = 'air', coords = {4, 2, 31, 3, 25, 28}},
  {act = 'fill', node = 'air', treasure = 1, coords = {8, 11, 31, 3, 35, 10}},
  {act = 'fill', node = 'air', treasure = 1, coords = {8, 11, 31, 3, 24, 10}},
  {act = 'fill', node = 'air', coords = {20, 2, 31, 3, 11, 6}},
  {act = 'fill', node = 'air', coords = {20, 2, 31, 3, 23, 18}},
  {act = 'fill', node = 'air', coords = {22, 8, 31, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {32, 2, 31, 3, 52, 9}},
  {act = 'fill', node = 'air', coords = {34, 7, 31, 3, 52, 2}},
  {act = 'fill', node = 'air', coords = {39, 2, 31, 3, 50, 2}},
  {act = 'fill', node = 'air', coords = {39, 2, 31, 3, 23, 7}},
  {act = 'fill', node = 'air', coords = {39, 2, 31, 3, 5, 12}},
  {act = 'fill', node = 'air', coords = {41, 24, 31, 3, 5, 2}},
  {act = 'fill', node = 'air', coords = {58, 2, 31, 3, 11, 6}},
  {act = 'fill', node = 'air', coords = {58, 2, 31, 3, 23, 40}},
  {act = 'fill', node = 'air', coords = {50, 8, 31, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {63, 2, 31, 3, 58, 3}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {3, 10, 21, 10, 65, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {12, 10, 21, 10, 9, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {50, 10, 21, 10, 9, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 3, coords = {65, 10, 21, 10, 59, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 2, coords = {32, 2, 21, 10, 61, 10}},
  {act = 'ladder', node = 'default:ladder_steel', param2 = 3, coords = {4, 1, 21, 10, 25, 1}},
  {act = 'fill', node = 'air', coords = {59, 1, 21, 3, 9, 2}},

  {act = 'fill', node = 'air', coords = {63, 2, 41, 3, 17, 31}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 2, coords = {63, 2, 31, 10, 48, 10}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 0, coords = {63, 2, 31, 10, 7, 10}},

  {act = 'fill', node = building_stone, coords = {20, 2, 30, 1, 17, 6}},
  {act = 'fill', node = building_stone, coords = {39, 2, 30, 1, 17, 6}},
  {act = 'fill', node = building_stone, coords = {58, 2, 30, 1, 17, 6}},
  {act = 'fill', node = building_stone, coords = {56, 6, 30, 1, 63, 3}},
  {act = 'fill', node = building_stone, coords = {39, 2, 30, 1, 30, 20}},
  {act = 'fill', node = building_stone, coords = {30, 20, 30, 1, 39, 2}},

  {act = 'fill', node = 'geomoria:false_wall', coords = {1, 2, 21, 3, 58, 1}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {21, 1, 21, 3, 39, 2}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {6, 2, 21, 3, 12, 1}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {38, 1, 21, 3, 9, 2}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {41, 1, 21, 3, 9, 2}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {59, 2, 21, 3, 23, 1}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {13, 2, 31, 3, 67, 1}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {13, 2, 31, 3, 34, 1}},
}

for _, item in pairs(geomoria.default_exits) do
  table.insert(p, 2, table.copy(item))
end

for _, item in pairs(placeholder_y51) do
  table.insert(p, 2, table.copy(item))
end

geomoria.plans['silly straw'] = table.copy(p)


p = {
  {param = 'dry'},
  {act = 'fill', node = 'air', floor = 'default:stone_block', coords = {1, 78, 21, 5, 1, 78}},
  {act = 'fill', node = building_stone, coords = {9, 62, 21, 1, 9, 62}},
  {act = 'fill', node = building_stone, coords = {9, 62, 23, 5, 9, 62}},
  {act = 'fill', node = 'air', coords = {10, 60, 11, 25, 10, 60}},
  {act = 'fill', node = 'default:lava_source', coords = {10, 60, 11, 5, 10, 60}},
  {act = 'fill', node = building_stone, coords = {25, 30, 11, 9, 25, 30}},
  {act = 'fill', node = 'default:stone_block', coords = {25, 30, 20, 1, 25, 30}},
  {act = 'fill', node = building_stone, coords = {39, 2, 20, 1, 55, 15}},
  {act = 'fill', node = building_stone, coords = {39, 2, 20, 1, 10, 15}},
  {act = 'fill', node = building_stone, coords = {10, 15, 20, 1, 39, 2}},
  {act = 'fill', node = building_stone, coords = {55, 15, 20, 1, 39, 2}},
  {act = 'fill', node = 'air', coords = {70, 1, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {9, 1, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 70, 1}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 9, 1}},
  {act = 'fill', node = building_stone, coords = {37, 6, 20, 2, 37, 6}},
  {act = 'fill', node = 'default:lava_source', coords = {38, 4, 20, 2, 38, 4}},
}

for _, item in pairs(geomoria.default_exits) do
  table.insert(p, 2, table.copy(item))
end

for _, item in pairs(placeholder_y51) do
  table.insert(p, 2, table.copy(item))
end

geomoria.plans['lake of fire'] = table.copy(p)


local node = geomoria.clone_node('default:water_source')
node.liquid_range = 2
node.liquid_alternative_flowing = "geomoria:water_flowing_tame"
node.liquid_alternative_source = "geomoria:water_source_tame"
minetest.register_node('geomoria:water_source_tame', node)

local node = geomoria.clone_node('default:water_flowing')
node.liquid_range = 2
node.liquid_alternative_flowing = "geomoria:water_flowing_tame"
node.liquid_alternative_source = "geomoria:water_source_tame"
minetest.register_node('geomoria:water_flowing_tame', node)

p = {
  {param = 'wet'},
  {act = 'fill', node = 'air', coords = {29, 2, 11, 3, 55, 16}},
  {act = 'fill', node = 'air', coords = {25, 4, 11, 3, 69, 2}},
  {act = 'fill', node = 'air', coords = {25, 4, 11, 3, 9, 2}},
  {act = 'fill', node = 'air', coords = {9, 2, 11, 3, 9, 62}},
  {act = 'fill', node = 'air', coords = {11, 4, 11, 3, 9, 2}},
  {act = 'fill', node = 'air', coords = {11, 4, 11, 3, 24, 2}},
  {act = 'fill', node = 'air', coords = {11, 4, 11, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {11, 4, 11, 3, 54, 2}},
  {act = 'fill', node = 'air', coords = {11, 4, 11, 3, 69, 2}},
  {act = 'fill', node = 'air', coords = {49, 12, 11, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {49, 2, 11, 3, 55, 4}},
  {act = 'fill', node = 'air', coords = {26, 30, 11, 6, 25, 30}},
  {act = 'fill', node = 'air', coords = {49, 2, 11, 3, 19, 6}},
  {act = 'fill', node = 'air', coords = {29, 2, 11, 3, 9, 16}},
  {act = 'fill', node = 'air', treasure = 3, coords = {15, 10, 11, 6, 5, 10}},
  {act = 'fill', node = 'air', treasure = 3, coords = {15, 10, 11, 6, 20, 10}},
  {act = 'fill', node = 'air', treasure = 3, coords = {15, 10, 11, 6, 35, 10}},
  {act = 'fill', node = 'air', treasure = 3, coords = {15, 10, 11, 6, 50, 10}},
  {act = 'fill', node = 'air', treasure = 3, coords = {15, 10, 11, 6, 65, 10}},
  {act = 'fill', node = building_stone, coords = {18, 4, 11, 6, 8, 4}},
  {act = 'fill', node = building_stone, coords = {18, 4, 11, 6, 23, 4}},
  {act = 'fill', node = building_stone, coords = {18, 4, 11, 6, 38, 4}},
  {act = 'fill', node = building_stone, coords = {18, 4, 11, 6, 53, 4}},
  {act = 'fill', node = building_stone, coords = {18, 4, 11, 6, 68, 4}},
  {act = 'fill', node = 'default:water_source', coords = {19, 2, 11, 10, 9, 2}},
  {act = 'fill', node = 'default:water_source', coords = {19, 2, 11, 10, 24, 2}},
  {act = 'fill', node = 'default:water_source', coords = {19, 2, 11, 10, 39, 2}},
  {act = 'fill', node = 'default:water_source', coords = {19, 2, 11, 10, 54, 2}},
  {act = 'fill', node = 'default:water_source', coords = {19, 2, 11, 10, 69, 2}},

  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {61, 10, 11, 10, 59, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 2, coords = {39, 2, 11, 10, 1, 10}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 3, coords = {39, 10, 11, 10, 19, 2}},
  {act = 'fill', node = 'air', coords = {39, 2, 11, 3, 11, 14}},
  {act = 'fill', node = building_stone, coords = {61, 1, 21, 6, 59, 2}},

  {act = 'cylinder', node = 'air', axis = 'z', coords = {10, 20, 15, 20, 1, 79}},
  {act = 'fill', node = building_stone, coords = {10, 20, 15, 6, 1, 79}},
  {act = 'fill', node = 'air', floor = 'default:stone_block', coords = {10, 20, 21, 4, 1, 79}},
  {act = 'fill', node = 'air', coords = {1, 8, 21, 4, 56, 8}},
  {act = 'fill', node = 'air', coords = {1, 8, 21, 4, 36, 8}},
  {act = 'fill', node = 'air', coords = {1, 8, 21, 4, 16, 8}},
  {act = 'fill', node = 'air', coords = {4, 2, 21, 3, 64, 7}},
  {act = 'fill', node = 'air', coords = {6, 4, 21, 3, 69, 2}},
  {act = 'fill', node = 'air', coords = {4, 2, 21, 3, 44, 12}},
  {act = 'fill', node = 'air', coords = {6, 4, 21, 3, 49, 2}},
  {act = 'fill', node = 'air', coords = {4, 2, 21, 3, 24, 12}},
  {act = 'fill', node = 'air', coords = {6, 4, 21, 3, 29, 2}},
  {act = 'fill', node = 'air', coords = {4, 2, 21, 3, 9, 7}},
  {act = 'fill', node = 'air', coords = {6, 4, 21, 3, 9, 2}},
  {act = 'fill', node = 'air', coords = {31, 8, 21, 4, 56, 8}},
  {act = 'fill', node = 'air', coords = {31, 8, 21, 4, 36, 8}},
  {act = 'fill', node = 'air', coords = {31, 8, 21, 4, 16, 8}},
  {act = 'fill', node = 'air', coords = {34, 2, 21, 3, 64, 5}},
  {act = 'fill', node = 'air', coords = {30, 9, 21, 3, 69, 2}},
  {act = 'fill', node = 'air', coords = {34, 2, 21, 3, 44, 12}},
  {act = 'fill', node = 'air', coords = {30, 4, 21, 3, 49, 2}},
  {act = 'fill', node = 'air', coords = {34, 2, 21, 3, 24, 12}},
  {act = 'fill', node = 'air', coords = {30, 4, 21, 3, 29, 2}},
  {act = 'fill', node = 'air', coords = {34, 2, 21, 3, 9, 7}},
  {act = 'fill', node = 'air', coords = {30, 4, 21, 3, 9, 2}},
  {act = 'fill', node = 'air', coords = {71, 9, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {39, 41, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {71, 9, 21, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 3, 1, 79}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 69, 11}},

  {act = 'fill', node = building_stone, coords = {15, 10, 21, 1, 5, 10}},
  {act = 'fill', node = 'default:water_source', coords = {16, 8, 21, 1, 6, 8}},
  {act = 'fill', node = building_stone, coords = {19, 2, 21, 2, 9, 2}},
  {act = 'fill', node = 'geomoria:water_source_tame', coords = {19, 2, 23, 1, 9, 2}},
  {act = 'fill', node = building_stone, coords = {15, 10, 21, 1, 20, 10}},
  {act = 'fill', node = 'default:water_source', coords = {16, 8, 21, 1, 21, 8}},
  {act = 'fill', node = building_stone, coords = {19, 2, 21, 2, 24, 2}},
  {act = 'fill', node = 'geomoria:water_source_tame', coords = {19, 2, 23, 1, 24, 2}},
  {act = 'fill', node = building_stone, coords = {15, 10, 21, 1, 35, 10}},
  {act = 'fill', node = 'default:water_source', coords = {16, 8, 21, 1, 36, 8}},
  {act = 'fill', node = building_stone, coords = {19, 2, 21, 2, 39, 2}},
  {act = 'fill', node = 'geomoria:water_source_tame', coords = {19, 2, 23, 1, 39, 2}},
  {act = 'fill', node = building_stone, coords = {15, 10, 21, 1, 50, 10}},
  {act = 'fill', node = 'default:water_source', coords = {16, 8, 21, 1, 51, 8}},
  {act = 'fill', node = building_stone, coords = {19, 2, 21, 2, 54, 2}},
  {act = 'fill', node = 'geomoria:water_source_tame', coords = {19, 2, 23, 1, 54, 2}},
  {act = 'fill', node = building_stone, coords = {15, 10, 21, 1, 65, 10}},
  {act = 'fill', node = 'default:water_source', coords = {16, 8, 21, 1, 66, 8}},
  {act = 'fill', node = building_stone, coords = {19, 2, 21, 2, 69, 2}},
  {act = 'fill', node = 'geomoria:water_source_tame', coords = {19, 2, 23, 1, 69, 2}},

  {act = 'fill', node = 'air', coords = {51, 20, 31, 5, 65, 10}},
  {act = 'fill', node = 'air', coords = {51, 10, 31, 5, 15, 10}},
  {act = 'fill', node = 'air', coords = {55, 2, 31, 3, 25, 27}},
  {act = 'fill', node = 'air', coords = {60, 2, 31, 3, 41, 24}},
  {act = 'fill', node = 'air', coords = {57, 8, 31, 3, 39, 2}},
  {act = 'fill', node = building_stone, coords = {54, 4, 11, 6, 49, 4}},
  {act = 'fill', node = 'air', coords = {55, 2, 6, 25, 50, 2}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {55, 2, 30, 1, 50, 2}},
  {act = 'fill', node = 'air', treasure = 1, coords = {65, 10, 31, 5, 35, 10}},
  {act = 'fill', node = 'air', coords = {69, 2, 31, 3, 45, 5}},
  {act = 'fill', node = 'air', treasure = 1, coords = {65, 10, 31, 5, 50, 10}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {57, 1, 31, 3, 39, 2}},

  {act = 'stair', node = 'stairs:stair_stone', param2 = 3, coords = {61, 10, 21, 10, 19, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {41, 10, 21, 10, 69, 2}},
}

for _, item in pairs(geomoria.default_exits) do
  table.insert(p, 2, table.copy(item))
end

for _, item in pairs(placeholder_y51) do
  table.insert(p, 2, table.copy(item))
end

geomoria.plans['fountain court'] = table.copy(p)


p = {
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 1, 79}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 1, 79}},
  {act = 'fill', node = 'air', coords = {1, 79, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 3, 1, 79}},
  {act = 'fill', node = 'air', coords = {1, 79, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {1, 79, 21, 3, 19, 2}},
}

for _, item in pairs(geomoria.default_exits) do
  table.insert(p, 2, table.copy(item))
end

for _, item in pairs(placeholder_y51) do
  table.insert(p, 2, table.copy(item))
end

geomoria.plans['crossroads'] = table.copy(p)


p = {
  {act = 'fill', node = 'default:dirt', coords = {5, 70, 19, 2, 5, 70}},
  {act = 'fill', node = geomoria.treasure_chest, random = 200, coords = {5, 70, 19, 1, 5, 70}},
  {act = 'fill', node = 'air', coords = {5, 70, 21, 7, 5, 70}},
  {act = 'fill', node = 'flowers:mushroom_brown', random = 4, coords = {5, 70, 21, 1, 5, 70}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 75, 5}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 75, 5}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 3, 75, 5}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 0, 5}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 0, 5}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 3, 0, 5}},
  {act = 'fill', node = 'air', coords = {0, 5, 21, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {0, 5, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {0, 5, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {75, 5, 21, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {75, 5, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {75, 5, 21, 3, 59, 2}},

  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {61, 10, 21, 10, 75, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 3, coords = {9, 10, 21, 10, 3, 2}},
  {act = 'fill', node = 'default:dirt', coords = {5, 70, 29, 2, 5, 70}},
  {act = 'fill', node = geomoria.treasure_chest, random = 200, coords = {5, 70, 29, 1, 5, 70}},
  {act = 'fill', node = 'air', coords = {5, 70, 31, 7, 5, 70}},
  {act = 'fill', node = 'flowers:mushroom_brown', random = 4, coords = {5, 70, 31, 1, 5, 70}},
  {act = 'fill', node = 'air', coords = {71, 6, 31, 3, 75, 2}},
  {act = 'fill', node = 'air', coords = {3, 6, 31, 3, 3, 2}},

  {act = 'stair', node = 'stairs:stair_stone', param2 = 2, coords = {75, 2, 31, 10, 65, 10}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 0, coords = {3, 2, 31, 10, 5, 10}},

  {act = 'fill', node = 'default:dirt', coords = {5, 70, 39, 2, 5, 70}},
  {act = 'fill', node = geomoria.treasure_chest, random = 200, coords = {5, 70, 39, 1, 5, 70}},
  {act = 'fill', node = 'air', coords = {5, 70, 41, 7, 5, 70}},
  {act = 'fill', node = 'flowers:mushroom_brown', random = 4, coords = {5, 70, 41, 1, 5, 70}},
  {act = 'fill', node = 'air', coords = {75, 2, 41, 3, 60, 5}},
  {act = 'fill', node = 'air', coords = {3, 2, 41, 3, 15, 5}},
}

for _, item in pairs(geomoria.default_exits) do
  table.insert(p, 2, table.copy(item))
end

for _, item in pairs(placeholder_y51) do
  table.insert(p, 2, table.copy(item))
end

geomoria.plans['mushroom garden'] = table.copy(p)


p = {
  {act = 'fill', node = 'air', coords = {15, 50, 39, 6, 15, 50}},
  {act = 'fill', node = 'air', coords = {16, 48, 38, 7, 16, 48}},
  {act = 'fill', node = 'air', coords = {17, 46, 37, 8, 17, 46}},
  {act = 'fill', node = 'air', coords = {18, 44, 36, 9, 18, 44}},
  {act = 'fill', node = 'air', coords = {19, 42, 35, 10, 19, 42}},
  {act = 'fill', node = 'air', coords = {20, 40, 34, 11, 20, 40}},
  {act = 'fill', node = 'air', coords = {21, 38, 33, 12, 21, 38}},
  {act = 'fill', node = 'air', coords = {22, 36, 32, 13, 22, 36}},
  {act = 'fill', node = 'air', treasure = 1, coords = {24, 32, 21, 24, 24, 32}},

  {act = 'fill', node = 'air', treasure = 4, coords = {30, 20, 21, 5, 65, 10}},
  {act = 'fill', node = 'air', treasure = 4, coords = {30, 20, 21, 5, 5, 10}},
  {act = 'fill', node = 'air', treasure = 4, coords = {65, 10, 21, 5, 30, 20}},
  {act = 'fill', node = 'air', treasure = 4, coords = {5, 10, 21, 5, 30, 20}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 56, 24}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 0, 24}},
  {act = 'fill', node = 'air', coords = {77, 3, 21, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {77, 3, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {0, 3, 21, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {0, 3, 21, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 77, 3}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 3, 77, 3}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 3, 0, 3}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 0, 3}},
  {act = 'fill', node = 'air', coords = {0, 24, 21, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {56, 24, 21, 3, 39, 2}},

  {act = 'fill', node = 'air', coords = {19, 2, 31, 3, 65, 2}},
  {act = 'fill', node = 'air', coords = {59, 2, 31, 3, 65, 2}},
  {act = 'fill', node = 'air', coords = {59, 2, 31, 3, 13, 2}},
  {act = 'fill', node = 'air', coords = {19, 2, 31, 3, 13, 2}},
  {act = 'fill', node = 'air', coords = {65, 2, 31, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {65, 2, 31, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {13, 2, 31, 3, 59, 2}},
  {act = 'fill', node = 'air', coords = {13, 2, 31, 3, 19, 2}},

  {act = 'stair', node = 'stairs:stair_stone', param2 = 2, coords = {59, 2, 21, 10, 67, 10}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 0, coords = {59, 2, 21, 10, 3, 10}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 0, coords = {19, 2, 21, 10, 3, 10}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 3, coords = {67, 10, 21, 10, 19, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 3, coords = {67, 10, 21, 10, 59, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {3, 10, 21, 10, 59, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {3, 10, 21, 10, 19, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 2, coords = {19, 2, 21, 10, 67, 10}},

  {act = 'fill', node = 'air', coords = {65, 2, 39, 3, 29, 22}},
  {act = 'fill', node = 'air', coords = {13, 2, 39, 3, 29, 22}},
  {act = 'fill', node = 'air', coords = {29, 22, 39, 3, 65, 2}},
  {act = 'fill', node = 'air', coords = {29, 22, 39, 3, 13, 2}},

  {act = 'stair', node = 'stairs:stair_stone', param2 = 2, coords = {65, 2, 31, 8, 51, 8}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 0, coords = {65, 2, 31, 8, 21, 8}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 2, coords = {13, 2, 31, 8, 51, 8}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 0, coords = {13, 2, 31, 8, 21, 8}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 3, coords = {51, 8, 31, 8, 65, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {21, 8, 31, 8, 65, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 3, coords = {51, 8, 31, 8, 13, 2}},
  {act = 'stair', node = 'stairs:stair_stone', param2 = 1, coords = {21, 8, 31, 8, 13, 2}},
}

for _, item in pairs(geomoria.default_exits) do
  table.insert(p, 2, table.copy(item))
end

for _, item in pairs(placeholder_y51) do
  table.insert(p, 2, table.copy(item))
end

geomoria.plans['arena'] = table.copy(p)


p = {
  {act = 'fill', node = 'air', coords = {0, 1, 21, 2, 19, 2}},
  {act = 'fill', node = 'air', coords = {0, 1, 21, 2, 39, 2}},
  {act = 'fill', node = 'air', coords = {0, 1, 21, 2, 59, 2}},
  {act = 'fill', node = 'air', coords = {79, 1, 21, 2, 19, 2}},
  {act = 'fill', node = 'air', coords = {79, 1, 21, 2, 39, 2}},
  {act = 'fill', node = 'air', coords = {79, 1, 21, 2, 59, 2}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 2, 0, 1}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 2, 0, 1}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 2, 0, 1}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 2, 79, 1}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 2, 79, 1}},
  {act = 'fill', node = 'air', coords = {59, 2, 21, 2, 79, 1}},

  {act = 'fill', node = 'air', coords = {38, 4, 21, 3, 1, 78}},
  {act = 'fill', node = 'air', coords = {1, 78, 21, 3, 58, 4}},
  {act = 'fill', node = 'air', coords = {1, 78, 21, 3, 18, 4}},
  {act = 'fill', node = 'air', coords = {1, 8, 21, 3, 37, 6}},
  {act = 'fill', node = 'air', coords = {10, 25, 21, 5, 30, 20}},
  {act = 'fill', node = 'air', coords = {35, 3, 21, 3, 38, 4}},
  {act = 'fill', node = 'air', coords = {42, 37, 21, 3, 38, 4}},
  {act = 'fill', node = 'air', coords = {51, 2, 21, 3, 42, 1}},
  {act = 'fill', node = 'air', coords = {51, 2, 21, 3, 37, 1}},
  {act = 'fill', node = 'air', coords = {69, 2, 21, 3, 42, 1}},
  {act = 'fill', node = 'air', coords = {69, 2, 21, 3, 37, 1}},
  {act = 'fill', node = 'air', coords = {44, 16, 21, 6, 43, 9}},
  {act = 'fill', node = 'air', coords = {44, 16, 21, 6, 28, 9}},
  {act = 'fill', node = 'air', coords = {62, 16, 21, 6, 43, 9}},
  {act = 'fill', node = 'air', coords = {62, 16, 21, 6, 28, 9}},

  {act = 'fill', node = 'air', coords = {24, 13, 21, 3, 71, 2}},
  {act = 'fill', node = 'air', coords = {43, 13, 21, 3, 71, 2}},
  {act = 'fill', node = 'air', coords = {24, 13, 21, 3, 7, 2}},
  {act = 'fill', node = 'air', coords = {43, 13, 21, 3, 7, 2}},
  {act = 'fill', node = 'air', coords = {16, 8, 21, 3, 71, 8}},
  {act = 'fill', node = 'air', coords = {56, 8, 21, 3, 71, 8}},
  {act = 'fill', node = 'air', coords = {16, 8, 21, 3, 1, 8}},
  {act = 'fill', node = 'air', coords = {56, 8, 21, 3, 1, 8}},

  {act = 'fill', node = 'doors:door_wood_a', param2 = 3, coords = {0, 1, 21, 1, 59, 1}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 3, coords = {0, 1, 21, 1, 60, 1}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 1, coords = {79, 1, 21, 1, 59, 1}},
  {act = 'fill', node = 'doors:door_wood_a', param2 = 1, coords = {79, 1, 21, 1, 60, 1}},

  {act = 'fill', node = 'doors:door_wood_a', param2 = 3, coords = {0, 1, 21, 1, 19, 1}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 3, coords = {0, 1, 21, 1, 20, 1}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 1, coords = {79, 1, 21, 1, 19, 1}},
  {act = 'fill', node = 'doors:door_wood_a', param2 = 1, coords = {79, 1, 21, 1, 20, 1}},

  {act = 'fill', node = 'doors:door_wood_a', param2 = 0, coords = {39, 1, 21, 1, 79, 1}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 0, coords = {40, 1, 21, 1, 79, 1}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 2, coords = {39, 1, 21, 1, 0, 1}},
  {act = 'fill', node = 'doors:door_wood_a', param2 = 2, coords = {40, 1, 21, 1, 0, 1}},

  {act = 'fill', node = 'air', coords = {37, 1, 21, 2, 71, 2}},
  {act = 'fill', node = 'air', coords = {42, 1, 21, 2, 71, 2}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 1, coords = {37, 1, 21, 1, 71, 1}},
  {act = 'fill', node = 'doors:door_wood_a', param2 = 1, coords = {37, 1, 21, 1, 72, 1}},
  {act = 'fill', node = 'doors:door_wood_a', param2 = 3, coords = {42, 1, 21, 1, 71, 1}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 3, coords = {42, 1, 21, 1, 72, 1}},

  {act = 'fill', node = 'air', coords = {37, 1, 21, 2, 7, 2}},
  {act = 'fill', node = 'air', coords = {42, 1, 21, 2, 7, 2}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 1, coords = {37, 1, 21, 1, 7, 1}},
  {act = 'fill', node = 'doors:door_wood_a', param2 = 1, coords = {37, 1, 21, 1, 8, 1}},
  {act = 'fill', node = 'doors:door_wood_a', param2 = 3, coords = {42, 1, 21, 1, 7, 1}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 3, coords = {42, 1, 21, 1, 8, 1}},

  {act = 'fill', node = 'doors:door_wood_b', param2 = 1, coords = {79, 1, 21, 1, 39, 1}},
  {act = 'fill', node = 'doors:door_wood_a', param2 = 1, coords = {79, 1, 21, 1, 40, 1}},

  {act = 'fill', node = 'air', coords = {9, 1, 21, 2, 39, 2}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 1, coords = {9, 1, 21, 1, 39, 1}},
  {act = 'fill', node = 'doors:door_wood_a', param2 = 1, coords = {9, 1, 21, 1, 40, 1}},

  {act = 'fill', node = 'geomoria:false_wall', coords = {28, 1, 21, 2, 26, 1}},
  {act = 'fill', node = 'air', coords = {27, 3, 31, 3, 26, 3}},
  {act = 'fill', node = 'air', coords = {28, 1, 31, 3, 29, 10}},
  {act = 'fill', node = 'air', coords = {3, 74, 31, 3, 39, 2}},
  {act = 'fill', node = 'air', treasure = 3, coords = {3, 9, 31, 4, 42, 6}},
  {act = 'fill', node = 'air', treasure = 3, coords = {47, 9, 31, 4, 42, 6}},
  {act = 'fill', node = 'air', treasure = 3, coords = {32, 9, 31, 4, 32, 6}},
  {act = 'fill', node = 'air', treasure = 3, coords = {64, 9, 31, 4, 32, 6}},
  {act = 'fill', node = 'air', treasure = 3, coords = {11, 9, 31, 4, 32, 6}},
  {act = 'fill', node = 'air', coords = {6, 2, 31, 3, 41, 1}},
  {act = 'fill', node = 'air', coords = {51, 2, 31, 3, 41, 1}},
  {act = 'fill', node = 'air', coords = {14, 2, 31, 3, 38, 1}},
  {act = 'fill', node = 'air', coords = {36, 2, 31, 3, 38, 1}},
  {act = 'fill', node = 'air', coords = {66, 2, 31, 3, 38, 1}},
  {act = 'ladder', node = 'default:ladder_steel', param2 = 2, coords = {28, 1, 21, 10, 27, 1}},
}

for _, o in pairs({0, 43}) do
  for x = 4 + o, 32 + o, 4 do
    for _, y in pairs({57, 17}) do
      local i = {act = 'fill', node = 'air', coords = {x, 1, 21, 2, y + 5, 1}}
      table.insert(p, i)
      i = {act = 'fill', node = 'doors:door_wood_a', param2 = 0, coords = {x, 1, 21, 1, y + 5, 1}}
      table.insert(p, i)
      i = {act = 'fill', node = 'air', coords = {x - 1, 3, 21, 3, y + 6, 3}}
      table.insert(p, i)

      i = {act = 'fill', node = 'air', coords = {x, 1, 21, 2, y, 1}}
      table.insert(p, i)
      i = {act = 'fill', node = 'doors:door_wood_a', param2 = 2, coords = {x, 1, 21, 1, y, 1}}
      table.insert(p, i)
      i = {act = 'fill', node = 'air', coords = {x - 1, 3, 21, 3, y - 3, 3}}
      table.insert(p, i)
    end
  end
end

for _, item in pairs(placeholder_y51) do
  table.insert(p, 2, table.copy(item))
end

geomoria.plans['prison'] = table.copy(p)


p = {
  {act = 'sphere', node = 'air', coords = {1, 78, -18, 78, 1, 78}},
  {act = 'fill', node = building_stone, coords = {1, 78, 0, 21, 1, 78}},
  {act = 'fill', node = 'default:stone_block', coords = {1, 78, 20, 1, 1, 78}},
}


geomoria.stair_height = {
  {act = 'fill', node = building_stone, coords = {26, 5, 0, 5, 23, 31}},
  {act = 'fill', node = building_stone, coords = {26, 28, 0, 26, 49, 5}},
  {act = 'fill', node = building_stone, coords = {49, 5, 19, 27, 29, 28}},
  {act = 'fill', node = building_stone, coords = {29, 25, 39, 27, 26, 5}},
  {act = 'fill', node = building_stone, coords = {26, 5, 59, 21, 26, 28}},
  {act = 'fill', node = 'air', coords = {27, 3, 0, 4, 47, 6}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, depth = 3, param2 = 1, coords = {30, 20, 0, 20, 50, 3}},
  {act = 'fill', node = 'air', coords = {47, 6, 20, 4, 50, 3}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, depth = 3, param2 = 2, coords = {50, 3, 20, 20, 30, 20}},
  {act = 'fill', node = 'air', coords = {50, 3, 40, 4, 27, 6}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, depth = 3, param2 = 3, coords = {30, 20, 40, 20, 27, 3}},
  {act = 'fill', node = 'air', coords = {27, 6, 60, 4, 27, 3}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, depth = 3, param2 = 0, coords = {27, 3, 60, 21, 30, 20}},
}

geomoria.stair_base = table.copy(geomoria.stair_height)
--table.insert(geomoria.stair_base, {})
p = {
  {act = 'sphere', node = 'air', coords = {35, 40, 31, 40, 35, 40}},
  {act = 'fill', node = building_stone, coords = {35, 40, 31, 20, 35, 40}},
  {act = 'fill', node = 'default:stone_block', coords = {35, 40, 50, 1, 35, 40}},

  {act = 'stair', node = 'stairs:stair_stone', height = 4, param2 = 3, coords = {50, 10, 41, 10, 10, 2}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, param2 = 0, coords = {10, 2, 41, 10, 25, 10}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, param2 = 3, coords = {20, 10, 41, 10, 55, 2}},
  {act = 'fill', node = 'air', coords = {55, 15, 41, 5, 20, 50}},
  {act = 'fill', node = 'air', coords = {60, 5, 46, 1, 25, 40}},
  {act = 'fill', node = 'air', coords = {60, 2, 41, 3, 15, 5}},
  {act = 'fill', node = 'air', coords = {30, 2, 41, 3, 55, 10}},
  {act = 'fill', node = 'air', coords = {60, 10, 41, 3, 10, 5}},
  {act = 'fill', node = 'air', coords = {33, 22, 41, 3, 20, 2}},
  {act = 'fill', node = 'air', coords = {23, 12, 41, 4, 9, 11}},
  {act = 'fill', node = 'air', coords = {12, 11, 41, 3, 9, 2}},
  {act = 'fill', node = 'air', coords = {10, 2, 41, 3, 9, 16}},


  {act = 'fill', node = 'air', coords = {66, 13, 51, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {39, 2, 51, 3, 66, 13}},
  {act = 'fill', node = 'air', coords = {1, 4, 51, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {5, 2, 51, 3, 10, 55}},
  {act = 'fill', node = 'air', coords = {7, 43, 51, 3, 10, 2}},
  {act = 'fill', node = 'air', coords = {25, 11, 51, 4, 14, 11}},
  {act = 'fill', node = 'air', coords = {38, 11, 51, 4, 14, 11}},
  {act = 'fill', node = 'air', coords = {51, 11, 51, 4, 14, 11}},
  {act = 'fill', node = 'air', coords = {64, 11, 51, 4, 14, 11}},
  {act = 'fill', node = 'air', coords = {36, 8, 51, 4, 1, 8}},
  {act = 'fill', node = 'air', coords = {39, 2, 51, 3, 9, 1}},
  {act = 'fill', node = 'air', coords = {29, 2, 51, 3, 12, 2}},
  {act = 'fill', node = 'air', coords = {36, 2, 51, 3, 14, 2}},
  {act = 'fill', node = 'air', coords = {49, 2, 51, 3, 23, 2}},
  {act = 'fill', node = 'air', coords = {62, 2, 51, 3, 14, 2}},
  {act = 'fill', node = 'air', coords = {5, 15, 51, 3, 65, 2}},
  {act = 'fill', node = 'air', coords = {10, 2, 51, 3, 35, 30}},
  {act = 'fill', node = 'air', coords = {18, 2, 51, 3, 55, 10}},
  {act = 'fill', node = 'air', coords = {14, 2, 51, 3, 55, 10}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, param2 = 2, coords = {14, 2, 51, 10, 45, 10}},

  {act = 'fill', node = 'air', coords = {14, 2, 61, 3, 22, 23}},
  {act = 'fill', node = 'air', coords = {14, 61, 61, 5, 4, 18}},
  {act = 'fill', node = 'air', coords = {16, 14, 66, 1, 6, 14}},
  {act = 'fill', node = 'air', coords = {36, 14, 66, 1, 6, 14}},
  {act = 'fill', node = 'air', coords = {56, 14, 66, 1, 6, 14}},
  {act = 'fill', node = 'air', coords = {50, 10, 61, 5, 22, 21}},
  {act = 'fill', node = building_stone, coords = {48, 14, 60, 1, 34, 42}},
  {act = 'fill', node = building_stone, coords = {34, 14, 60, 1, 54, 2}},
  {act = 'fill', node = 'air', coords = {23, 17, 61, 3, 54, 2}},
  {act = 'fill', node = 'air', coords = {13, 12, 61, 4, 56, 16}},
  {act = 'fill', node = 'air', coords = {25, 9, 61, 4, 70, 9}},

  {act = 'fill', node = 'air', coords = {65, 7, 31, 3, 70, 9}},
  {act = 'fill', node = 'air', coords = {57, 12, 31, 3, 39, 2}},
  {act = 'fill', node = 'air', coords = {57, 2, 31, 3, 11, 28}},
  {act = 'fill', node = 'air', coords = {35, 10, 31, 3, 70, 9}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, param2 = 2, coords = {30, 2, 31, 10, 65, 10}},
  {act = 'fill', node = 'air', coords = {30, 5, 31, 3, 75, 2}},
  {act = 'fill', node = 'air', coords = {45, 8, 31, 3, 75, 2}},

  {act = 'fill', node = 'air', coords = {57, 6, 21, 6, 1, 78}},
  {act = 'fill', node = 'air', coords = {63, 9, 21, 3, 58, 2}},
  {act = 'fill', node = 'air', coords = {72, 7, 21, 3, 56, 8}},
  {act = 'stair', node = 'stairs:stair_stone', depth = 2, height = 4, param2 = 3, coords = {69, 10, 21, 10, 39, 2}},
  {act = 'sphere', node = 'air', coords = {10, 20, 11, 20, 2, 20}},
  {act = 'fill', node = building_stone, coords = {10, 20, 11, 10, 2, 20}},
  {act = 'fill', node = 'default:stone_block', coords = {10, 20, 20, 1, 2, 20}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 1, 2}},
  {act = 'fill', node = 'air', coords = {35, 13, 21, 5, 21, 27}},
  {act = 'fill', node = 'air', coords = {37, 16, 21, 5, 55, 10}},
  {act = 'fill', node = 'air', coords = {51, 2, 21, 3, 53, 2}},
  {act = 'fill', node = 'air', coords = {35, 2, 21, 3, 48, 9}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, param2 = 0, coords = {51, 2, 21, 10, 65, 10}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 65, 14}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, param2 = 0, coords = {65, 2, 21, 10, 60, 10}},

  {act = 'fill', node = 'stairs:stair_stone', param2 = 0, coords = {51, 2, 20, 1, 53, 1}},

  {act = 'fill', node = 'air', coords = {5, 4, 26, 3, 5, 6}},
  {act = 'fill', node = 'air', coords = {45, 12, 31, 3, 11, 2}},
  {act = 'stair', node = 'stairs:stair_stone', height = 5, param2 = 1, coords = {40, 5, 26, 5, 11, 2}},
  {act = 'fill', node = 'air', coords = {5, 35, 26, 3, 11, 2}},
  {act = 'fill', node = building_stone, coords = {9, 22, 25, 1, 11, 2}},

  {act = 'fill', node = 'air', coords = {64, 7, 21, 3, 20, 1}},
  {act = 'fill', node = 'geomoria:false_wall', coords = {64, 1, 21, 3, 20, 1}},
  {act = 'fill', node = 'air', coords = {41, 16, 21, 3, 11, 2}},
  {act = 'fill', node = 'air', coords = {71, 2, 21, 3, 3, 52}},
  {act = 'fill', node = 'air', coords = {73, 6, 21, 3, 19, 2}},
  {act = 'fill', node = 'air', coords = {74, 5, 21, 4, 42, 13}},
  {act = 'fill', node = 'air', coords = {73, 1, 21, 2, 48, 1}},
  {act = 'fill', node = 'doors:door_wood_b', param2 = 1, coords = {73, 1, 21, 1, 48, 1}},

  {act = 'fill', node = 'air', coords = {29, 10, 21, 3, 11, 2}},
  {act = 'fill', node = 'air', coords = {39, 2, 21, 3, 1, 12}},
  {act = 'fill', node = 'air', coords = {1, 10, 21, 3, 11, 2}},
  {act = 'fill', node = 'air', coords = {1, 2, 21, 3, 13, 8}},
  {act = 'fill', node = 'air', coords = {19, 2, 21, 3, 21, 58}},
  {act = 'fill', node = 'air', coords = {21, 14, 21, 3, 55, 2}},
  {act = 'fill', node = 'air', floor = 'default:stone_block', coords = {1, 14, 21, 4, 25, 50}},
  {act = 'fill', node = 'air', coords = {2, 12, 25, 1, 26, 48}},
  {act = 'fill', node = 'air', coords = {3, 10, 26, 1, 27, 46}},
  {act = 'fill', node = 'air', coords = {4, 8, 27, 1, 28, 44}},
  {act = 'fill', node = 'air', coords = {15, 4, 21, 3, 49, 2}},
  {act = 'fill', node = 'default:stone_block', coords = {5, 5, 21, 1, 30, 40}},
  {act = 'fill', node = 'default:water_source', coords = {6, 3, 21, 1, 31, 38}},
  {act = 'stair', node = 'stairs:stair_stone', height = 4, param2 = 2, coords = {70, 2, 31, 10, 60, 10}},
}

for y = 2, 78, 3 do
  for x = 56, 63, 7 do
    table.insert(p, {act = 'fill', node = 'air', coords = {x, 1, 21, 3, y, 1}})
  end
end

for _, y in pairs({1, 7, 13, 22, 28, 34, 40, 46, 52}) do
  table.insert(p, {act = 'fill', node = 'air', coords = {65, 5, 21, 3, y, 5}})
  table.insert(p, {act = 'fill', node = 'air', coords = {70, 1, 21, 2, y + 2, 1}})
  table.insert(p, {act = 'fill', node = 'doors:door_wood_a', param2 = 3, coords = {70, 1, 21, 1, y + 2, 1}})
end

for _, y in pairs({1, 7, 13, 22, 28}) do
  table.insert(p, {act = 'fill', node = 'air', coords = {74, 5, 21, 3, y, 5}})
  table.insert(p, {act = 'fill', node = 'air', coords = {73, 1, 21, 2, y + 2, 1}})
  table.insert(p, {act = 'fill', node = 'doors:door_wood_b', param2 = 1, coords = {73, 1, 21, 1, y + 2, 1}})
end

for _, y in pairs({24, 30, 36, 42, 48, 59, 65, 71}) do
  table.insert(p, {act = 'fill', node = 'air', coords = {22, 5, 21, 3, y, 5}})
  table.insert(p, {act = 'fill', node = 'air', coords = {21, 1, 21, 2, y + 2, 1}})
  table.insert(p, {act = 'fill', node = 'doors:door_wood_b', param2 = 1, coords = {21, 1, 21, 1, y + 2, 1}})
end

for _, item in pairs(geomoria.default_exits) do
  table.insert(p, 2, table.copy(item))
end

for i = #p, 1, -1 do
  table.insert(geomoria.stair_base, 6, p[i])
end


-- %s/\v([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+)/{act = 'fill', node = 'air', coords = {\1, \2, 21, 3, \3, \4}},/


for k, v in pairs(geomoria.plans) do
  geomoria.plans_keys[#geomoria.plans_keys+1] = k
end
