-- Pickaxes

minetest.register_craft({
	output = 'curwe:copperpick',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:tinpick',
	recipe = {
		{'cemen:tin_ingot', 'cemen:tin_ingot', 'cemen:tin_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:silverpick',
	recipe = {
		{'cemen:silver_ingot', 'cemen:silver_ingot', 'cemen:silver_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:goldpick',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:galvornpick',
	recipe = {
		{'cemen:galvorn_ingot', 'cemen:galvorn_ingot', 'cemen:galvorn_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:mithrilpick',
	recipe = {
		{'cemen:mithril_ingot', 'cemen:mithril_ingot', 'cemen:mithril_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

--Axes

minetest.register_craft({
	output = 'curwe:copperaxe',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:tinaxe',
	recipe = {
		{'cemen:tin_ingot', 'cemen:tin_ingot'},
		{'cemen:tin_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:silveraxe',
	recipe = {
		{'cemen:silver_ingot', 'cemen:silver_ingot'},
		{'cemen:silver_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:goldaxe',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:galvornaxe',
	recipe = {
		{'cemen:galvorn_ingot', 'cemen:galvorn_ingot'},
		{'cemen:galvorn_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:mithrilaxe',
	recipe = {
		{'cemen:mithril_ingot', 'cemen:mithril_ingot'},
		{'cemen:mithril_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

--Swords

minetest.register_craft({
	output = 'curwe:coppersword',
	recipe = {
		{'default:copper_ingot'},
		{'default:copper_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:tinsword',
	recipe = {
		{'cemen:tin_ingot'},
		{'cemen:tin_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:silversword',
	recipe = {
		{'cemen:silver_ingot'},
		{'cemen:silver_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:goldsword',
	recipe = {
		{'default:gold_ingot'},
		{'default:gold_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:galvornsword',
	recipe = {
		{'cemen:galvorn_ingot'},
		{'cemen:galvorn_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:mithrilsword',
	recipe = {
		{'cemen:mithril_ingot'},
		{'cemen:mithril_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:elven_sword',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:bronze_ingot', 'default:steel_ingot', 'default:bronze_ingot'},
		{'default:mese_crystal', 'group:stick', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'curwe:orc_sword',
	recipe = {
		{'', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
		{'', 'group:stick', ''},
	}
})

--Shovels

minetest.register_craft({
	output = 'curwe:coppershovel',
	recipe = {
		{'default:copper_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:tinshovel',
	recipe = {
		{'cemen:tin_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:silvershovel',
	recipe = {
		{'cemen:silver_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:goldshovel',
	recipe = {
		{'default:gold_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:galvornshovel',
	recipe = {
		{'cemen:galvorn_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:mithrilshovel',
	recipe = {
		{'cemen:mithril_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

--Battleaxes

minetest.register_craft({
	output = 'curwe:wood_battleaxe',
	recipe = {
		{'group:wood', 'group:stick', 'group:wood'},
		{'group:wood', 'group:stick', 'group:wood'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:stone_battleaxe',
	recipe = {
		{'default:cobble', 'group:stick', 'default:cobble'},
		{'default:cobble', 'group:stick', 'default:cobble'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:copper_battleaxe',
	recipe = {
		{'default:copper_ingot', 'group:stick', 'default:copper_ingot'},
		{'default:copper_ingot', 'group:stick', 'default:copper_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:tin_battleaxe',
	recipe = {
		{'cemen:tin_ingot', 'group:stick', 'cemen:tin_ingot'},
		{'cemen:tin_ingot', 'group:stick', 'cemen:tin_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:steel_battleaxe',
	recipe = {
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:bronze_battleaxe',
	recipe = {
		{'default:bronze_ingot', 'group:stick', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'group:stick', 'default:bronze_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:silver_battleaxe',
	recipe = {
		{'cemen:silver_ingot', 'group:stick', 'cemen:silver_ingot'},
		{'cemen:silver_ingot', 'group:stick', 'cemen:silver_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:gold_battleaxe',
	recipe = {
		{'default:gold_ingot', 'group:stick', 'default:gold_ingot'},
		{'default:gold_ingot', 'group:stick', 'default:gold_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:galvorn_battleaxe',
	recipe = {
		{'cemen:galvorn_ingot', 'group:stick', 'cemen:galvorn_ingot'},
		{'cemen:galvorn_ingot', 'group:stick', 'cemen:galvorn_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:mithril_battleaxe',
	recipe = {
		{'cemen:mithril_ingot', 'group:stick', 'cemen:mithril_ingot'},
		{'cemen:mithril_ingot', 'group:stick', 'cemen:mithril_ingot'},
		{'', 'group:stick', ''},
	}
})

--War hammers

minetest.register_craft({
	output = 'curwe:wood_warhammer',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'group:stick', 'group:wood'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:stone_warhammer',
	recipe = {
		{'default:cobble', 'default:cobble', 'default:cobble'},
		{'default:cobble', 'group:stick', 'default:cobble'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:copper_warhammer',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'group:stick', 'default:copper_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:tin_warhammer',
	recipe = {
		{'cemen:tin_ingot', 'cemen:tin_ingot', 'cemen:tin_ingot'},
		{'cemen:tin_ingot', 'group:stick', 'cemen:tin_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:steel_warhammer',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:bronze_warhammer',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'group:stick', 'default:bronze_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:silver_warhammer',
	recipe = {
		{'cemen:silver_ingot', 'cemen:silver_ingot', 'cemen:silver_ingot'},
		{'cemen:silver_ingot', 'group:stick', 'cemen:silver_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:gold_warhammer',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'group:stick', 'default:gold_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:galvorn_warhammer',
	recipe = {
		{'cemen:galvorn_ingot', 'cemen:galvorn_ingot', 'cemen:galvorn_ingot'},
		{'cemen:galvorn_ingot', 'group:stick', 'cemen:galvorn_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:mithril_warhammer',
	recipe = {
		{'cemen:mithril_ingot', 'cemen:mithril_ingot', 'cemen:mithril_ingot'},
		{'cemen:mithril_ingot', 'group:stick', 'cemen:mithril_ingot'},
		{'', 'group:stick', ''},
	}
})

-- Spears

minetest.register_craft({
	output = 'curwe:wood_spear',
	recipe = {
		{'', 'group:wood', ''},
		{'group:wood', 'group:stick', 'group:wood'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:stone_spear',
	recipe = {
		{'', 'default:cobble', ''},
		{'default:cobble', 'group:stick', 'default:cobble'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:copper_spear',
	recipe = {
		{'', 'default:copper_ingot', ''},
		{'default:copper_ingot', 'group:stick', 'default:copper_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:tin_spear',
	recipe = {
		{'', 'cemen:tin_ingot', ''},
		{'cemen:tin_ingot', 'group:stick', 'cemen:tin_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:steel_spear',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:bronze_spear',
	recipe = {
		{'', 'default:bronze_ingot', ''},
		{'default:bronze_ingot', 'group:stick', 'default:bronze_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:gold_spear',
	recipe = {
		{'', 'default:gold_ingot', ''},
		{'default:gold_ingot', 'group:stick', 'default:gold_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:silver_spear',
	recipe = {
		{'', 'cemen:silver_ingot', ''},
		{'cemen:silver_ingot', 'group:stick', 'cemen:silver_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:galvorn_spear',
	recipe = {
		{'', 'cemen:galvorn_ingot', ''},
		{'cemen:galvorn_ingot', 'group:stick', 'cemen:galvorn_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'curwe:mithril_spear',
	recipe = {
		{'', 'cemen:mithril_ingot', ''},
		{'cemen:mithril_ingot', 'group:stick', 'cemen:mithril_ingot'},
		{'', 'group:stick', ''},
	}
})

-- Daggers

minetest.register_craft({
	output = 'curwe:wood_dagger',
	recipe = {
		{'group:wood'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:stone_dagger',
	recipe = {
		{'default:cobble'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:copper_dagger',
	recipe = {
		{'default:copper_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:tin_dagger',
	recipe = {
		{'cemen:tin_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:steel_dagger',
	recipe = {
		{'default:steel_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:bronze_dagger',
	recipe = {
		{'default:bronze_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:silver_dagger',
	recipe = {
		{'cemen:silver_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:gold_dagger',
	recipe = {
		{'default:gold_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:galvorn_dagger',
	recipe = {
		{'cemen:galvorn_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'curwe:mithril_dagger',
	recipe = {
		{'cemen:mithril_ingot'},
		{'group:stick'},
	}
})