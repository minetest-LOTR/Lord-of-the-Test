

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
else 
    -- No compatible stairs mod found.
    minetest.log("error", "[darkage] Darkage requires at least moreblocks or stairs to be installed. Its not possible to register stairs.")
    function darkage.register_stairs(nodeName)
        minetest.log("warning", "could not create stair of type "..nodeName .." because no compatible stairs mod is installed.")
    end
end

