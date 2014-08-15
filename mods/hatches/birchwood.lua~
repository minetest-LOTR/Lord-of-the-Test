-- Local constants
-- This _has_ to be set to 2
local HATCH_OPENED = 2
-- This has to be != from HATCH_OPENED and is coded on 4 bits
local HATCH_CLOSED = 1

-- Local Functions
local on_hatch_punched = function(pos, node, puncher)
    if (node.name ~= 'hatches:hatch_lebethronwood')
        and (node.name ~= 'hatches:hatch_lebethronwood_open') then
        return
    end
    local state = node.param2

    -- Switch the hatch state when hit
    if state == HATCH_OPENED then
        node.name = 'hatches:hatch_lebethronwood'
        node.param2 = HATCH_CLOSED
    else
        node.name = 'hatches:hatch_lebethronwood_open'
        node.param2 = HATCH_OPENED
    end

    minetest.env:add_node(pos, {
        name = node.name,
        param2 = node.param2,
    })
end

-- Nodes

minetest.register_node('hatches:hatch_lebethronwood_open', {
    drawtype = 'signlike',
    tile_images = {'hatch_lebethronwood_open.png'},
    inventory_image = 'hatch_lebethronwood.png',
    sunlight_propagates = true,
    paramtype = 'light',
    paramtype2 = "wallmounted",
    legacy_wallmounted = true,
    walkable = false,
    climbable = true,
    selection_box = {
        type = "wallmounted",
    },
    drop = 'hatches:hatch_lebethronwood',
    on_punch = on_hatch_punched,
    groups = { choppy=2, dig_immediate=2 },
})

minetest.register_node('hatches:hatch_lebethronwood', {
    description = "Hatch of lebethronwood",
    drawtype = 'nodebox',
    tile_images = {'hatch_lebethronwood.png'},
    inventory_image = 'hatch_lebethronwood.png',
    wield_image = "hatch_lebethronwood.png",
    paramtype = 'light',
    is_ground_content = true,
    walkable = true,
    node_box = {
        type = "fixed",
        fixed = {-1/2, 2/5, -1/2, 1/2, 1/2, 1/2},
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/2, 2/5, -1/2, 1/2, 1/2, 1/2},
    },
    on_punch = on_hatch_punched,
    groups = { choppy=2, dig_immediate=2 },
})

-- craft


minetest.register_craft({
    output = 'hatches:hatch_lebethronwood 2',
    recipe = {
        {'default:steel_ingot 1', 'lottplants:lebethronwood 1', 'default:steel_ingot 1'},
        {'lottplants:lebethronwood 1', 'lottplants:lebethronwood 1', 'lottplants:lebethronwood 1'},
    },
})
