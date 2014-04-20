-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file inventory.lua
--! @brief component containing mob inventory related functions
--! @copyright Sapier
--! @author Sapier
--! @date 2013-01-02
--
--! @defgroup Inventory Inventory subcomponent
--! @brief Component handling mob inventory
--! @ingroup framework_int
--! @{
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(mob_inventory == nil)
--! @class mob_inventory
--! @brief inventory handling for trader like mobs
--! @}
mob_inventory = {}
mob_inventory.trader_inventories = {}
mob_inventory.formspecs = {}

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] allow_move(inv, from_list, from_index, to_list, to_index, count, player)
--
--! @brief check if there is enough at payroll
--! @memberof mob_inventory
--! @private
--
--! @param inv inventory reference
--! @param from_list name of list elements taken
--! @param from_index index at list elements taken
--! @param to_list list name of list elements being put
--! @param to_index index at list elements being put
--! @param count number of elements moved
--! @param player doing changes
--
--! @return number of elements allowed to move
-------------------------------------------------------------------------------
function mob_inventory.allow_move(inv, from_list, from_index, to_list, to_index, count, player)

	dbg_mobf.trader_inv_lvl1("MOBF: move inv: " .. tostring(inv) .. " from:"
		.. dump(from_list) .. " to: " .. dump(to_list))
	if to_list ~= "selection" or
		from_list == "price_1" or
		from_list == "price_2" or
		from_list == "pay" or
		from_list == "takeaway" or
		from_list == "identifier" then
		return 0
	end

	-- forbid moving of parts of stacks
	local old_stack = inv.get_stack(inv, from_list, from_index)
	if count ~= old_stack.get_count(old_stack) then
		return 0;
	end

	return count
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] allow_put(inv, listname, index, stack, player)
--
--! @brief check if there is enough at payroll
--! @memberof mob_inventory
--! @private
--
--! @param inv inventory reference
--! @param listname name of list changed
--! @param index index in list changed
--! @param stack moved
--! @param player doing changes
--
--! @return number of elements allowed to put
-------------------------------------------------------------------------------
function mob_inventory.allow_put(inv, listname, index, stack, player)
	dbg_mobf.trader_inv_lvl1("MOBF: put inv: " .. tostring(inv) .. " to:"
		.. dump(listname))

	if listname == "pay" then
		return 99
	end

	return 0
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] allow_take(inv, listname, index, stack, player)
--
--! @brief check if there is enough at payroll
--! @memberof mob_inventory
--! @private
--
--! @param inv inventory reference
--! @param listname name of list changed
--! @param index index in list changed
--! @param stack moved
--! @param player doing changes
--
--! @return number of elements allowed to take
-------------------------------------------------------------------------------
function mob_inventory.allow_take(inv, listname, index, stack, player)
	dbg_mobf.trader_inv_lvl1("MOBF: take inv: " .. tostring(inv) .. " to:"
		.. dump(listname))

	if listname == "takeaway" or
		listname == "pay" then
		return 99
	end
	return 0
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] on_move(inv, from_list, from_index, to_list, to_index, count, player)
--
--! @brief check if there is enough at payroll
--! @memberof mob_inventory
--! @private
--
--! @param inv inventory reference
--! @param from_list name of list elements taken
--! @param from_index index at list elements taken
--! @param to_list list name of list elements being put
--! @param to_index index at list elements being put
--! @param count number of elements moved
--! @param player doing changes
-------------------------------------------------------------------------------
function mob_inventory.on_move(inv, from_list, from_index, to_list, to_index, count, player)
	dbg_mobf.trader_inv_lvl1("MOBF: inv\"" .. tostring(inv) .. "\" moving "
		.. count .. " items from: " .. from_list .. ":" .. from_index .. " to: "
		.. to_list .. ":" .. to_index)

	if from_list == "goods" and
		to_list == "selection" then

		local moved = inv.get_stack(inv,to_list, to_index)

		local goodname = moved.get_name(moved)
		local elements = moved.get_count(moved)


		-- handle situations where diffrent amounts of the same good are offered-
		dbg_mobf.trader_inv_lvl2("MOBF: moving " .. dump(elements) .."/"
			.. dump(count) .. " from "
			.. dump(from_list).. " to ".. dump(from_list )..
			" at index "..dump(from_index ))

		-- if it was the same type of good (and now contains a summed up number
		-- of offerings) put the old stack back into the traders inv
		if( elements > count ) then
			dbg_mobf.trader_inv_lvl2(
				"MOBF: ok, whe have to give back a stack of "
				..tostring( elements - count ).." "..tostring( goodname )
				..". target stack: "..tostring( from_index ))
			-- remove the surplus parts
			inv.set_stack(inv,"selection", 1,goodname.." "..tostring( count ))
			-- the slot we took from is now free
			inv.set_stack(inv,"goods",from_index,
				goodname.." "..tostring( elements - count ))
			-- update the real amount of items in the slot now
			elements = count
		end

		local entity = mob_inventory.get_entity(inv)

		if entity == nil then
			dbg_mobf.trader_inv_lvl1("MOBF: move unable to find linked entity")
			return
		end

		dbg_mobf.trader_inv_lvl1("MOBF: good selected: " .. goodname)

		--get element put to selection
		mob_inventory.fill_prices(entity,inv,goodname,count)
		mob_inventory.update_takeaway(inv)
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] on_put(inv, listname, index, stack, player)
--
--! @brief check if there is enough at payroll
--! @memberof mob_inventory
--! @private
--
--! @param inv inventory reference
--! @param listname name of list changed
--! @param index index in list changed
--! @param stack moved
--! @param player doing changes
-------------------------------------------------------------------------------
function mob_inventory.on_put(inv, listname, index, stack, player)
	if listname == "pay" then
		local now_at_pay = inv.get_stack(inv,"pay",1)
		local playername = player.get_player_name(player)
		local count = now_at_pay.get_count(now_at_pay)
		local name  = now_at_pay.get_name(now_at_pay)
		dbg_mobf.trader_inv_lvl1("MOBF: putpay player: " .. playername
			.. " pays now count=" .. count .. " of type=" ..name)

		mob_inventory.update_takeaway(inv)
	end
end



-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] on_take(inv, listname, index, stack, player)
--
--! @brief check if there is enough at payroll
--! @memberof mob_inventory
--! @private
--
--! @param inv inventory reference
--! @param listname name of list changed
--! @param index index in list changed
--! @param stack moved
--! @param player doing changes
-------------------------------------------------------------------------------
function mob_inventory.on_take(inv, listname, index, stack, player)
	if listname == "takeaway" then
		local now_at_pay = inv.get_stack(inv,"pay",index)
		local playername = player.get_player_name(player)
		local count = now_at_pay.get_count(now_at_pay)
		local name  = now_at_pay.get_name(now_at_pay)
		dbg_mobf.trader_inv_lvl2("MOBF: takeaway player: " .. playername
			.. " pays now count=" .. count .. " of type=" ..name)

		if not mob_inventory.check_pay(inv,true) then
			dbg_mobf.trader_inv_lvl1("MOBF: error player hasn't payed enough!")
		end

		mob_inventory.update_takeaway(inv)
	end

	if listname == "pay" then
		if mob_inventory.check_pay(inv,false) then
			local selection = inv.get_stack(inv,"selection", 1)

			if selection ~= nil then
				inv.set_stack(inv,"takeaway",1,selection)
			else
				dbg_mobf.trader_inv_lvl1("MOBF: nothing selected to buy")
			end
		else
			inv.set_stack(inv,"takeaway",1,nil)
		end
	end
end


-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] update_takeaway(inv)
--
--! @brief update content of takeaway
--! @memberof mob_inventory
--! @private
--
--! @param inv to update
-------------------------------------------------------------------------------
function mob_inventory.update_takeaway(inv)
	if mob_inventory.check_pay(inv,false) then
		local selection = inv.get_stack(inv,"selection", 1)

		if selection ~= nil then
			inv.set_stack(inv,"takeaway",1,selection)
		else
			dbg_mobf.trader_inv_lvl1("MOBF: nothing selected to buy")
		end
	else
		inv.set_stack(inv,"takeaway",1,nil)
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] check_pay(inv)
--
--! @brief check if there is enough at payroll
--! @memberof mob_inventory
--! @private
--
--! @param inv inventory to do check
--! @param paynow true/false if it's called to pay or not
--
--! @return true/false
-------------------------------------------------------------------------------
function mob_inventory.check_pay(inv,paynow)
	local now_at_pay = inv.get_stack(inv,"pay",1)
	local count = now_at_pay.get_count(now_at_pay)
	local name  = now_at_pay.get_name(now_at_pay)

	local price1 = inv.get_stack(inv,"price_1", 1)
	local price2 = inv.get_stack(inv,"price_2", 1)

	dbg_mobf.trader_inv_lvl1(
		"MOBF: p1 " .. dump(price1) .. " " .. dump(price1:get_name()))
	if price1:get_name() == name then
		local price = price1:get_count()
		if price > 0 and
			price <= count then
			if paynow then
				now_at_pay.take_item(now_at_pay,price)
				inv.set_stack(inv,"pay",1,now_at_pay)
				return true
			else
				return true
			end
		else
			if paynow then
				inv.set_stack(inv,"pay",1,nil)
			end
		end
	end

	dbg_mobf.trader_inv_lvl1(
		"MOBF: p2 " .. dump(price1) .. " " .. dump(price2:get_name()))
	if price2:get_name() == name then
		local price = price2:get_count()
		if price > 0 and
			price <= count then
			if paynow then
				now_at_pay.take_item(now_at_pay,price)
				inv.set_stack(inv,"pay",1,now_at_pay)
				return true
			else
				return true
			end
		else
			if paynow then
				inv.set_stack(inv,"pay",1,nil)
			end
		end
	end
	return false
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] init_detached_inventories(entity,now)
--
--! @brief initialize dynamic data required by harvesting
--! @memberof mob_inventory
--! @public
--
--! @param entity mob to initialize harvest dynamic data
-------------------------------------------------------------------------------
function mob_inventory.init_trader_inventory(entity)
	--TODO find out why calling "tostring" is necessary?!
	local tradername       = tostring(
		entity.data.trader_inventory.random_names[
		math.random(1,#entity.data.trader_inventory.random_names)])
	dbg_mobf.trader_inv_lvl3(
		"MOBF: randomly selected \"" .. tradername .. "\" as name")
	local unique_entity_id = string.gsub(tostring(entity),"table: ","")
	--local unique_entity_id = "testinv"
	local trader_inventory =
	minetest.create_detached_inventory(unique_entity_id,
	{
		allow_move 	= mob_inventory.allow_move,
		allow_put 	= mob_inventory.allow_put,
		allow_take 	= mob_inventory.allow_take,

		on_move 	= mob_inventory.on_move,
		on_put 		= mob_inventory.on_put,
		on_take 	= mob_inventory.on_take,
	})

	trader_inventory.set_size(trader_inventory,"goods",16)
	trader_inventory.set_size(trader_inventory,"takeaway",1)
	trader_inventory.set_size(trader_inventory,"selection",1)
	trader_inventory.set_size(trader_inventory,"price_1",1)
	trader_inventory.set_size(trader_inventory,"price_2",1)
	trader_inventory.set_size(trader_inventory,"pay",1)

	mob_inventory.add_goods(entity,trader_inventory)

	--register to trader inventories
	table.insert(mob_inventory.trader_inventories, {
										identifier 	= unique_entity_id,
										inv_ref 	= trader_inventory,
										ent_ref 	= entity,
										})
	dbg_mobf.trader_inv_lvl3(
		"MOBF: registering identifier: " .. unique_entity_id
		.. " invref \"" .. tostring(trader_inventory) .. "\"  for entity \""
		.. tostring(entity) .. "\"" )

	local trader_formspec = "size[8,10;]" ..
			"label[2,0;Trader " .. tradername .. " Inventory]" ..
			"label[0,1;Selling:]" ..
			"list[detached:" .. unique_entity_id .. ";goods;0,1.5;8,2;]" ..
			"label[0,4.0;Selection]" ..
			"list[detached:" .. unique_entity_id .. ";selection;0,4.5;1,1;]" ..
			"label[1.25,4.75;-->]" ..
			"label[2,4.0;Price]" ..
			"list[detached:" .. unique_entity_id .. ";price_1;2,4.5;1,1;]" ..
			"label[3,4.0;or]" ..
			"list[detached:" .. unique_entity_id .. ";price_2;3,4.5;1,1;]" ..
			"label[4.25,4.75;-->]" ..
			"label[5,4.0;Pay]" ..
			"list[detached:" .. unique_entity_id .. ";pay;5,4.5;1,1;]" ..
			"label[6.25,4.75;-->]" ..
			"label[6.75,4.0;Takeaway]" ..
			"list[detached:" .. unique_entity_id .. ";takeaway;7,4.5;1,1;]" ..
			"list[current_player;main;0,6;8,4;]"

	if mob_inventory.register_formspec("formspec_"
		.. unique_entity_id,trader_formspec) == false then
		dbg_mobf.trader_inv_lvl1("MOBF: unable to create trader formspec")
	end
end


-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] config_check(entity)
--
--! @brief check if mob is configured as trader
--! @memberof mob_inventory
--! @public
--
--! @param entity mob being checked
--! @return true/false if trader or not
-------------------------------------------------------------------------------
function mob_inventory.config_check(entity)
	if entity.data.trader_inventory ~= nil then
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] register_formspec(name,formspec)
--
--! @brief check if mob is configured as trader
--! @memberof mob_inventory
--! @public
--
--! @param name name of formspec to register
--! @param formspec formspec definition
--
--! @return true/false if succesfull or not
-------------------------------------------------------------------------------
function mob_inventory.register_formspec(name,formspec)

	if mob_inventory.formspecs[name] == nil then
		mob_inventory.formspecs[name] = formspec
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] trader_callback(entity,player)
--
--! @brief callback handler for inventory by rightclick
--! @memberof mob_inventory
--! @public
--
--! @param entity mob being harvested
--! @param player player harvesting
--
--! @return true/false if handled by harvesting or not
-------------------------------------------------------------------------------
function mob_inventory.trader_callback(entity,player)
	local unique_entity_id = string.gsub(tostring(entity),"table: ","")
	--local unique_entity_id = "testinv"
	local playername = player.get_player_name(player)

	if mob_inventory.formspecs["formspec_" .. unique_entity_id] ~= nil then
		--rotate mob to face player
		local direction = mobf_get_direction(entity.object:getpos(),
												player:getpos())

		if entity.mode == "3d" then
			entity.object:setyaw(
				mobf_calc_yaw(direction.x,direction.z))
		else
			entity.object:setyaw(
				mobf_calc_yaw(direction.x,direction.z)+math.pi/2)
		end

		attention.increase_attention_level(entity,player,10)

		if minetest.show_formspec(playername,
					"formspec_" .. unique_entity_id,
					mob_inventory.formspecs["formspec_" .. unique_entity_id])
					== false then
			dbg_mobf.trader_inv_lvl1("MOBF: unable to show trader formspec")
		end
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] get_entity(inv)
--
--! @brief find entity linked to inventory
--! @memberof mob_inventory
--! @private
--
--! @param inv name of inventory
-------------------------------------------------------------------------------
function mob_inventory.get_entity(inv)
	dbg_mobf.trader_inv_lvl3("MOBF: checking "
		.. #mob_inventory.trader_inventories
		.. " registred inventorys")

	local location = inv.get_location(inv)

	if location.type == "detached" then
		for i=1,#mob_inventory.trader_inventories,1 do
			dbg_mobf.trader_inv_lvl3("MOBF: comparing \""
				.. location.name .. "\" to \""
				.. mob_inventory.trader_inventories[i].identifier .. "\"")
			if mob_inventory.trader_inventories[i].identifier
				== location.name then
				return mob_inventory.trader_inventories[i].ent_ref
			end
		end
	end

	return nil
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] fill_prices(entity,inventory,goodname)
--
--! @brief fill price fields
--! @memberof mob_inventory
--! @private
--
--! @param entity to look for prices
--! @param inventory to set prices
--! @param goodname name of good to set prices for
--! @param count number of elements
-------------------------------------------------------------------------------
function mob_inventory.fill_prices(entity,inventory,goodname,count)

	--get price info from entity
	local good = nil

	for i=1,#entity.data.trader_inventory.goods,1 do
		local stackstring = goodname .." " .. count
		dbg_mobf.trader_inv_lvl3("MOBF: comparing \"" .. stackstring .. "\"" ..
			" to \"" .. entity.data.trader_inventory.goods[i][1] .. "\"")
		if entity.data.trader_inventory.goods[i][1] == stackstring then
			good = entity.data.trader_inventory.goods[i]
		end
	end

	if good ~= nil then
		inventory.set_stack(inventory,"price_1", 1, good[2])
		inventory.set_stack(inventory,"price_2", 1, good[3])
	else
		inventory.set_stack(inventory,"price_1", 1, nil)
		inventory.set_stack(inventory,"price_2", 1, nil)
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_inventory] add_goods(entity,trader_inventory)
--
--! @brief fill inventory with mobs goods
--! @memberof mob_inventory
--! @private
--
--! @param entity to look for prices
--! @param trader_inventory to put goods
-------------------------------------------------------------------------------
function mob_inventory.add_goods(entity,trader_inventory)

	local goods_to_add = nil

	if entity.data.trader_inventory.goodlist ~= nil then
		local total_sum_chances = 0

		for i=1,#entity.data.trader_inventory.goodlist,1 do
			total_sum_chances = total_sum_chances +
				entity.data.trader_inventory.goodlist[i].chance
		end

		local rand_value = math.random(0,total_sum_chances)

		local selected_index=1
		local runvalue = 0

		for j=1,#entity.data.trader_inventory.goodlist,1 do

			runvalue = runvalue +
				entity.data.trader_inventory.goodlist[j].chance

			if runvalue < rand_value then
				selected_index=j
				break;
			end
		end

		goods_to_add =
			entity.data.trader_inventory.goodlist[selected_index].goods
	else
		goods_to_add = entity.data.trader_inventory.goods
	end

	dbg_mobf.trader_inv_lvl3("MOBF: adding "
		.. #goods_to_add
		.. " goods for trader")
	for i=1,#goods_to_add,1 do
		dbg_mobf.trader_inv_lvl3("MOBF:\tadding " ..
			goods_to_add[i][1])
		trader_inventory.set_stack(trader_inventory,"goods", i,
									goods_to_add[i][1])
	end

end