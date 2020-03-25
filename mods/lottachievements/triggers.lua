-- AWARDS
--
-- Copyright (C) 2013-2015 rubenwardy
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation; either version 2.1 of the License, or
-- (at your option) any later version.
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
-- You should have received a copy of the GNU Lesser General Public License along
-- with this program; if not, write to the Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
--

local S, NS = lottachievements.gettext, lottachievements.ngettext

lottachievements.register_trigger("dig", function(def)
	local tmp = {
		award  = def.name,
		node   = def.trigger.node,
		target = def.trigger.target,
	}
	table.insert(lottachievements.on.dig, tmp)
	def.getProgress = function(self, data)
		local itemcount
		if tmp.node then
			itemcount = lottachievements.get_item_count(data, "count", tmp.node) or 0
		else
			itemcount = lottachievements.get_total_item_count(data, "count")
		end
		if itemcount > tmp.target then
			itemcount = tmp.target
		end
		return {
			perc = itemcount / tmp.target,
			label = S("@1/@2 dug", itemcount, tmp.target),
		}
	end
	def.getDefaultDescription = function(self)
		local n = self.trigger.target
		if self.trigger.node then
			local nname = minetest.registered_nodes[self.trigger.node].description
			if nname == nil then
				nname = self.trigger.node
			end
			-- Translators: @1 is count, @2 is description.
			return NS("Mine: @2", "Mine: @1×@2", n, n, nname)
		else
			return NS("Mine @1 block.", "Mine @1 blocks.", n, n)
		end
	end
end)

lottachievements.register_trigger("place", function(def)
	local tmp = {
		award  = def.name,
		node   = def.trigger.node,
		target = def.trigger.target,
	}
	table.insert(lottachievements.on.place, tmp)
	def.getProgress = function(self, data)
		local itemcount
		if tmp.node then
			itemcount = lottachievements.get_item_count(data, "place", tmp.node) or 0
		else
			itemcount = lottachievements.get_total_item_count(data, "place")
		end
		if itemcount > tmp.target then
			itemcount = tmp.target
		end
		return {
			perc = itemcount / tmp.target,
			label = S("@1/@2 placed", itemcount, tmp.target),
		}
	end
	def.getDefaultDescription = function(self)
		local n = self.trigger.target
		if self.trigger.node then
			local nname = minetest.registered_nodes[self.trigger.node].description
			if nname == nil then
				nname = self.trigger.node
			end
			-- Translators: @1 is count, @2 is description.
			return NS("Place: @2", "Place: @1×@2", n, n, nname)
		else
			return NS("Place a block.", "Place @1 blocks.", n, n)
		end
	end
end)

lottachievements.register_trigger("eat", function(def)
	local tmp = {
		award  = def.name,
		item = def.trigger.item,
		target = def.trigger.target,
	}
	table.insert(lottachievements.on.eat, tmp)
	def.getProgress = function(self, data)
		local itemcount
		if tmp.item then
			itemcount = lottachievements.get_item_count(data, "eat", tmp.item) or 0
		else
			itemcount = lottachievements.get_total_item_count(data, "eat")
		end
		if itemcount > tmp.target then
			itemcount = tmp.target
		end
		return {
			perc = itemcount / tmp.target,
			label = S("@1/@2 eaten", itemcount, tmp.target),
		}
	end
	def.getDefaultDescription = function(self)
		local n = self.trigger.target
		if self.trigger.item then
			local iname = minetest.registered_items[self.trigger.item].description
			if iname == nil then
				iname = self.trigger.iode
			end
			-- Translators: @1 is count, @2 is description.
			return NS("Eat: @2", "Eat: @1×@2", n, n, iname)
		else
			return NS("Eat an item.", "Eat @1 items.", n, n)
		end
	end
end)

lottachievements.register_trigger("death", function(def)
	local tmp = {
		award  = def.name,
		target = def.trigger.target,
	}
	table.insert(lottachievements.on.death, tmp)
	def.getProgress = function(self, data)
		local itemcount = data.deaths or 0
		if itemcount > tmp.target then
			itemcount = tmp.target
		end
		return {
			perc = itemcount / tmp.target,
			label = S("@1/@2 deaths", itemcount, tmp.target),
		}
	end
	def.getDefaultDescription = function(self)
		local n = self.trigger.target
		return NS("Die.", "Die @1 times.", n, n)
	end
end)

lottachievements.register_trigger("chat", function(def)
	local tmp = {
		award  = def.name,
		target = def.trigger.target,
	}
	table.insert(lottachievements.on.chat, tmp)
	def.getProgress = function(self, data)
		local itemcount = data.chats or 0
		if itemcount > tmp.target then
			itemcount = tmp.target
		end
		return {
			perc = itemcount / tmp.target,
			label = S("@1/@2 chat messages", itemcount, tmp.target),
		}
	end
	def.getDefaultDescription = function(self)
		local n = self.trigger.target
		return NS("Write something in chat.", "Write @1 chat messages.", n, n)
	end
end)

lottachievements.register_trigger("join", function(def)
	local tmp = {
		award  = def.name,
		target = def.trigger.target,
	}
	table.insert(lottachievements.on.join, tmp)
	def.getProgress = function(self, data)
		local itemcount = data.joins or 0
		if itemcount > tmp.target then
			itemcount = tmp.target
		end
		return {
			perc = itemcount / tmp.target,
			label = S("@1/@2 game joins", itemcount, tmp.target),
		}
	end
	def.getDefaultDescription = function(self)
		local n = self.trigger.target
		return NS("Join the game.", "Join the game @1 times.", n, n)
	end
end)

lottachievements.register_trigger("craft", function(def)
	local tmp = {
		award  = def.name,
		item = def.trigger.item,
		target = def.trigger.target,
	}
	table.insert(lottachievements.on.craft, tmp)
	def.getProgress = function(self, data)
		local itemcount
		if tmp.item then
			itemcount = lottachievements.get_item_count(data, "craft", tmp.item) or 0
		else
			itemcount = lottachievements.get_total_item_count(data, "craft")
		end
		if itemcount > tmp.target then
			itemcount = tmp.target
		end
		return {
			perc = itemcount / tmp.target,
			label = S("@1/@2 crafted", itemcount, tmp.target),
		}
	end
	def.getDefaultDescription = function(self)
		local n = self.trigger.target
		if self.trigger.item then
			local iname = minetest.registered_items[self.trigger.item].description
			if iname == nil then
				iname = self.trigger.item
			end
			-- Translators: @1 is count, @2 is description.
			return NS("Craft: @2", "Craft: @1×@2", n, n, iname)
		else
			return NS("Craft an item.", "Craft @1 items.", n)
		end
	end
end)

lottachievements.register_trigger("equip", function(def)
	local tmp = {
		award  = def.name,
		item = def.trigger.item,
	}
	table.insert(lottachievements.on.equip, tmp)
	def.getDefaultDescription = function(self)
		if self.trigger.item then
			local iname = minetest.registered_items[self.trigger.item].description
			if iname == nil then
				iname = self.trigger.iode
			end
			-- Translators: @1 is count, @2 is description.
			return NS("Eat: @2", "Eat: @1×@2", 4, 4, iname)
		else
			return NS("Eat an item.", "Eat @1 items.", 4, 4)
		end
	end
end)

lottachievements.register_trigger("kill", function(def)
	local tmp = {
		award  = def.name,
		mob = def.trigger.mob,
		target = def.trigger.target,
	}
	table.insert(lottachievements.on.kill, tmp)
	def.getProgress = function(self, data)
		local itemcount
		if tmp.mob then
			itemcount = lottachievements.get_item_count(data, "kill", tmp.mob) or 0
		else
			itemcount = lottachievements.get_total_item_count(data, "kill")
		end
		if itemcount > tmp.target then
			itemcount = tmp.target
		end
		return {
			perc = itemcount / tmp.target,
			label = S("@1/@2 killed", itemcount, tmp.target),
		}
	end
	def.getDefaultDescription = function(self)
		local n = self.trigger.target
		if self.trigger.mob then
			local iname = string.split(self.trigger.mob, ":")[2]
			iname = string.gsub(iname, "_", " "):gsub("^%l", string.upper)
			if iname == nil then
				iname = self.trigger.mob
			end
			-- Translators: @1 is count, @2 is description.
			return NS("Kill: @2", "Kill: @1×@2", n, n, iname)
		end
	end
end)

-- Backwards compatibility
lottachievements.register_onDig   = lottachievements.register_on_dig
lottachievements.register_onPlace = lottachievements.register_on_place
lottachievements.register_onDeath = lottachievements.register_on_death
lottachievements.register_onChat  = lottachievements.register_on_chat
lottachievements.register_onJoin  = lottachievements.register_on_join
lottachievements.register_onCraft = lottachievements.register_on_craft

-- Trigger Handles
minetest.register_on_dignode(function(pos, oldnode, digger)
	if not digger or not pos or not oldnode then
		return
	end

	local data = lottachievements.players[digger:get_player_name()]
	if not lottachievements.increment_item_counter(data, "count", oldnode.name) then
		return
	end
	lottachievements.run_trigger_callbacks(digger, data, "dig", function(entry)
		if entry.target then
			if entry.node then
				local tnodedug = string.split(entry.node, ":")
				local tmod = tnodedug[1]
				local titem = tnodedug[2]
				if not tmod or not titem or not data.count[tmod] or not data.count[tmod][titem] then
					-- table running failed!
				elseif data.count[tmod][titem] > entry.target-1 then
					return entry.award
				end
			elseif lottachievements.get_total_item_count(data, "count") > entry.target-1 then
				return entry.award
			end
		end
	end)
end)

minetest.register_on_placenode(function(pos, node, digger)
	if not digger or not pos or not node or not digger:get_player_name() or digger:get_player_name()=="" then
		return
	end
	local data = lottachievements.players[digger:get_player_name()]
	if not lottachievements.increment_item_counter(data, "place", node.name) then
		return
	end

	lottachievements.run_trigger_callbacks(digger, data, "place", function(entry)
		if entry.target then
			if entry.node then
				local tnodedug = string.split(entry.node, ":")
				local tmod = tnodedug[1]
				local titem = tnodedug[2]
				if not tmod or not titem or not data.place[tmod] or not data.place[tmod][titem] then
					-- table running failed!
				elseif data.place[tmod][titem] > entry.target-1 then
					return entry.award
				end
			elseif lottachievements.get_total_item_count(data, "place") > entry.target-1 then
				return entry.award
			end
		end
	end)
end)

minetest.register_on_item_eat(function(hp_change, replace_with_item, itemstack,
		user, pointed_thing, old_itemstack, old_level, level)
	if not user or not itemstack or not user:get_player_name()
	or user:get_player_name() == "" or level == old_level then
		return
	end
	local data = lottachievements.players[user:get_player_name()]
	if not lottachievements.increment_item_counter(data, "eat", itemstack:get_name()) then
		return
	end
	lottachievements.run_trigger_callbacks(user, data, "eat", function(entry)
		if entry.target then
			if entry.item then
				local titemstring = string.split(entry.item, ":")
				local tmod = titemstring[1]
				local titem = titemstring[2]
				if not tmod or not titem or not data.eat[tmod] or not data.eat[tmod][titem] then
					-- table running failed!
				elseif data.eat[tmod][titem] > entry.target-1 then
					return entry.award
				end
			elseif lottachievements.get_total_item_count(data, "eat") > entry.target-1 then
				return entry.award
			end
		end
	end)
end)

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	if not player or not itemstack then
		return
	end

	local data = lottachievements.players[player:get_player_name()]
	if not lottachievements.increment_item_counter(data, "craft", itemstack:get_name(), itemstack:get_count()) then
		return
	end

	lottachievements.run_trigger_callbacks(player, data, "craft", function(entry)
		if entry.target then
			if entry.item then
				local titemcrafted = string.split(entry.item, ":")
				local tmod = titemcrafted[1]
				local titem = titemcrafted[2]
				if not tmod or not titem or not data.craft[tmod] or not data.craft[tmod][titem] then
					-- table running failed!
				elseif data.craft[tmod][titem] > entry.target-1 then
					return entry.award
				end
			elseif lottachievements.get_total_item_count(data, "craft") > entry.target-1 then
				return entry.award
			end
		end
	end)
end)

minetest.register_on_dieplayer(function(player)
	-- Run checks
	local name = player:get_player_name()
	if not player or not name or name=="" then
		return
	end

	-- Get player
	lottachievements.assertPlayer(name)
	local data = lottachievements.players[name]

	-- Increment counter
	data.deaths = data.deaths + 1

	lottachievements.run_trigger_callbacks(player, data, "death", function(entry)
		if entry.target and entry.award and data.deaths and
				data.deaths >= entry.target then
			return entry.award
		end
	end)
end)

minetest.register_on_joinplayer(function(player)
	-- Run checks
	local name = player:get_player_name()
	if not player or not name or name=="" then
		return
	end

	-- Get player
	lottachievements.assertPlayer(name)
	local data = lottachievements.players[name]

	-- Increment counter
	data.joins = data.joins + 1

	lottachievements.run_trigger_callbacks(player, data, "join", function(entry)
		if entry.target and entry.award and data.joins and
				data.joins >= entry.target then
			return entry.award
		end
	end)
end)

minetest.register_on_chat_message(function(name, message)
	-- Run checks
	local idx = string.find(message,"/")
	if not name or (idx ~= nil and idx <= 1)  then
		return
	end

	-- Get player
	lottachievements.assertPlayer(name)
	local data = lottachievements.players[name]
	local player = minetest.get_player_by_name(name)

	-- Increment counter
	data.chats = data.chats + 1

	lottachievements.run_trigger_callbacks(player, data, "chat", function(entry)
		if entry.target and entry.award and data.chats and
				data.chats >= entry.target then
			return entry.award
		end
	end)
end)

function lottachievements.equip(stack, player, count)
	if not stack or not player or not count then
		return
	end
	local data = lottachievements.players[player:get_player_name()]
	local name = string.split(stack:get_name(), ":")
	local name1 = name[1]
	local name2 = string.split(name[2], "_", false, 1)[2]
	if name1 and name2 then
		name = name1 .. ":" .. name2
	else
		return
	end

	if not lottachievements.increment_item_counter(data, "equip", name, count) then
		return
	end

	lottachievements.run_trigger_callbacks(player, data, "equip", function(entry)
		if entry.item then
			local titemequipped = string.split(entry.item, ":")
			local tmod = titemequipped[1]
			local titem = string.split(titemequipped[2], "_", false, 1)[2]
			if not tmod or not titem or not data.equip[tmod] or not data.equip[tmod][titem] then
				-- table running failed!
			elseif data.equip[tmod][titem] > 3 then
				return entry.award
			end
		end
	end)
end

function lottachievements.kill(name, player)
	if not name or not player or not player:is_player() then
		return
	end
	local data = lottachievements.players[player:get_player_name()]

	if string.find(name, "%d", -1) then
		-- For various types of mobs with multiple variations
		-- (e.g. The 3 different types of dwarves in armour, lottmobs:dwarf, lottmobs:dwarf1...)
		name = string.sub(name, 1, -2)
	end

	if not lottachievements.increment_item_counter(data, "kill", name) then
		return
	end

	lottachievements.run_trigger_callbacks(player, data, "kill", function(entry)
		if entry.mob then
			local tmobkilled = string.split(entry.mob, ":")
			local tmod = tmobkilled[1]
			local tmob = tmobkilled[2]
			if not tmod or not tmob or not data.kill[tmod] or not data.kill[tmod][tmob] then
				-- table running failed!
			elseif data.kill[tmod][tmob] > entry.target-1 then
				return entry.award
			end
		end
	end)
end
