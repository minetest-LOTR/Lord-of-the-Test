

if minetest.get_modpath("moreblocks") then
	function darkage.register_stairs(nodeName)
        local ndef = assert(minetest.registered_nodes[nodeName], "Error: "..nodeName.." is not registered")

        local mod = "darkage"
        local node = nodeName:split(":")[2]

        stairsplus:register_all(mod, node, nodeName, ndef)
    end
elseif minetest.get_modpath("stairs") then
	function darkage.register_stairs(nodeName)
        local ndef = assert(minetest.registered_nodes[nodeName], "Error: "..nodeName.." is not registered")

        local node = nodeName:split(":")[2]

        -- The stairs api does not allow to use the darkage modname, so we have to call the nodes stairs:stair_darkage_
        -- and creating an alias
        local subname = "darkage_".. node; 
        stairs.register_stair_and_slab(subname, nodeName,
                                       ndef.groups, ndef.tiles, 
                                       ndef.description.." Stair", ndef.description.." Slab",
                                       ndef.sounds)

        --stairs.register_stair_and_slab(subname, recipeitem,
        --                               groups, images, 
        --                               desc_stair, desc_slab, sounds)
        minetest.register_alias("darkage:stair_"..node, "stairs:stair_darkage_"..node)
        minetest.register_alias("darkage:slab_"..node, "stairs:slab_darkage_"..node)
    end
end

