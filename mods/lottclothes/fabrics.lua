--------------------------------------------------------------------------------
-- fabrics.lua: colored fabrics as ingredient for clothes
--------------------------------------------------------------------------------
-- HRtV 2014
-- version: 1.0
-- basics
--------------------------------------------------------------------------------
-- lottclothes:flaxthread   - made of default:dry_shrub (4x)
-- lottclothes:flax_<color> - made of flaxthread (5x) and dye:<color> (4x)

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
minetest.register_craftitem("lottclothes:flaxthread", {
	description = "Flax Thread",
	inventory_image = "lottclothes_flaxthread.png",
})
minetest.register_craft({
	type = "shapeless",
	output = "lottclothes:flaxthread 2",
	recipe = {"default:dry_shrub","default:dry_shrub","default:dry_shrub","default:dry_shrub"}
})

-- flax, a fabric made of flaxthreads
for color, dye in pairs(fabric_colors) do
	minetest.register_craftitem("lottclothes:flax_"..color, {
		description = color:gsub("^%l", string.upper).." Flax",
		inventory_image = "lottclothes_flax_"..color..".png"
	})
	
	if color == "brown" then
		-- default to brown
		minetest.register_craft({
			output = "lottclothes:flax_"..color.." 3",
			recipe = {
				{"lottclothes:flaxthread","lottclothes:flaxthread","lottclothes:flaxthread"},
				{"lottclothes:flaxthread","lottclothes:flaxthread","lottclothes:flaxthread"},
				{"lottclothes:flaxthread","lottclothes:flaxthread","lottclothes:flaxthread"},
			}
		})	
	else
		-- all other colors require little dye
		minetest.register_craft({
			output = "lottclothes:flax_"..color.." 3",
			recipe = {
				{"lottclothes:flaxthread",dye,"lottclothes:flaxthread"},
				{dye,"lottclothes:flaxthread",dye},
				{"lottclothes:flaxthread",dye,"lottclothes:flaxthread"},
			}
		})
	end
end


-- feltthreads
minetest.register_craftitem("lottclothes:feltthread", {
	description = "Felt Thread",
	inventory_image = "lottclothes_feltthread.png",
})
minetest.register_craft({
	type = "shapeless",
	output = "lottclothes:feltthread 2",
	recipe = {"group:leaves","group:leaves","group:leaves","group:leaves"}
})


-- felt, a fabric made of feltthreads
for color, dye in pairs(fabric_colors) do
	minetest.register_craftitem("lottclothes:felt_"..color, {
		description = color:gsub("^%l", string.upper).." Felt",
		inventory_image = "lottclothes_felt_"..color..".png"
	})
	
	if color == "green" then
		-- green is default color, all felt (no dye)
		minetest.register_craft({
			output = "lottclothes:felt_"..color.." 3",
			recipe = {
				{"lottclothes:feltthread","lottclothes:feltthread","lottclothes:feltthread"},
				{"lottclothes:feltthread","lottclothes:feltthread","lottclothes:feltthread"},
				{"lottclothes:feltthread","lottclothes:feltthread","lottclothes:feltthread"},
			}
		})	
	else
		-- all other colors require little dye
		minetest.register_craft({
			output = "lottclothes:felt_"..color.." 3",
			recipe = {
				{"lottclothes:feltthread",dye,"lottclothes:feltthread"},
				{dye,"lottclothes:feltthread",dye},
				{"lottclothes:feltthread",dye,"lottclothes:feltthread"},
			}
		})
	end
end
