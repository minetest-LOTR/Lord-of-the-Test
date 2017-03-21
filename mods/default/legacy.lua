-- legacy (Minetest 0.4 mod)
-- Provides as much backwards-compatibility as feasible

--
-- Aliases to support loading 0.3 and old 0.4 worlds and inventories
--

minetest.register_node("default:rdirt", {
    description = "Legacy Dirt",
    tiles = {"default_dirt.png"},
    drop = "default:dirt",
    groups = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 1}
})
minetest.register_abm({
    nodenames = {"default:rdirt"},
    interval = 10,
    chance = 1,
    action = function(pos)
        minetest.remove_node(pos)
    end
})

minetest.register_alias("stone", "default:stone")
minetest.register_alias("stone_with_coal", "default:stone_with_coal")
minetest.register_alias("stone_with_iron", "default:stone_with_iron")
minetest.register_alias("dirt_with_grass", "default:dirt_with_grass")
minetest.register_alias("dirt_with_grass_footsteps", "default:dirt_with_grass_footsteps")
minetest.register_alias("dirt", "default:dirt")
minetest.register_alias("sand", "default:sand")
minetest.register_alias("gravel", "default:gravel")
minetest.register_alias("sandstone", "default:sandstone")
minetest.register_alias("clay", "default:clay")
minetest.register_alias("brick", "default:brick")
minetest.register_alias("tree", "default:tree")
minetest.register_alias("jungletree", "default:jungletree")
minetest.register_alias("junglegrass", "default:junglegrass")
minetest.register_alias("leaves", "default:leaves")
minetest.register_alias("cactus", "default:cactus")
minetest.register_alias("papyrus", "default:papyrus")
minetest.register_alias("bookshelf", "default:bookshelf")
minetest.register_alias("glass", "default:glass")
minetest.register_alias("wooden_fence", "default:fence_wood")
minetest.register_alias("rail", "default:rail")
minetest.register_alias("ladder", "default:ladder")
minetest.register_alias("wood", "default:wood")
minetest.register_alias("mese", "default:mese")
minetest.register_alias("cloud", "default:cloud")
minetest.register_alias("water_flowing", "default:water_flowing")
minetest.register_alias("water_source", "default:water_source")
minetest.register_alias("lava_flowing", "default:lava_flowing")
minetest.register_alias("lava_source", "default:lava_source")
minetest.register_alias("torch", "default:torch")
minetest.register_alias("sign_wall", "default:sign_wall")
minetest.register_alias("furnace", "default:furnace")
minetest.register_alias("chest", "default:chest")
minetest.register_alias("locked_chest", "default:chest_locked")
minetest.register_alias("cobble", "default:cobble")
minetest.register_alias("mossycobble", "default:mossycobble")
minetest.register_alias("steelblock", "default:steelblock")
minetest.register_alias("nyancat", "default:nyancat")
minetest.register_alias("nyancat_rainbow", "default:nyancat_rainbow")
minetest.register_alias("sapling", "default:sapling")
minetest.register_alias("apple", "default:apple")

minetest.register_alias("WPick", "default:pick_wood")
minetest.register_alias("STPick", "default:pick_stone")
minetest.register_alias("SteelPick", "default:pick_steel")
minetest.register_alias("MesePick", "default:pick_mese")
minetest.register_alias("WShovel", "default:shovel_wood")
minetest.register_alias("STShovel", "default:shovel_stone")
minetest.register_alias("SteelShovel", "default:shovel_steel")
minetest.register_alias("WAxe", "default:axe_wood")
minetest.register_alias("STAxe", "default:axe_stone")
minetest.register_alias("SteelAxe", "default:axe_steel")
minetest.register_alias("WSword", "default:sword_wood")
minetest.register_alias("STSword", "default:sword_stone")
minetest.register_alias("SteelSword", "default:sword_steel")

minetest.register_alias("Stick", "default:stick")
minetest.register_alias("paper", "default:paper")
minetest.register_alias("book", "default:book")
minetest.register_alias("lump_of_coal", "default:coal_lump")
minetest.register_alias("lump_of_iron", "default:iron_lump")
minetest.register_alias("lump_of_clay", "default:clay_lump")
minetest.register_alias("steel_ingot", "default:steel_ingot")
minetest.register_alias("clay_brick", "default:clay_brick")
minetest.register_alias("scorched_stuff", "default:dirt")
minetest.register_alias("rat", "default:dirt")
minetest.register_alias("cooked_rat", "default:dirt")
minetest.register_alias("firefly", "lottplants:firefly")

minetest.register_alias("moreores:mineral_gold", "default:stone_with_gold")
minetest.register_alias("moreores:gold_block", "default:goldblock")
minetest.register_alias("moreores:gold_lump", "default:gold_lump")
minetest.register_alias("moreores:gold_ingot", "default:gold_ingot")
minetest.register_alias("moreores:mineral_copper", "default:stone_with_copper")
minetest.register_alias("moreores:copper_lump", "default:copper_lump")
minetest.register_alias("moreores:copper_ingot", "default:copper_ingot")
minetest.register_alias("moreores:copper_block", "default:copperblock")
minetest.register_alias("moreores:bronze_ingot", "default:bronze_ingot")
minetest.register_alias("moreores:bronze_block", "default:bronzeblock")

minetest.register_alias("diamonds:diamond_in_ground", "default:stone_with_diamond")
minetest.register_alias("diamonds:block", "default:diamondblock")
minetest.register_alias("diamonds:sword", "default:sword_diamond")
minetest.register_alias("diamonds:pick", "default:pick_diamond")
minetest.register_alias("diamonds:shovel", "default:shovel_diamond")
minetest.register_alias("diamonds:axe", "default:axe_diamond")
minetest.register_alias("diamonds:diamond", "default:diamond")
minetest.register_alias("diamonds:ingot", "default:diamond")

minetest.register_alias("lottspecial:helmet_birthday", "lottarmor:helmet_bronze")
minetest.register_alias("lottspecial:chestplate_birthday", "lottarmor:chestplate_bronze")
minetest.register_alias("lottspecial:leggings_birthday", "lottarmor:leggings_bronze")
minetest.register_alias("lottspecial:boots_birthday", "lottarmor:boots_bronze")
minetest.register_alias("lottspecial:shield_birthday", "lottarmor:shield_bronze")
minetest.register_alias("lottspecial:birthday_paxel", "lottores:mithrilpick")
minetest.register_alias("lottspecial:chest", "default:chest")
minetest.register_alias("lottspecial:cake_knife", "default:sword_steel")
minetest.register_alias("lottspecial:cake_slice", "default:apple")
minetest.register_alias("lottspecial:cake", "default:bread")

minetest.register_alias("hatches:hatch_alderwood_open", "lottblocks:hatch_alder_open")
minetest.register_alias("hatches:hatch_alderwood", "lottblocks:hatch_alder")
minetest.register_alias("hatches:hatch_birchwood_open", "lottblocks:hatch_birch_open")
minetest.register_alias("hatches:hatch_birchwood", "lottblocks:hatch_birch")
minetest.register_alias("hatches:hatch_lebethronwood_open", "lottblocks:hatch_lebethron_open")
minetest.register_alias("hatches:hatch_lebethronwood", "lottblocks:hatch_lebethron")
minetest.register_alias("hatches:hatch_mallornwood_open", "lottblocks:hatch_mallorn_open")
minetest.register_alias("hatches:hatch_mallornwood", "lottblocks:hatch_mallorn")

minetest.register_alias("lottspecial:jackomelon", "lottfarming:melon")
minetest.register_alias("lottspecial:jackomelon_lighted", "lottfarming:melon")
minetest.register_alias("lottspecial:scarecrow", "lottfarming:melon")
minetest.register_alias("lottspecial:scarecrow_bottom", "lottfarming:melon")
minetest.register_alias("lottspecial:scarecrow_light", "lottfarming:melon")

minetest.register_alias("lottmapgen:beechgen", "air")
minetest.register_alias("lottmapgen:mallorngen", "air")
minetest.register_alias("lottmapgen:mirkgen", "air")

minetest.register_alias("default:diamond", "default:mese_crystal")
minetest.register_alias("default:stone_with_diamond", "default:stone_with_mese")
minetest.register_alias("default:diamondblock", "default:mese")

minetest.register_alias("default:fence_wood", "lottblocks:fence_wood")
minetest.register_alias("default:ladder", "lottblocks:ladder_wood")

minetest.register_alias("defualt:nyancat", "lottores:mithril_block")
minetest.register_alias("default:nyancat_rainbow", "lottores:galvorn_block")

gaurds = {"dwarven", "elven", "gondor", "orc", "rohan", "uruk_hai"}
for i, v in pairs(gaurds) do
    minetest.register_alias("lottnpc:" .. v .. "_guard_spawner", "default:rdirt")
    minetest.register_entity(":lottnpc:" .. v .. "_guard", {
        physical = false,
        on_step = function(self)
            self.object:remove()
        end
    })
end

minetest.register_entity(":npcf:nametag", {
    physical = false,
    on_step = function(self)
        self.object:remove()
    end
})
