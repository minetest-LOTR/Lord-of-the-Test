local get_formspec = function(pos, adj, texture)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	return "size[8,10]"..
	"label[2.5,0;"..adj.." Crafting Table]"..
	"label[1,1;Inputs]"..
	"label[6,1;Outputs]"..
	"list[nodemeta:"..spos..";src;0,2;3,3]"..
	"button[3,3;2,1;craft_button;Craft]"..
	"list[nodemeta:"..spos..";dst;5,2;3,3]"..
	"list[current_player;main;0,6;8,4]"..
	"listring[nodemeta:"..spos..";dst]"..
	"listring[current_player;main]"..
	"listring[nodemeta:"..spos..";src]"..
	"listring[current_player;main]"..
	"background[-0.5,-0.5;9,11;"..texture.."]"
end

local check_privs = function(player, required_race, nounp)
	local name = player:get_player_name()
	local race_num = player:get_attribute("race");
	if not race_num or race_num == "" then
		minetest.chat_send_player(name, "You are not a valid creature.")
		return false
	end
	local race = lottplayer.races[tonumber(race_num)][1];
	if required_race ~= "all" and race:sub(1, #required_race) ~= required_race then
		minetest.chat_send_player(name, "Only "..nounp.." may use this crafting table.")
		return false
	end
	return true
end

local register_crafting_table = function(adj, noun, nounp, texture, gui_texture)
	minetest.register_node("lottcrafting:"..noun.."_table", {
		description = adj.." Crafting Table",
		tiles = {texture, "default_wood.png"},
		groups = {choppy=2,oddly_breakable_by_hand=2},
		is_ground_content = false,
		drawtype = "nodebox",
		sunlight_propagates = true,
		paramtype = 'light',
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
				{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
				{-0.4,-0.5,0.3, -0.3,0.4,0.4},
				{0.3,-0.5,0.3, 0.4,0.4,0.4},
				{-0.5,0.4,-0.5, 0.5,0.5,0.5},
				{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
				{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
				{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
				{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
			},
		},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			meta:set_string("infotext", adj.." Crafting Table")
			inv:set_size("src", 9)
			inv:set_width("src", 3)
			inv:set_size("dst", 9)
		end,
		on_rightclick = function(pos, node, clicker, itemstack)
                        local player = clicker:get_player_name()
			if check_privs(clicker, noun, nounp) then
				minetest.show_formspec(player, "lottcrafting:"..noun.."_table", get_formspec(pos, adj, gui_texture))
			end
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			if check_privs(player, noun, nounp) then
				return count
			end
			return 0
		end,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			if check_privs(player, noun, nounp) then
				return stack:get_count()
			end
			return 0
		end,
		allow_metadata_inventory_take = function(pos, listname, index, stack, player)
			if check_privs(player, noun, nounp) then
				return stack:get_count()
			end
			return 0
		end,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if not inv:is_empty("src") or not inv:is_empty("dst") then
				return false
			end
			return true
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if not check_privs(sender, noun, nounp) then return end
			if fields.craft_button and fields.craft_button ~= "" then
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				if inv:is_empty("src") then return end
				local src_list = inv:get_list("src")
				local def = lottcrafting.get_craft_result(noun, inv:get_width("src"), src_list)
				lottcrafting.handle_craft(def, inv, "src", "dst")
			end
		end,
	})
end

-- TODO: possibly add separate crafting tables for different types within the races
register_crafting_table("Dwarven", "dwarf", "dwarves", "lottblocks_dwarf_chest_top.png", "gui_dwarfbg.png")
register_crafting_table("Human", "man", "humans", "lottblocks_gondor_chest_top.png", "gui_gondorbg.png")
register_crafting_table("Orcish", "orc", "orcs", "lottblocks_mordor_chest_top.png", "gui_mordorbg.png")
register_crafting_table("Elven", "elf", "elves", "lottblocks_elf_chest_top.png", "gui_elfbg.png")
register_crafting_table("Hobbit", "hobbit", "hobbits", "lottblocks_hobbit_chest_top.png", "gui_hobbitbg.png")
register_crafting_table("Generic", "all", "all", "default_wood.png", "gui_chestbg.png")
