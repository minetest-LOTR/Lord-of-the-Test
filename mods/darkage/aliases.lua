
-- The following function where taken out of moreblocks, and is licenced under zlib license
-- Modified to fit into darkage purpose
-- Thats the realy old conversation of stairsplus. some of them may be never used in darkage. comment them out.
local function register_stairsplus_alias(origin, new)
    local originmod = origin:split(":")[1]
    local originnode = origin:split(":")[2]
    local newmod = new:split(":")[1]
    local newnode = new:split(":")[2]
    local ra = minetest.register_alias
	ra(originmod.. ":slab_" ..originnode,                           newmod..":slab_" ..newnode)
	ra(originmod.. ":slab_" ..originnode.. "_quarter",              newmod..":slab_" ..newnode.. "_quarter")
	ra(originmod.. ":slab_" ..originnode.. "_three_quarter",        newmod..":slab_" ..newnode.. "_three_quarter")
	ra(originmod.. ":stair_" ..originnode,                          newmod..":stair_" ..newnode)
	ra(originmod.. ":stair_" ..originnode.. "_inverted",            newmod..":stair_" ..newnode)
	ra(originmod.. ":stair_" ..originnode.. "_wall",                newmod..":stair_" ..newnode.. "_wall")
	ra(originmod.. ":stair_" ..originnode.. "_wall_half",           newmod..":stair_" ..newnode.. "_wall_half")
	ra(originmod.. ":stair_" ..originnode.. "_half",                newmod..":stair_" ..newnode.. "_half")
	ra(originmod.. ":stair_" ..originnode.. "_right_half",          newmod..":stair_" ..newnode.. "_right_half")
	ra(originmod.. ":stair_" ..originnode.. "_inner",               newmod..":stair_" ..newnode.. "_inner")
	ra(originmod.. ":stair_" ..originnode.. "_outer",               newmod..":stair_" ..newnode.. "_outer")
end

-- Sandstone cobble
minetest.register_alias(  "darkage:sandstone_cobble","default:sandstonebrick")
register_stairsplus_alias("darkage:sandstone_cobble","default:sandstonebrick")

-- Desert Stone cobble
minetest.register_alias(  "darkage:desert_stone_cobble","default:desert_stonebrick")
register_stairsplus_alias("darkage:desert_stone_cobble","default:desert_stonebrick")

-- Slate Tile
minetest.register_alias(  "darkage:slate_tale","darkage:slate_tile")
register_stairsplus_alias("darkage:slate_tale","darkage:slate_tile")
