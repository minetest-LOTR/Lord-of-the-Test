dofile(minetest.get_modpath("curwe").."/armor/armor_api.lua")
dofile(minetest.get_modpath("curwe").."/armor/shield.lua")
dofile(minetest.get_modpath("curwe").."/armor/wieldview.lua")

-- Wood Armor
minetest.register_tool("curwe:helmet_wood", {
	description = "Training Helmet",
	inventory_image = "curwe_inv_helmet_wood.png",
	groups = {armor_head=2.5, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=0.2},
	wear = 0,
})

minetest.register_tool("curwe:chestplate_wood", {
	description = "Training Chestplate",
	inventory_image = "curwe_inv_chestplate_wood.png",
	groups = {armor_torso=5, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=0.2},
	wear = 0,
})

minetest.register_tool("curwe:leggings_wood", {
	description = "Training Leggings",
	inventory_image = "curwe_inv_leggings_wood.png",
	groups = {armor_legs=2.5, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=0.2},
	wear = 0,
})

minetest.register_tool("curwe:boots_wood", {
	description = "Training Boots",
	inventory_image = "curwe_inv_boots_wood.png",
	groups = {armor_feet=2.5, armor_heal=0, armor_use=2100, armor_healing=0, physics_speed=0.2},
	wear = 0,
})

-- Tin Armor
minetest.register_tool("curwe:helmet_tin", {
	description = "Tin Helmet",
	inventory_image = "curwe_inv_helmet_tin.png",
	groups = {armor_head=5, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:chestplate_tin", {
	description = "Tin Chestplate",
	inventory_image = "curwe_inv_chestplate_tin.png",
	groups = {armor_torso=10, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:leggings_tin", {
	description = "Tin Leggings",
	inventory_image = "curwe_inv_leggings_tin.png",
	groups = {armor_legs=5, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:boots_tin", {
	description = "Tin Boots",
	inventory_image = "curwe_inv_boots_tin.png",
	groups = {armor_feet=5, armor_heal=0, armor_use=2000, armor_healing=0},
	wear = 0,
})

--Copper Armor
minetest.register_tool("curwe:helmet_copper", {
	description = "Copper Helmet",
	inventory_image = "curwe_inv_helmet_copper.png",
	groups = {armor_head=5, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:chestplate_copper", {
	description = "Copper Chestplate",
	inventory_image = "curwe_inv_chestplate_copper.png",
	groups = {armor_torso=10, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:leggings_copper", {
	description = "Copper Leggings",
	inventory_image = "curwe_inv_leggings_copper.png",
	groups = {armor_legs=5, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:boots_copper", {
	description = "Copper Boots",
	inventory_image = "curwe_inv_boots_copper.png",
	groups = {armor_feet=5, armor_heal=0, armor_use=2000, armor_healing=0},
	wear = 0,
})

--Steel Armor
minetest.register_tool("curwe:helmet_steel", {
	description = "Steel Helmet",
	inventory_image = "curwe_inv_helmet_steel.png",
	groups = {armor_head=10, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:chestplate_steel", {
	description = "Steel Chestplate",
	inventory_image = "curwe_inv_chestplate_steel.png",
	groups = {armor_torso=15, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:leggings_steel", {
	description = "Steel Leggings",
	inventory_image = "curwe_inv_leggings_steel.png",
	groups = {armor_legs=15, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:boots_steel", {
	description = "Steel Boots",
	inventory_image = "curwe_inv_boots_steel.png",
	groups = {armor_feet=10, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

--Bronze Armor
minetest.register_tool("curwe:helmet_bronze", {
	description = "Bronze Helmet",
	inventory_image = "curwe_inv_helmet_bronze.png",
	groups = {armor_head=10, armor_heal=6, armor_use=250, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:chestplate_bronze", {
	description = "Bronze Chestplate",
	inventory_image = "curwe_inv_chestplate_bronze.png",
	groups = {armor_torso=15, armor_heal=6, armor_use=250, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:leggings_bronze", {
	description = "Bronze Leggings",
	inventory_image = "curwe_inv_leggings_bronze.png",
	groups = {armor_legs=15, armor_heal=6, armor_use=250, armor_healing=0},
	wear = 0,
})

minetest.register_tool("curwe:boots_bronze", {
	description = "Bronze Boots",
	inventory_image = "curwe_inv_boots_bronze.png",
	groups = {armor_feet=10, armor_heal=6, armor_use=250, armor_healing=0},
	wear = 0,
})


--Silver Armor
minetest.register_tool("curwe:helmet_silver", {
	description = "Silver Helmet",
	inventory_image = "curwe_inv_helmet_silver.png",
	groups = {armor_head=12, armor_heal=3, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("curwe:chestplate_silver", {
	description = "Silver Chestplate",
	inventory_image = "curwe_inv_chestplate_silver.png",
	groups = {armor_torso=17, armor_heal=3, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("curwe:leggings_silver", {
	description = "Silver Leggings",
	inventory_image = "curwe_inv_leggings_silver.png",
	groups = {armor_legs=17, armor_heal=3, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("curwe:boots_silver", {
	description = "Silver Boots",
	inventory_image = "curwe_inv_boots_silver.png",
	groups = {armor_feet=12, armor_heal=3, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

--Gold Armor
minetest.register_tool("curwe:helmet_gold", {
	description = "Gold Helmet",
	inventory_image = "curwe_inv_helmet_gold.png",
	groups = {armor_head=10, armor_heal=6, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("curwe:chestplate_gold", {
	description = "Gold Chestplate",
	inventory_image = "curwe_inv_chestplate_gold.png",
	groups = {armor_torso=15, armor_heal=6, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("curwe:leggings_gold", {
	description = "Gold Leggings",
	inventory_image = "curwe_inv_leggings_gold.png",
	groups = {armor_legs=15, armor_heal=6, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("curwe:boots_gold", {
	description = "Gold Boots",
	inventory_image = "curwe_inv_boots_gold.png",
	groups = {armor_feet=10, armor_heal=6, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

--Galvorn Armor
minetest.register_tool("curwe:helmet_galvorn", {
	description = "Galvorn Helmet",
	inventory_image = "curwe_inv_helmet_galvorn.png",
	groups = {armor_head=15, armor_heal=12, armor_use=100, armor_healing=0, physics_speed=-0.1, forbidden=1},
	wear = 0,
})

minetest.register_tool("curwe:chestplate_galvorn", {
	description = "Galvorn Chestplate",
	inventory_image = "curwe_inv_chestplate_galvorn.png",
	groups = {armor_torso=20, armor_heal=12, armor_use=100, armor_healing=0, physics_speed=-0.1, forbidden=1},
	wear = 0,
})

minetest.register_tool("curwe:leggings_galvorn", {
	description = "Galvorn Leggings",
	inventory_image = "curwe_inv_leggings_galvorn.png",
	groups = {armor_legs=20, armor_heal=12, armor_use=100, armor_healing=0, physics_speed=-0.1, forbidden=1},
	wear = 0,
})

minetest.register_tool("curwe:boots_galvorn", {
	description = "Galvorn Boots",
	inventory_image = "curwe_inv_boots_galvorn.png",
	groups = {armor_feet=15, armor_heal=12, armor_use=100, armor_healing=0, physics_speed=-0.1, forbidden=1},
	wear = 0,
})

--Mithril Armor
minetest.register_tool("curwe:helmet_mithril", {
	description = "Mithril Helmet",
	inventory_image = "curwe_inv_helmet_mithril.png",
	groups = {armor_head=15, armor_heal=12, armor_use=50, armor_healing=0, physics_speed=-0.1},
	wear = 0,
})

minetest.register_tool("curwe:chestplate_mithril", {
	description = "Mithril Chestplate",
	inventory_image = "curwe_inv_chestplate_mithril.png",
	groups = {armor_torso=20, armor_heal=12, armor_use=50, armor_healing=0, physics_speed=-0.1},
	wear = 0,
})

minetest.register_tool("curwe:leggings_mithril", {
	description = "Mithril Leggings",
	inventory_image = "curwe_inv_leggings_mithril.png",
	groups = {armor_legs=20, armor_heal=12, armor_use=50, armor_healing=0, physics_speed=-0.1},
	wear = 0,
})

minetest.register_tool("curwe:boots_mithril", {
	description = "Mithril Boots",
	inventory_image = "curwe_inv_boots_mithril.png",
	groups = {armor_feet=15, armor_heal=12, armor_use=50, armor_healing=0, physics_speed=-0.1},
	wear = 0,
})

-- Register Craft Recipes

local craft_ingreds = {
	wood = "group:wood",
	tin = "cemen:tin_ingot",
	copper = "default:copper_ingot",
	steel = "default:steel_ingot",
	bronze = "default:bronze_ingot",
	silver = "cemen:silver_ingot",
	gold = "default:gold_ingot",
	galvorn = "cemen:galvorn_ingot",
	mithril = "cemen:mithril_ingot",
}

for k, v in pairs(craft_ingreds) do
	minetest.register_craft({
		output = "curwe:helmet_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "curwe:chestplate_"..k,
		recipe = {
			{v, "", v},
			{v, v, v},
			{v, v, v},
		},
	})
	minetest.register_craft({
		output = "curwe:leggings_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{v, "", v},
		},
	})
	minetest.register_craft({
		output = "curwe:boots_"..k,
		recipe = {
			{v, "", v},
			{v, "", v},
		},
	})
end