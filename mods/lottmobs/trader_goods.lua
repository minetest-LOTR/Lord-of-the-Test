--Item table format:
--{thing selling, price (in gold ingots), chance that it won't appear in the trader's inventory}

lottmobs.dwarf = {
	items = {
		{"lottthrowing:crossbow_silver 1", "default:gold_ingot 9", 15},
		{"lottarmor:chestplate_mithril 1", "default:gold_ingot 75", 50},
		{"default:steel_ingot 99", "default:gold_ingot 25", 12},
		{"lottores:silversword 1", "default:gold_ingot 7", 10},
		{"default:bronze_ingot 25", "default:gold_ingot 5", 15},
		{"lottblocks:small_lamp_pine 6", "default:gold_ingot 2", 6},
		{"lottblocks:dwarf_harp 1", "default:gold_ingot 15", 10},
		{"lottweapons:mithril_dagger 1", "default:gold_ingot 15", 20},
		{"lottores:mithrilsword 1", "default:gold_ingot 35", 30},
		{"default:sword_steel 1", "default:gold_ingot 5", 10},
		{"lottweapons:silver_battleaxe 1", "default:gold_ingot 10", 18},
		{"lottblocks:dwarfstone_stripe 50", "default:gold_ingot 17", 12},
		{"lottblocks:dwarfstone_black 99", "default:gold_ingot 33", 17},
		{"default:stonebrick 99", "default:gold_ingot 25", 14},
		{"lottblocks:dwarfstone_white 99", "default:gold_ingot 33", 17},
	},
	items_race = {
		{"lottthrowing:crossbow_silver 1", "default:gold_ingot 7", 15},
		{"lottarmor:chestplate_mithril 1", "default:gold_ingot 72", 50},
		{"default:steel_ingot 99", "default:gold_ingot 22", 12},
		{"lottores:silversword 1", "default:gold_ingot 5", 10},
		{"default:bronze_ingot 25", "default:gold_ingot 4", 15},
		{"lottblocks:small_lamp_pine 6", "default:gold_ingot 2", 6},
		{"lottblocks:dwarf_harp 1", "default:gold_ingot 12", 10},
		{"lottweapons:mithril_dagger 1", "default:gold_ingot 14", 20},
		{"lottores:mithrilsword 1", "default:gold_ingot 32", 30},
		{"default:sword_steel 1", "default:gold_ingot 4", 10},
		{"lottweapons:silver_battleaxe 1", "default:gold_ingot 9", 18},
		{"lottblocks:dwarfstone_stripe 50", "default:gold_ingot 14", 12},
		{"lottblocks:dwarfstone_black 99", "default:gold_ingot 30", 17},
		{"default:stonebrick 99", "default:gold_ingot 22", 14},
		{"lottblocks:dwarfstone_white 99", "default:gold_ingot 30", 17},
	},
	names = {
		"Azaghâl", "Balbrin", "Borin", "Farin", "Flói", "Frerin",
		"Grór", "Lóni", "Náli", "Narvi", "Telchar", "Thion"
	}
}

lottmobs.elf = {
	items = {
		{"lottplants:mallorntree 10", "default:gold_ingot 4", 5},
		{"lottores:rough_rock 4", "default:gold_ingot 30", 17},
		{"lottother:blue_torch 10", "default:gold_ingot 20", 15},
		{"lottweapons:galvorn_spear 1", "default:gold_ingot 25", 20},
		{"lottweapons:silver_battleaxe 1", "default:gold_ingot 18", 14},
		{"lottores:galvornsword 1", "default:gold_ingot 23", 25},
		{"lottplants:elanor 10", "default:gold_ingot 2", 22},
		{"lottarmor:chestplate_galvorn 1", "default:gold_ingot 40", 25},
		{"lottarmor:helmet_galvorn 1", "default:gold_ingot 30", 25},
		{"lottarmor:boots_galvorn 1", "default:gold_ingot 25", 25},
		{"lottarmor:leggings_galvorn 1", "default:gold_ingot 35", 25},
		{"lottplants:niphredil 12", "default:gold_ingot 3", 14},
		{"lottblocks:mallorn_pillar 30", "default:gold_ingot 7", 4},
		{"lottplants:mallornsapling 3", "default:gold_ingot 2", 17},
		{"lottplants:mallornwood 99", "default:gold_ingot 10", 5},
	},
	items_race = {
		{"lottplants:mallorntree 10", "default:gold_ingot 4", 5},
		{"lottores:rough_rock 4", "default:gold_ingot 28", 17},
		{"lottother:blue_torch 10", "default:gold_ingot 18", 15},
		{"lottweapons:galvorn_spear 1", "default:gold_ingot 22", 20},
		{"lottweapons:silver_battleaxe 1", "default:gold_ingot 15", 14},
		{"lottores:galvornsword 1", "default:gold_ingot 21", 25},
		{"lottplants:elanor 10", "default:gold_ingot 2", 22},
		{"lottarmor:chestplate_galvorn 1", "default:gold_ingot 37", 25},
		{"lottarmor:helmet_galvorn 1", "default:gold_ingot 28", 25},
		{"lottarmor:boots_galvorn 1", "default:gold_ingot 23", 25},
		{"lottarmor:leggings_galvorn 1", "default:gold_ingot 32", 25},
		{"lottplants:niphredil 12", "default:gold_ingot 3", 14},
		{"lottblocks:mallorn_pillar 30", "default:gold_ingot 6", 4},
		{"lottplants:mallornsapling 3", "default:gold_ingot 2", 17},
		{"lottplants:mallornwood 99", "default:gold_ingot 8", 5},
	},
	names = {
		"Annael", "Anairë", "Curufin", "Erestor", "Gwindor", "Irimë",
		"Oropher", "Maglor", "Quennar", "Rúmil", "Orgof", "Voronwë"
	}
}

lottmobs.hobbit = {
	items = {
		{"lottfarming:pipe 1", "default:gold_ingot 2", 5},
		{"lottfarming:pipeweed_cooked 50", "default:gold_ingot 17", 10},
		{"lottpotion:beer " .. math.random(5, 15), "default:gold_ingot 7", 8},
		{"lottpotion:cider " .. math.random(10, 20), "default:gold_ingot 11", 13},
		{"lottpotion:wine " .. math.random(5, 10), "default:gold_ingot 18", 14},
		{"lottfarming:tomatoes " .. math.random(20, 30), "default:gold_ingot 23", 25},
		{"lottfarming:potato " .. math.random(25, 35), "default:gold_ingot 10", 22},
		{"lottfarming:brown_mushroom ".. math.random(40, 45), "default:gold_ingot 40", 25},
		{"lottfarming:corn_seed 12", "default:gold_ingot 30", 25},
		{"farming:hoe_bronze 1", "default:gold_ingot 25", 25},
		{"lottinventory:brewing_book 1", "default:gold_ingot 35", 25},
		{"lottfarming:barley_seed " .. math.random(5, 10), "default:gold_ingot 3", 14},
		{"lottfarming:berries " .. math.random(15, 20), "default:gold_ingot 7", 4},
		{"lottplants:firsapling 2", "default:gold_ingot 2", 17},
		{"default:apple " .. math.random(5, 20), "default:gold_ingot 10", 5},
	},
	items_race = {
		{"lottfarming:pipe 1", "default:gold_ingot 2", 5},
		{"lottfarming:pipeweed_cooked 50", "default:gold_ingot 14", 10},
		{"lottpotion:beer " .. math.random(5, 15), "default:gold_ingot 5", 8},
		{"lottpotion:cider " .. math.random(10, 20), "default:gold_ingot 9", 13},
		{"lottpotion:wine " .. math.random(5, 10), "default:gold_ingot 16", 14},
		{"lottfarming:tomatoes " .. math.random(20, 30), "default:gold_ingot 20", 25},
		{"lottfarming:potato " .. math.random(25, 35), "default:gold_ingot 7", 22},
		{"lottfarming:brown_mushroom ".. math.random(40, 45), "default:gold_ingot 35", 25},
		{"lottfarming:corn_seed 12", "default:gold_ingot 27", 25},
		{"farming:hoe_bronze 1", "default:gold_ingot 22", 25},
		{"lottinventory:brewing_book 1", "default:gold_ingot 32", 25},
		{"lottfarming:barley_seed " .. math.random(5, 10), "default:gold_ingot 3", 14},
		{"lottfarming:berries " .. math.random(15, 20), "default:gold_ingot 6", 4},
		{"lottplants:firsapling 2", "default:gold_ingot 2", 17},
		{"default:apple " .. math.random(5, 20), "default:gold_ingot 8", 5},
	},
	names = {
		"Adalgrim", "Bodo", "Cotman", "Doderic", "Falco", "Gormadoc",
		"Hobson", "Ilberic", "Largo", "Madoc", "Orgulas", "Rorimac"
	}
}

lottmobs.human = {
	items = {
		{"default:sandstone 40", "default:gold_ingot 10", 12},
		{"boats:sail_boat 1", "default:gold_ingot 4", 14},
		{"lottarmor:shield_bronze 1", "default:gold_ingot 20", 20},
		{"farming:bread 12", "default:gold_ingot 2", 5},
		{"lottblocks:marble_brick 35", "default:gold_ingot 12", 10},
		{"default:desert_stone 30", "default:gold_ingot 8", 12},
		{"lottblocks:lamp_alder 5", "default:gold_ingot 4", 8},
		{"lottarmor:chestplate_bronze 1", "default:gold_ingot 30", 30},
		{"lottarmor:boots_bronze 1", "default:gold_ingot 12", 18},
		{"lottblocks:lamp_lebethron 7", "default:gold_ingot 6", 11},
		{"lottblocks:door_alder 6", "default:gold_ingot 2", 18},
		{"lottores:marble 99", "default:gold_ingot 33", 18},
		{"lottarmor:helmet_bronze 1", "default:gold_ingot 20", 24},
		{"default:brick 30", "default:gold_ingot 10", 17},
		{"lottarmor:leggings_bronze 1", "default:gold_ingot 25", 34},
	},
	items_race = {
		{"default:sandstone 40", "default:gold_ingot 8", 12},
		{"boats:sail_boat 1", "default:gold_ingot 3", 14},
		{"lottarmor:shield_bronze 1", "default:gold_ingot 18", 20},
		{"farming:bread 12", "default:gold_ingot 2", 5},
		{"lottblocks:marble_brick 35", "default:gold_ingot 11", 10},
		{"default:desert_stone 30", "default:gold_ingot 7", 12},
		{"lottblocks:lamp_alder 5", "default:gold_ingot 3", 8},
		{"lottarmor:chestplate_bronze 1", "default:gold_ingot 27", 30},
		{"lottarmor:boots_bronze 1", "default:gold_ingot 10", 18},
		{"lottblocks:lamp_lebethron 7", "default:gold_ingot 5", 11},
		{"lottblocks:door_alder 6", "default:gold_ingot 2", 18},
		{"lottores:marble 99", "default:gold_ingot 30", 18},
		{"lottarmor:helmet_bronze 1", "default:gold_ingot 18", 24},
		{"default:brick 30", "default:gold_ingot 9", 17},
		{"lottarmor:leggings_bronze 1", "default:gold_ingot 21", 34},
	},
	names = {
		"Aratan", "Arvegil", "Belegorn", "Celepharn", "Dúnhere", "Elatan",
		"Gilraen", "Írimon", "Minardil", "Oromendil", "Tarcil", "Vorondil"
	}
}

lottmobs.hiring = "size[8,9]" ..
	"label[0,0;Select the ammout of gold you want to offer:]" ..
	"dropdown[0.5,1;2;offer;1,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,99;1]" ..
	"button_exit[0.5,2;1.5,1;done;Done]"

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "mob_hiring" then return end
	if fields.done then
		if tonumber(fields.offer) then
			local n = tonumber(fields.offer)
			if math.random(1, (50/n)) == 1 then
				minetest.chat_send_all("[NPC] <ABC> Okay, I'll work for you.")
				lottmobs.hire(n)
			else
				minetest.chat_send_all("[NPC] <ABC> Do you really think I'll work for you for that much?!")
			end
		else
			minetest.chat_send_all("Offer must be a number!")
		end
	end
end)
