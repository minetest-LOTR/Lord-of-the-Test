-- Keep these for backwards compatibility
function hud.save_hunger(player)
	hud.set_hunger(player)
end
function hud.load_hunger(player)
	hud.get_hunger(player)
end

-- Poison player
local function poisenp(tick, time, time_left, player)
	time_left = time_left + tick
	if time_left < time then
		minetest.after(tick, poisenp, tick, time, time_left, player)
	end
	if player:get_hp()-1 > 0 then
		player:set_hp(player:get_hp()-1)
	end
	
end

function hud.item_eat(hunger_change, replace_with_item, poisen)
	return function(itemstack, user, pointed_thing)
		if itemstack:take_item() ~= nil and user ~= nil then
			local name = user:get_player_name()
			local h = tonumber(hud.hunger[name])
			h=h+hunger_change
			if h>30 then h=30 end
			hud.hunger[name]=h
			hud.set_hunger(user)
			itemstack:add_item(replace_with_item) -- note: replace_with_item is optional
			--sound:eat
			if poisen then
				poisenp(1.0, poisen, 0, user)
			end
		end
		return itemstack
	end
end

local function overwrite(name, hunger_change, replace_with_item, poisen)
	local tab = minetest.registered_items[name]
	if tab == nil then return end
	tab.on_use = hud.item_eat(hunger_change, replace_with_item, poisen)
	minetest.registered_items[name] = tab
end

overwrite("default:apple", 2)
if minetest.get_modpath("farming") ~= nil then
	overwrite("farming:bread", 4)
end

if minetest.get_modpath("mobs") ~= nil then
	overwrite("mobs:meat", 6)
	overwrite("mobs:meat_raw", 3)
	overwrite("mobs:rat_cooked", 5)
end

if minetest.get_modpath("moretrees") ~= nil then
	overwrite("moretrees:coconut_milk", 1)
	overwrite("moretrees:raw_coconut", 2)
	overwrite("moretrees:acorn_muffin", 3)
	overwrite("moretrees:spruce_nuts", 1)
	overwrite("moretrees:pine_nuts", 1)
	overwrite("moretrees:fir_nuts", 1)
end

if minetest.get_modpath("dwarves") ~= nil then
	overwrite("dwarves:beer", 2)
	overwrite("dwarves:apple_cider", 1)
	overwrite("dwarves:midus", 2)
	overwrite("dwarves:tequila", 2)
	overwrite("dwarves:tequila_with_lime", 2)
	overwrite("dwarves:sake", 2)
end

if minetest.get_modpath("animalmaterials") ~= nil then
	overwrite("animalmaterials:milk", 2)
	overwrite("animalmaterials:meat_raw", 3)
	overwrite("animalmaterials:meat_pork", 3)
	overwrite("animalmaterials:meat_beef", 3)
	overwrite("animalmaterials:meat_chicken", 3)
	overwrite("animalmaterials:meat_lamb", 3)
	overwrite("animalmaterials:meat_venison", 3)
	overwrite("animalmaterials:meat_undead", 3, "", 3)
	overwrite("animalmaterials:meat_toxic", 3, "", 5)
	overwrite("animalmaterials:meat_ostrich", 3)
	overwrite("animalmaterials:fish_bluewhite", 2)
	overwrite("animalmaterials:fish_clownfish", 2)
end

if minetest.get_modpath("fishing") ~= nil then
	overwrite("fishing:fish_raw", 2)
	overwrite("fishing:fish", 4)
	overwrite("fishing:sushi", 6)
	overwrite("fishing:shark", 4)
	overwrite("fishing:shark_cooked", 8)
	overwrite("fishing:pike", 4)
	overwrite("fishing:pike_cooked", 8)
end

if minetest.get_modpath("glooptest") ~= nil then
	overwrite("glooptest:kalite_lump", 1)
end

if minetest.get_modpath("bushes") ~= nil then
	overwrite("bushes:sugar", 1)
	overwrite("bushes:strawberry", 2)
	overwrite("bushes:berry_pie_raw", 3)
	overwrite("bushes:berry_pie_cooked", 4)
	overwrite("bushes:basket_pies", 15)
end

if minetest.get_modpath("bushes_classic") then
	-- bushes_classic mod, as found in the plantlife modpack
	local berries = {
	    "strawberry",
		"blackberry",
		"blueberry",
		"raspberry",
		"gooseberry",
		"mixed_berry"}
	for _, berry in ipairs(berries) do
		if berry ~= "mixed_berry" then
			overwrite("bushes:"..berry, 1)
		end
		overwrite("bushes:"..berry.."_pie_raw", 2)
		overwrite("bushes:"..berry.."_pie_cooked", 5)
		overwrite("bushes:basket_"..berry, 15)
	end
end

if minetest.get_modpath("mushroom") ~= nil then
	overwrite("mushroom:brown", 1)
	overwrite("mushroom:red", 1, "", 3)
end

if minetest.get_modpath("docfarming") ~= nil then
	overwrite("docfarming:carrot", 2)
	overwrite("docfarming:cucumber", 2)
	overwrite("docfarming:corn", 2)
	overwrite("docfarming:potato", 4)
	overwrite("docfarming:bakedpotato", 5)
	overwrite("docfarming:raspberry", 3)
end

if minetest.get_modpath("farming_plus") ~= nil then
	overwrite("farming_plus:carrot_item", 3)
	overwrite("farming_plus:banana", 2)
	overwrite("farming_plus:orange_item", 2)
	overwrite("farming:pumpkin_bread", 4)
	overwrite("farming_plus:strawberry_item", 2)
	overwrite("farming_plus:tomato_item", 2)
	overwrite("farming_plus:potato_item", 4)
	overwrite("farming_plus:rhubarb_item", 2)
end

if minetest.get_modpath("mtfoods") ~= nil then
	overwrite("mtfoods:dandelion_milk", 1)
	overwrite("mtfoods:sugar", 1)
	overwrite("mtfoods:short_bread", 4)
	overwrite("mtfoods:cream", 1)
	overwrite("mtfoods:chocolate", 2)
	overwrite("mtfoods:cupcake", 2)
	overwrite("mtfoods:strawberry_shortcake", 2)
	overwrite("mtfoods:cake", 3)
	overwrite("mtfoods:chocolate_cake", 3)
	overwrite("mtfoods:carrot_cake", 3)
	overwrite("mtfoods:pie_crust", 3)
	overwrite("mtfoods:apple_pie", 3)
	overwrite("mtfoods:rhubarb_pie", 2)
	overwrite("mtfoods:banana_pie", 3)
	overwrite("mtfoods:pumpkin_pie", 3)
	overwrite("mtfoods:cookies", 2)
	overwrite("mtfoods:mlt_burger", 5)
	overwrite("mtfoods:potato_slices", 2)
	overwrite("mtfoods:potato_chips", 3)
	--mtfoods:medicine
	overwrite("mtfoods:casserole", 3)
	overwrite("mtfoods:glass_flute", 2)
	overwrite("mtfoods:orange_juice", 2)
	overwrite("mtfoods:apple_juice", 2)
	overwrite("mtfoods:apple_cider", 2)
	overwrite("mtfoods:cider_rack", 2)
end

if minetest.get_modpath("fruit") ~= nil then
	overwrite("fruit:apple", 2)
	overwrite("fruit:pear", 2)
	overwrite("fruit:bananna", 3)
	overwrite("fruit:orange", 2)
end

if minetest.get_modpath("mush45") ~= nil then
	overwrite("mush45:meal", 4)
end

if minetest.get_modpath("seaplants") ~= nil then
	overwrite("seaplants:kelpgreen", 1)
	overwrite("seaplants:kelpbrown", 1)
	overwrite("seaplants:seagrassgreen", 1)
	overwrite("seaplants:seagrassred", 1)
	overwrite("seaplants:seasaladmix", 6)
	overwrite("seaplants:kelpgreensalad", 1)
	overwrite("seaplants:kelpbrownsalad", 1)
	overwrite("seaplants:seagrassgreensalad", 1)
	overwrite("seaplants:seagrassgreensalad", 1)
end

if minetest.get_modpath("mobfcooking") ~= nil then
	overwrite("mobfcooking:cooked_pork", 6)
	overwrite("mobfcooking:cooked_ostrich", 6)
	overwrite("mobfcooking:cooked_beef", 6)
	overwrite("mobfcooking:cooked_chicken", 6)
	overwrite("mobfcooking:cooked_lamb", 6)
	overwrite("mobfcooking:cooked_venison", 6)
	overwrite("mobfcooking:cooked_fish", 6)
end

if minetest.get_modpath("lottfarming") ~= nil then
	overwrite("lottfarming:barley", 4)
	overwrite("lottfarming:berries", 2)
	overwrite("lottfarming:blue_mushroom", 3)
	overwrite("lottfarming:brown_mushroom", 4)
	overwrite("lottfarming:cabbage", 4)
	overwrite("lottfarming:corn", 6)
	overwrite("lottfarming:green_mushroom", 3)
	overwrite("lottfarming:melon", 4)
	overwrite("lottfarming:potato", 1)
	overwrite("lottfarming:potato_cooked", 8)
	overwrite("lottfarming:red_mushroom", 4)
	overwrite("lottfarming:tomatoes", 2)
	overwrite("lottfarming:tomatoes_cooked", 4)
	overwrite("lottfarming:tomato_soup", 8)
	overwrite("lottfarming:turnips", 1)
	overwrite("lottfarming:turnips_cooked", 8)
	overwrite("lottfarming:salad", 6)
	overwrite("lottfarming:mushroom_soup", 8)
end

if minetest.get_modpath("lottplants") ~= nil then
	overwrite("lottplants:plum", 2)
	overwrite("lottplants:yavannamirefruit", 10)
	overwrite("lottplants:honey", 2)
end
