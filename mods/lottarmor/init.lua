local MP = minetest.get_modpath(
    minetest.get_current_modname(
    )
)

local S, NS = dofile(
    MP .. "/intllib.lua"
)

dofile(minetest.get_modpath(minetest.get_current_modname()).."/multiskin.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/armor.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/shield.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/wieldview.lua")
--Special Armors
--dofile(minetest.get_modpath(minetest.get_current_modname()).."/racearmor.lua")

-- Wood Armor
minetest.register_tool("lottarmor:helmet_wood", {
	description = S("Training Helmet"),
	inventory_image = "lottarmor_inv_helmet_wood.png",
	groups = {armor_head=2.5, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=0.2},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_wood", {
	description = S("Training Chestplate"),
	inventory_image = "lottarmor_inv_chestplate_wood.png",
	groups = {armor_torso=5, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=0.2},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_wood", {
	description = S("Training Leggings"),
	inventory_image = "lottarmor_inv_leggings_wood.png",
	groups = {armor_legs=2.5, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=0.2},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_wood", {
	description = S("Training Boots"),
	inventory_image = "lottarmor_inv_boots_wood.png",
	groups = {armor_feet=2.5, armor_heal=0, armor_use=2100, armor_healing=0, physics_speed=0.2},
	wear = 0,
})

-- Tin Armor
minetest.register_tool("lottarmor:helmet_tin", {
	description = S("Tin Helmet"),
	inventory_image = "lottarmor_inv_helmet_tin.png",
	groups = {armor_head=5, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_tin", {
	description = S("Tin Chestplate"),
	inventory_image = "lottarmor_inv_chestplate_tin.png",
	groups = {armor_torso=10, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_tin", {
	description = S("Tin Leggings"),
	inventory_image = "lottarmor_inv_leggings_tin.png",
	groups = {armor_legs=5, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_tin", {
	description = S("Tin Boots"),
	inventory_image = "lottarmor_inv_boots_tin.png",
	groups = {armor_feet=5, armor_heal=0, armor_use=2000, armor_healing=0},
	wear = 0,
})

--Copper Armor
minetest.register_tool("lottarmor:helmet_copper", {
	description = S("Copper Helmet"),
	inventory_image = "lottarmor_inv_helmet_copper.png",
	groups = {armor_head=5, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_copper", {
	description = S("Copper Chestplate"),
	inventory_image = "lottarmor_inv_chestplate_copper.png",
	groups = {armor_torso=10, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_copper", {
	description = S("Copper Leggings"),
	inventory_image = "lottarmor_inv_leggings_copper.png",
	groups = {armor_legs=5, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_copper", {
	description = S("Copper Boots"),
	inventory_image = "lottarmor_inv_boots_copper.png",
	groups = {armor_feet=5, armor_heal=0, armor_use=2000, armor_healing=0},
	wear = 0,
})

--Steel Armor
minetest.register_tool("lottarmor:helmet_steel", {
	description = S("Steel Helmet"),
	inventory_image = "lottarmor_inv_helmet_steel.png",
	groups = {armor_head=10, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_steel", {
	description = S("Steel Chestplate"),
	inventory_image = "lottarmor_inv_chestplate_steel.png",
	groups = {armor_torso=15, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_steel", {
	description = S("Steel Leggings"),
	inventory_image = "lottarmor_inv_leggings_steel.png",
	groups = {armor_legs=15, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_steel", {
	description = S("Steel Boots"),
	inventory_image = "lottarmor_inv_boots_steel.png",
	groups = {armor_feet=10, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

--Bronze Armor
minetest.register_tool("lottarmor:helmet_bronze", {
	description = S("Bronze Helmet"),
	inventory_image = "lottarmor_inv_helmet_bronze.png",
	groups = {armor_head=10, armor_heal=6, armor_use=250, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_bronze", {
	description = S("Bronze Chestplate"),
	inventory_image = "lottarmor_inv_chestplate_bronze.png",
	groups = {armor_torso=15, armor_heal=6, armor_use=250, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_bronze", {
	description = S("Bronze Leggings"),
	inventory_image = "lottarmor_inv_leggings_bronze.png",
	groups = {armor_legs=15, armor_heal=6, armor_use=250, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_bronze", {
	description = S("Bronze Boots"),
	inventory_image = "lottarmor_inv_boots_bronze.png",
	groups = {armor_feet=10, armor_heal=6, armor_use=250, armor_healing=0},
	wear = 0,
})


--Silver Armor
minetest.register_tool("lottarmor:helmet_silver", {
	description = S("Silver Helmet"),
	inventory_image = "lottarmor_inv_helmet_silver.png",
	groups = {armor_head=12, armor_heal=3, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_silver", {
	description = S("Silver Chestplate"),
	inventory_image = "lottarmor_inv_chestplate_silver.png",
	groups = {armor_torso=17, armor_heal=3, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_silver", {
	description = S("Silver Leggings"),
	inventory_image = "lottarmor_inv_leggings_silver.png",
	groups = {armor_legs=17, armor_heal=3, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_silver", {
	description = S("Silver Boots"),
	inventory_image = "lottarmor_inv_boots_silver.png",
	groups = {armor_feet=12, armor_heal=3, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

--Gold Armor
minetest.register_tool("lottarmor:helmet_gold", {
	description = S("Gold Helmet"),
	inventory_image = "lottarmor_inv_helmet_gold.png",
	groups = {armor_head=10, armor_heal=6, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_gold", {
	description = S("Gold Chestplate"),
	inventory_image = "lottarmor_inv_chestplate_gold.png",
	groups = {armor_torso=15, armor_heal=6, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_gold", {
	description = S("Gold Leggings"),
	inventory_image = "lottarmor_inv_leggings_gold.png",
	groups = {armor_legs=15, armor_heal=6, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_gold", {
	description = S("Gold Boots"),
	inventory_image = "lottarmor_inv_boots_gold.png",
	groups = {armor_feet=10, armor_heal=6, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

--Galvorn Armor
minetest.register_tool("lottarmor:helmet_galvorn", {
	description = S("Galvorn Helmet"),
	inventory_image = "lottarmor_inv_helmet_galvorn.png",
	groups = {armor_head=15, armor_heal=12, armor_use=100, armor_healing=0, physics_speed=-0.1, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_galvorn", {
	description = S("Galvorn Chestplate"),
	inventory_image = "lottarmor_inv_chestplate_galvorn.png",
	groups = {armor_torso=20, armor_heal=12, armor_use=100, armor_healing=0, physics_speed=-0.1, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_galvorn", {
	description = S("Galvorn Leggings"),
	inventory_image = "lottarmor_inv_leggings_galvorn.png",
	groups = {armor_legs=20, armor_heal=12, armor_use=100, armor_healing=0, physics_speed=-0.1, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_galvorn", {
	description = S("Galvorn Boots"),
	inventory_image = "lottarmor_inv_boots_galvorn.png",
	groups = {armor_feet=15, armor_heal=12, armor_use=100, armor_healing=0, physics_speed=-0.1, forbidden=1},
	wear = 0,
})

--Mithril Armor
minetest.register_tool("lottarmor:helmet_mithril", {
	description = S("Mithril Helmet"),
	inventory_image = "lottarmor_inv_helmet_mithril.png",
	groups = {armor_head=15, armor_heal=12, armor_use=50, armor_healing=0, physics_speed=-0.1},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_mithril", {
	description = S("Mithril Chestplate"),
	inventory_image = "lottarmor_inv_chestplate_mithril.png",
	groups = {armor_torso=20, armor_heal=12, armor_use=50, armor_healing=0, physics_speed=-0.1},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_mithril", {
	description = S("Mithril Leggings"),
	inventory_image = "lottarmor_inv_leggings_mithril.png",
	groups = {armor_legs=20, armor_heal=12, armor_use=50, armor_healing=0, physics_speed=-0.1},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_mithril", {
	description = S("Mithril Boots"),
	inventory_image = "lottarmor_inv_boots_mithril.png",
	groups = {armor_feet=15, armor_heal=12, armor_use=50, armor_healing=0, physics_speed=-0.1},
	wear = 0,
})

-- Register Craft Recipes

local craft_ingreds = {
	wood = "group:wood",
	tin = "lottores:tin_ingot",
	copper = "default:copper_ingot",
	steel = "default:steel_ingot",
	bronze = "default:bronze_ingot",
	silver = "lottores:silver_ingot",
	gold = "default:gold_ingot",
	galvorn = "lottores:galvorn_ingot",
	mithril = "lottores:mithril_ingot",
}

for k, v in pairs(craft_ingreds) do
	minetest.register_craft({
		output = "lottarmor:helmet_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{"", "", ""},
		},
	})
	
	minetest.register_craft({
		type = "cooking",
		cooktime = 30,
		output = v.." 2",
		recipe = "lottarmor:helmet_"..k,
	})
	
	minetest.register_craft({
		output = "lottarmor:chestplate_"..k,
		recipe = {
			{v, "", v},
			{v, v, v},
			{v, v, v},
		},
	})
	
	minetest.register_craft({
		type = "cooking",
		cooktime = 30,
		output = v.." 5",
		recipe = "lottarmor:chestplate_"..k,
	})
	
	minetest.register_craft({
		output = "lottarmor:leggings_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{v, "", v},
		},
	})
	
	minetest.register_craft({
		type = "cooking",
		cooktime = 30,
		output = v.." 3",
		recipe = "lottarmor:leggings_"..k,
	})
	
	minetest.register_craft({
		output = "lottarmor:boots_"..k,
		recipe = {
			{v, "", v},
			{v, "", v},
		},
	})
	
	minetest.register_craft({
		type = "cooking",
		cooktime = 30,
		output = v.." 1",
		recipe = "lottarmor:boots_"..k,
	})
end
