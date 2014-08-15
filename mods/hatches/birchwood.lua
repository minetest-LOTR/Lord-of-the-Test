-- Local constants
-- This _has_ to be set to 2
local HATCH_OPENED = 2
-- This has to be != from HATCH_OPENED and is coded on 4 bits
local HATCH_CLOSED = 1

-- Local Functions
local on_hatch_punched = function(pos, node, puncher)
    if (node.name ~= 'hatches:hatch_birchwood')
        and (node.name ~= 'hatches:hatch_birchwood_open') then
        return
    end
    local state = node.param2

    -- Switch the hatch state when hit
    if state == HATCH_OPENED then
        node.name = 'hatches:hatch_birchwood'
        node.param2 = HATCH_CLOSED
    else
        node.name = 'hatches:hatch_birchwood_open'
        node.param2 = HATCH_OPENED
    end

    minetest.env:add_node(pos, {
        name = node.name,
        param2 = node.param2,
    })
end

-- Nodes

minetest.register_node('hatches:hatch_birchwood_open', {
    drawtype = 'signlike',
    tile_images = {'hatch_birchwood_open.png'},
    inventory_image = 'hatch_birchwood.png',
    sunlight_propagates = true,
    paramtype = 'light',
    paramtype2 = "wallmounted",
    legacy_wallmounted = true,
    walkable = false,
    climbable = true,
    selection_box = {
        type = "wallmounted",
    },
    drop = 'hatches:hatch_birchwood',
    on_punch = on_hatch_punched,
    groups = { choppy=2, dig_immediate=2 },
})

minetest.register_node('hatches:hatch_birchwood', {
    description = "Hatch of birchwood",
    drawtype = 'nodebox',
    tile_images = {'hatch_birchwood.png'},
    inventory_image = 'hatch_birchwood.png',
    wield_image = "hatch_birchwood.png",
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
    output = 'hatches:hatch_birchwood 2',
    recipe = {
        {'default:steel_ingot 1', 'lottplants:birchwood 1', 'default:steel_ingot 1'},
        {'lottplants:birchwood 1', 'lottplants:birchwood 1', 'lottplants:birchwood 1'},
    },
})
