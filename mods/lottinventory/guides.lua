-- This file contains the more basic guides, the normal craft guide, the cooking
-- guide, the armor/protection guide, the forbidden item guide and the master guide.
-- These all use the same system, as outlined in functions.lua. The brewing and
-- potions guides uses a different, hardcoded system, and therefore, have files
-- of their own.

local guides = {
	craft = {
		{},	{"cook_crafts", "armor_use", "armor_crafts", "forbidden"}, _, "cooking"
	},
	cooking = {
		{"cook_crafts"}, {"forbidden", "armor_use", "armor_crafts"}, "cooking"
	},
	protection = {
		{"armor_use", "armor_crafts"}, {"forbidden"}
	},
	forbidden = {
		{"forbidden"}, {}
	},
	master = {
		{}, {}, _, _, true
	},
}

for name, table in pairs(guides) do
	lottinventory[name] = {users = {}, crafts = {}, itemlist = {}, need_load_all = true}
	lottinventory.receive_fields(lottinventory[name], name, table[5])
	local groups = {book = 1}
	if name == "forbidden" then
		groups.armor_use = 1
	elseif name == "master" then
		groups.forbidden = 1
	end

	minetest.register_tool("lottinventory:" .. name .. "_book",{
	    description = name:gsub("^%l", string.upper) .. " Book",
	    groups = groups,
	    inventory_image = "lottinventory_" .. name .. "_book.png",
	    wield_image = "",
	    wield_scale = {x=1,y=1,z=1},
	    stack_max = 1,
	    tool_capabilities = {
	        full_punch_interval = 1.0,
	        max_drop_level=0,
	        groupcaps={
	            fleshy={times={[2]=0.80, [3]=0.40}, maxlevel=1},
	            snappy={times={[2]=0.80, [3]=0.40}, maxlevel=1},
	            choppy={times={[3]=0.90}, maxlevel=0}
	        }
	    },
	    on_place = function(itemstack, player, pointed_thing)
			lottinventory.on_use(player, lottinventory[name], name,
				table[1], table[2], table[3], table[4], table[5])
	    end,
	    on_use = function(itemstack, player, pointed_thing)
			lottinventory.on_use(player, lottinventory[name], name,
				table[1], table[2], table[3], table[4], table[5])
	    end,
	})
end

minetest.register_alias("lottinventory:crafts_book", "lottinventory:craft_book")
minetest.register_alias("lottinventory:forbidden_crafts_book", "lottinventory:forbidden_book")
