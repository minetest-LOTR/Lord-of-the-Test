-- Register Shields
minetest.register_tool("lottarmor:shield_wood", {
	description = "Training Shield",
	inventory_image = "lottarmor_inv_shield_wood.png",
	groups = {armor_head=2.5, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=0.2},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_tin", {
	description = "Tin Shield",
	inventory_image = "lottarmor_inv_shield_tin.png",
	groups = {armor_shield=5, armor_heal=0, armor_use=1750, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_copper", {
	description = "Copper Shield",
	inventory_image = "lottarmor_inv_shield_copper.png",
	groups = {armor_shield=5, armor_heal=0, armor_use=1750, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_steel", {
	description = "Steel Shield",
	inventory_image = "lottarmor_inv_shield_steel.png",
	groups = {armor_shield=10, armor_heal=0, armor_use=1250, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_bronze", {
	description = "Bronze Shield",
	inventory_image = "lottarmor_inv_shield_bronze.png",
	groups = {armor_shield=12, armor_heal=6, armor_use=750, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_silver", {
	description = "Silver Shield",
	inventory_image = "lottarmor_inv_shield_silver.png",
	groups = {armor_shield=15, armor_heal=6, armor_use=1000, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_gold", {
	description = "Gold Shield",
	inventory_image = "lottarmor_inv_shield_gold.png",
	groups = {armor_shield=15, armor_heal=12, armor_use=500, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_galvorn", {
	description = "Galvorn Shield",
	inventory_image = "lottarmor_inv_shield_galvorn.png",
	groups = {armor_shield=15, armor_heal=12, armor_use=250, armor_healing=0, physics_speed=-0.1, physics_sneak=-1, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_mithril", {
	description = "Mithril Shield",
	inventory_image = "lottarmor_inv_shield_mithril.png",
	groups = {armor_shield=25, armor_heal=12, armor_use=100, armor_healing=0, physics_speed=-0.1, physics_sneak=-1},
	wear = 0,
})

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
		output = "lottarmor:shield_"..k,
		recipe = {
			{v, v, v},
			{v, v, v},
			{"", v, ""},
		},
	})
end

minetest.after(0, function()
	table.insert(armor.elements, "shield")
end)