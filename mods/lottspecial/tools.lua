minetest.register_tool("lottspecial:birthday_paxel", {
	description = "Birthday Paxel",
	inventory_image = "birthday_paxel.png",
	wield_image = "birthday_paxel.png",
	tool_capabilities = {
		full_punch_interval = 0.1,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=500, maxlevel=3},
			crumbly = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=500, maxlevel=3},
			choppy = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=500, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("lottspecial:helmet_birthday", {
	description = "Birthday Helmet",
	inventory_image = "lottspecial_inv_helmet_birthday.png",
	groups = {armor_head=15, armor_heal=12, armor_use=25},
	wear = 0,
})
minetest.register_tool("lottspecial:chestplate_birthday", {
	description = "Birthday Chestplate",
	inventory_image = "lottspecial_inv_chestplate_birthday.png",
	groups = {armor_torso=20, armor_heal=12, armor_use=25},
	wear = 0,
})
minetest.register_tool("lottspecial:leggings_birthday", {
	description = "Birthday Leggings",
	inventory_image = "lottspecial_inv_leggings_birthday.png",
	groups = {armor_legs=20, armor_heal=12, armor_use=25},
	wear = 0,
})
minetest.register_tool("lottspecial:boots_birthday", {
	description = "Birthday Boots",
	inventory_image = "lottspecial_inv_boots_birthday.png",
	groups = {armor_feet=15, armor_heal=12, armor_use=25},
	wear = 0,
})
minetest.register_tool("lottspecial:shield_birthday", {
	description = "Mithril Shield",
	inventory_image = "lottspecial_inv_shield_birthday.png",
	groups = {armor_shield=25, armor_heal=12, armor_use=25},
	wear = 0,
})
