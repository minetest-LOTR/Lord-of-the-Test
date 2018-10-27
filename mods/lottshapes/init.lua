dofile(minetest.get_modpath("lottshapes") .. "/shapes.lua")
dofile(minetest.get_modpath("lottshapes") .. "/circular_saw.lua")

-- Shapes API
-- 
-- lottshapes:register_shapes("<modname>:<name>", {
-- 		texture = "<texture>" 			-- single texture for fence/wall if necessary
--		<shape>_tile = {textures}		-- replacement tiles for specific shape if applicable
--										   e.g. mattiles = {"default_dirt.png"} -- Changes "mat" shape texture
-- 		drop = <drop> 					-- drops if applicable
-- 		disabled = ""					-- disable certain shapes
--										   e.g. disabled = "mat, slab" -- Disable "mat" & "slab" shapes
-- })
--
-- List of supported shapes;
-- =====================================
-- mat, cube, step, halfstair, slab, innerstair, stair, outerstair, sphere
-- fence, pole, wall, pillar, pane
--