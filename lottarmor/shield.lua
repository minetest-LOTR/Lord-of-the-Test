-- Regisiter lottarmor

minetest.register_tool("lottarmor:shield_copper", {
	description = "Copper Shield",
	inventory_image = "lottarmor_inv_shield_copper.png",
	groups = {armor_shield=5, armor_heal=0, armor_use=1750},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_tin", {
	description = "Tin Shield",
	inventory_image = "lottarmor_inv_shield_tin.png",
	groups = {armor_shield=5, armor_heal=0, armor_use=1750},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_steel", {
	description = "Steel Shield",
	inventory_image = "lottarmor_inv_shield_steel.png",
	groups = {armor_shield=10, armor_heal=0, armor_use=1250},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_bronze", {
	description = "Bronze Shield",
	inventory_image = "lottarmor_inv_shield_bronze.png",
	groups = {armor_shield=12, armor_heal=6, armor_use=750},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_silver", {
	description = "Silver Shield",
	inventory_image = "lottarmor_inv_shield_silver.png",
	groups = {armor_shield=15, armor_heal=6, armor_use=1000},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_gold", {
	description = "Gold Shield",
	inventory_image = "lottarmor_inv_shield_gold.png",
	groups = {armor_shield=15, armor_heal=12, armor_use=500},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_galvorn", {
	description = "Galvorn Shield",
	inventory_image = "lottarmor_inv_shield_galvorn.png",
	groups = {armor_shield=15, armor_heal=12, armor_use=250},
	wear = 0,
})

minetest.register_tool("lottarmor:shield_mithril", {
	description = "Mithril Shield",
	inventory_image = "lottarmor_inv_shield_mithril.png",
	groups = {armor_shield=25, armor_heal=12, armor_use=100},
	wear = 0,
})

local craft_ingreds = {
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
	armor.formspec = "size[8,8.5]button[0,0;2,0.5;main;Back]"
		.."list[current_player;main;0,4.5;8,4;]"
		.."list[detached:player_name_armor;armor_head;3,0;1,1;]"
		.."list[detached:player_name_armor;armor_torso;3,1;1,1;]"
		.."list[detached:player_name_armor;armor_legs;3,2;1,1;]"
		.."list[detached:player_name_armor;armor_feet;3,3;1,1;]"
		.."list[detached:player_name_armor;armor_shield;4,1;1,1;]"
end)

