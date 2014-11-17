--------------------------------------------------------------------------------
-- fabrics.lua: colored fabrics as ingredient for clothes
--------------------------------------------------------------------------------
-- HRtV 2014
-- version: 1.0
-- basics
--------------------------------------------------------------------------------
-- curwe:flaxthread   - made of default:dry_shrub (4x)
-- curwe:flax_<color> - made of flaxthread (5x) and dye:<color> (4x)

local fabric_colors = {
	blue   = "dye:blue",
	brown  = "dye:brown",
	green  = "dye:green",
	grey   = "dye:grey",
	pink   = "dye:pink",
	red    = "dye:red",
	white  = "dye:white",
	yellow = "dye:yellow"	
}

-- flaxthreads made of dry_shrub. 2:1
minetest.register_craftitem("curwe:flaxthread", {
	description = "Flax Thread",
	inventory_image = "curwe_flaxthread.png",
})
minetest.register_craft({
	type = "shapeless",
	output = "curwe:flaxthread 2",
	recipe = {"default:dry_shrub","default:dry_shrub","default:dry_shrub","default:dry_shrub"}
})

-- flax, a fabric made of flaxthreads
for color, dye in pairs(fabric_colors) do
	minetest.register_craftitem("curwe:flax_"..color, {
		description = color:gsub("^%l", string.upper).." Flax",
		inventory_image = "curwe_flax_"..color..".png"
	})
	
	if color == "brown" then
		-- default to brown
		minetest.register_craft({
			output = "curwe:flax_"..color.." 3",
			recipe = {
				{"curwe:flaxthread","curwe:flaxthread","curwe:flaxthread"},
				{"curwe:flaxthread","curwe:flaxthread","curwe:flaxthread"},
				{"curwe:flaxthread","curwe:flaxthread","curwe:flaxthread"},
			}
		})	
	else
		-- all other colors require little dye
		minetest.register_craft({
			output = "curwe:flax_"..color.." 3",
			recipe = {
				{"curwe:flaxthread",dye,"curwe:flaxthread"},
				{dye,"curwe:flaxthread",dye},
				{"curwe:flaxthread",dye,"curwe:flaxthread"},
			}
		})
	end
end


-- feltthreads
minetest.register_craftitem("curwe:feltthread", {
	description = "Felt Thread",
	inventory_image = "curwe_feltthread.png",
})
minetest.register_craft({
	type = "shapeless",
	output = "curwe:feltthread 2",
	recipe = {"group:leaves","group:leaves","group:leaves","group:leaves"}
})


-- felt, a fabric made of feltthreads
for color, dye in pairs(fabric_colors) do
	minetest.register_craftitem("curwe:felt_"..color, {
		description = color:gsub("^%l", string.upper).." Felt",
		inventory_image = "curwe_felt_"..color..".png"
	})
	
	if color == "green" then
		-- green is default color, all felt (no dye)
		minetest.register_craft({
			output = "curwe:felt_"..color.." 3",
			recipe = {
				{"curwe:feltthread","curwe:feltthread","curwe:feltthread"},
				{"curwe:feltthread","curwe:feltthread","curwe:feltthread"},
				{"curwe:feltthread","curwe:feltthread","curwe:feltthread"},
			}
		})	
	else
		-- all other colors require little dye
		minetest.register_craft({
			output = "curwe:felt_"..color.." 3",
			recipe = {
				{"curwe:feltthread",dye,"curwe:feltthread"},
				{dye,"curwe:feltthread",dye},
				{"curwe:feltthread",dye,"curwe:feltthread"},
			}
		})
	end
end
