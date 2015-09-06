--This code comes almost exclusively from the trader and inventory of mobf, by Sapier.
--The copyright notice bellow is from mobf:
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

function lottmobs.allow_move(inv, from_list, from_index, to_list, to_index, count, player)
	if to_list ~= "selection" or
		from_list == "price" or
		from_list == "payment" or
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

function lottmobs.allow_put(inv, listname, index, stack, player)
	if listname == "payment" then
		return 99
	end
	return 0
end

function lottmobs.allow_take(inv, listname, index, stack, player)
	if listname == "takeaway" or
		listname == "payment" then
		return 99
	else
		return 0
	end
end

function lottmobs.on_put(inv, listname, index, stack)
	if listname == "payment" then
		lottmobs.update_takeaway(inv)
	end
end

function lottmobs.on_take(inv, listname, count, index, stack, player)
	if listname == "takeaway" then
		local amount = inv:get_stack("payment",1):get_count()
		local price = inv:get_stack("price",1):get_count()
		local thing = inv:get_stack("payment",1):get_name()
		inv.set_stack(inv,"selection",1,nil)
		inv.set_stack(inv,"price",1,nil)
		inv.set_stack(inv,"takeaway",1,nil)
		inv.set_stack(inv,"payment",1,thing .. " " .. amount-price)
	end

	if listname == "payment" then
		if lottmobs.check_pay(inv,false) then
			local selection = inv.get_stack(inv,"selection", 1)
			if selection ~= nil then
				inv.set_stack(inv,"takeaway",1,selection)
			end
		else
			inv.set_stack(inv,"takeaway",1,nil)
		end
	end
end

function lottmobs.update_takeaway(inv)
	if lottmobs.check_pay(inv,false) then
		local selection = inv.get_stack(inv,"selection", 1)

		if selection ~= nil then
			inv.set_stack(inv,"takeaway",1,selection)
		end
	else
		inv.set_stack(inv,"takeaway",1,nil)
	end
end

function lottmobs.check_pay(inv,paynow)
	local now_at_pay = inv.get_stack(inv,"payment",1)
	local count = now_at_pay.get_count(now_at_pay)
	local name  = now_at_pay.get_name(now_at_pay)

	local price = inv.get_stack(inv,"price", 1)

	if price:get_name() == name then
		local price = price:get_count()
		if price > 0 and
			price <= count then
			if paynow then
				now_at_pay.take_item(now_at_pay,price)
				inv.set_stack(inv,"payment",1,now_at_pay)
				return true
			else
				return true
			end
		else
			if paynow then
				inv.set_stack(inv,"payment",1,nil)
			end
		end
	end

	return false
end
lottmobs.trader_inventories = {}

function lottmobs.add_goods(entity, race)
	local goods_to_add = nil
	for i=1,15 do
		if same_race == true then
			if math.random(0, 100) > race.items_race[i][3] then
				lottmobs.trader_inventory.set_stack(lottmobs.trader_inventory,"goods", i, race.items_race[i][1])
			end
		else
			if math.random(0, 100) > race.items[i][3] then
				lottmobs.trader_inventory.set_stack(lottmobs.trader_inventory,"goods", i, race.items[i][1])
			end
		end
	end
end

function lottmobs.face_pos(self,pos)
	local s = self.object:getpos()
	local vec = {x=pos.x-s.x, y=pos.y-s.y, z=pos.z-s.z}
	local yaw = math.atan(vec.z/vec.x)+math.pi/2
	if self.drawtype == "side" then
		yaw = yaw+(math.pi/2)
	end
	if pos.x > s.x then
		yaw = yaw+math.pi
	end
	self.object:setyaw(yaw)
	return yaw
end
----

function lottmobs_trader(self, clicker, entity, race, image, priv)
	lottmobs.face_pos(self, clicker:getpos())
	local player = clicker:get_player_name()
	local unique_entity_id = self.id
	local is_inventory = minetest.get_inventory({type="detached", name=unique_entity_id})
	local same_race = false
	if minetest.get_player_privs(player)[priv] ~= nil then
		same_race = true
	end
	local move_put_take = {
		allow_move = lottmobs.allow_move,
		allow_put = lottmobs.allow_put,
		allow_take = lottmobs.allow_take,
		on_move = function(inventory, from_list, from_index, to_list, to_index, count, player)
			if from_list == "goods" and
			to_list == "selection" then
				local inv = inventory
				local moved = inv.get_stack(inv,to_list, to_index)
				local goodname = moved.get_name(moved)
				local elements = moved.get_count(moved)
				if( elements > count ) then
					-- remove the surplus parts
					inv.set_stack(inv,"selection", 1,goodname.." "..tostring( count ))
					-- the slot we took from is now free
					inv.set_stack(inv,"goods",from_index,
						goodname.." "..tostring( elements - count ))
					-- update the real amount of items in the slot now
					elements = count
				end
				local good = nil
				local good = nil
				if same_race == true then
					for i = 1,#race.items_race,1 do
						local stackstring = goodname .." " .. count
						if race.items_race[i][1] == stackstring then
							good = race.items_race[i]
						end
					end
				else
					for i = 1,#race.items,1 do
						local stackstring = goodname .." " .. count
						if race.items[i][1] == stackstring then
							good = race.items[i]
						end
					end
				end
				if good ~= nil then
					inventory.set_stack(inventory,"price", 1, good[2])
				else
					inventory.set_stack(inventory,"price", 1, nil)
				end
			lottmobs.update_takeaway(inv)
			end
		end,
		on_put = lottmobs.on_put,
		on_take = lottmobs.on_take
	}
	if is_inventory == nil then
		self.game_name = tostring(race.names[math.random(1,#race.names)])
		lottmobs.trader_inventory = minetest.create_detached_inventory(unique_entity_id, move_put_take)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"goods",15)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"takeaway",1)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"selection",1)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"price",1)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"payment",1)
		lottmobs.add_goods(entity, race)
	end
	minetest.chat_send_player(player, "[NPC] <Trader " .. self.game_name .. "> Hello, " .. player .. ", have a look at my wares.")
	minetest.show_formspec(player, "trade",
		"size[8,10;]" ..
		 "background[5,5;1,1;" .. image .. ";true]" ..
		"label[0,0;Trader " .. self.game_name .. "'s stock:]" ..
		"list[detached:" .. unique_entity_id .. ";goods;.5,.5;3,5;]" ..
		"label[4.5,0.5;Selection]" ..
		"list[detached:" .. unique_entity_id .. ";selection;4.5,1;5.5,2;]" ..
		"label[6,0.5;Price]" ..
		"list[detached:" .. unique_entity_id .. ";price;6,1;7,2;]" ..
		"label[4.5,3.5;Payment]" ..
		"list[detached:" .. unique_entity_id .. ";payment;4.5,4;5.5,5;]" ..
		"label[6,3.5;Brought items]" ..
		"list[detached:" .. unique_entity_id .. ";takeaway;6,4;7.5,5.5;]" ..
		"list[current_player;main;0,6;8,4;]"
	)
end
