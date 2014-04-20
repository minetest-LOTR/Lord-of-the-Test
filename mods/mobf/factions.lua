-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file factions.lua
--! @brief contains factions adaption of mobf
--! @copyright Sapier
--! @author Sapier
--! @date 2013-08-21
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

mobf_assert_backtrace(mobf_factions == nil)
--! @class mobf_factions
--! @brief faction mod support for mobf
mobf_factions = {}


-------------------------------------------------------------------------------
-- @function [parent=#mobf_factions] init()
--
--! @brief initialize mobf factions support
--! @memberof mobf_factions
--
-------------------------------------------------------------------------------
function mobf_factions.init()
	if  minetest.get_modpath("factions")then
		mobf_rtd.factions_available = true
	end

	--need to catch my form events
	minetest.register_on_player_receive_fields(mobf_factions.button_handler)
end


-------------------------------------------------------------------------------
-- @function [parent=#mobf_factions] setupmob(factionsdata)
--
--! @brief creat factions a mob may be member of
--! @memberof mobf_factions
--
--! @param factionsdata data to set for mob
--
-------------------------------------------------------------------------------
function mobf_factions.setupmob(factionsdata)
	if mobf_rtd.factions_available then
		if factionsdata ~= nil and
			factionsdata.member ~= nil then

			for i=1,#factionsdata.member,1 do
				if not factions.exists(factionsdata.member[i]) then
					factions.add_faction(factionsdata.member[i])
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_factions] setupentity(entity,preserved_data)
--
--! @brief add a mob to it's factons
--! @memberof mobf_factions
--
--! @param entity to be added to it's factions
--! @param preserved_data mob reputation data
--
-------------------------------------------------------------------------------
function mobf_factions.setupentity(entity,preserved_data)
	if mobf_rtd.factions_available then
		if entity.data.factions ~= nil and
			entity.data.factions.member ~= nil then

			for i=1,#entity.data.factions.member,1 do
				factions.member_add(entity.data.factions.member[i],entity)
			end
		end


		if preserved_data ~= nil then
			for i=1,#preserved_data,1 do
				factions.member_add(preserved_data[i],entity)
			end
		end
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_factions] cleanup_entity(entity)
--
--! @brief called on deactivation of a mob
--! @memberof mobf_factions
--
--! @param entity to be cleant up
--
-------------------------------------------------------------------------------
function mobf_factions.cleanupentity(entity)
	if mobf_rtd.factions_available then
		return factions.get_factions(entity.object)
	else
		return ""
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_factions] mob_rightclick_callback(entity,player)
--
--! @brief show factions rightclick menu
--! @memberof mobf_factions
--
--! @param entity to modify
--! @param player issuing rightclick
--
-------------------------------------------------------------------------------
function mobf_factions.mob_rightclick_callback(entity,player)
	local menu_data = {}

	local new_id = mobf_global_data_store(menu_data)

	menu_data.entity = entity
	menu_data.player = player

	mobf_factions.show_mob_factions_menu(new_id,menu_data)
end


-------------------------------------------------------------------------------
-- @function [parent=#mobf_factions] config_check(entity,player)
--
--! @brief show factions rightclick menu
--! @memberof mobf_factions
--
--! @param entity clicked
--
-------------------------------------------------------------------------------
function mobf_factions.config_check(entity)
	if not mobf_rtd.factions_available then
		return false
	end
	if entity.dynamic_data.spawning.spawner ~= nil then
		return true
	end
	return false
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_factions] button_handler(entity,player)
--
--! @brief show factions rightclick menu
--! @memberof mobf_factions
--
--! @param player issuing rightclick
--! @param formname name of form being transmitted
--! @param fields date for fields in current form
--
-------------------------------------------------------------------------------
function mobf_factions.button_handler(player, formname, fields)
	local playername = player:get_player_name()

	mobf_assert_backtrace(playername ~= nil)

	if formname == "mobf:factions:main_menu" then
		dbg_mobf.path_lvl2("MOBF: factions menu opened")
		for k,v in pairs(fields) do
			local parts = string.split(k,":")

			if parts[1] == "mobf_factions" then

				local menu_data = mobf_factions.handle_rightclick(parts,fields,formname,player,k)

				if menu_data  ~= nil then
					--push data back to store
					local new_id = mobf_global_data_store(menu_data)
					mobf_factions.show_mob_factions_menu(new_id,menu_data)
					break
				end

			end
		end
		return true
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_factions] handle_rightclick(current_fields,fields,formname,player,fieldname)
--
--! @brief show factions rightclick menu
--! @memberof mobf_factions
--
--! @param current_fields
--! @param fields
--! @param formname
--! @param player
--! @param fieldname name of field causingt the callback
--
--! @return true/false show menu again
-------------------------------------------------------------------------------
function mobf_factions.handle_rightclick(current_fields,fields,formname,player,fieldname)
	print("current_fields: " .. dump(current_fields))
	--try to read data from global store
	local menu_data = mobf_global_data_get(current_fields[3])
	if menu_data ~= nil then
		if current_fields[2]  == "btn_add_mob_faction" then
			if menu_data.tl_owner_selected ~= nil then
				local factionlist_owner = factions.get_factions(menu_data.player)

				if factionlist_owner ~= nil and
					#factionlist_owner >= menu_data.tl_owner_selected then

					local toadd = factionlist_owner[menu_data.tl_owner_selected]
					factions.member_add(toadd,menu_data.entity.object)
				end
			end
		elseif current_fields[2]  == "btn_drop_mob_faction" then
			if menu_data.tl_mob_selected ~= nil then
				local factionlist_mob = factions.get_factions(menu_data.entity.object)

				local todel = factionlist_mob[menu_data.tl_mob_selected]

				if factions.is_member(todel,player) then
					factions.member_remove(todel,menu_data.entity.object)
				else
					--TODO maybe send chat message
					print("MOBF Factions you're not member of " .. todel .. " so you can't remove a mob from it")
				end
			else
				print("MOBF Factions: trying to delete from faction but no faction selected")
			end
		elseif current_fields[2] == "tl_mob_factions" then
			local event = explode_textlist_event(fields[fieldname])

			if event.typ ~= "INV" then
				menu_data.tl_mob_selected = event.index
			end
		elseif current_fields[2] == "tl_owner_factions" then
			local event = explode_textlist_event(fields[fieldname])

			if event.typ ~= "INV" then
				menu_data.tl_owner_selected = event.index
			end
		end
	else
		dbg_mobf.path_lvl1("MOBF: factions menu failed to find menu_data")
	end

	return menu_data
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_factions] show_mob_factions_menu(new_id,menu_data)
--
--! @brief show factions rightclick menu
--! @memberof mobf_factions
--
--! @param new_id
--! @param menu_data
--
--! @return true/false show menu again
-------------------------------------------------------------------------------
function mobf_factions.show_mob_factions_menu(new_id,menu_data)

	mobf_assert_backtrace(menu_data.entity ~= nil)
	mobf_assert_backtrace(menu_data.player ~= nil)

	local playername = menu_data.player:get_player_name()

	local formspec =  ""

	--check if menu creator is owner of the specific mob
	if menu_data.entity.dynamic_data.spawning.spawner == playername then

		if menu_data.tl_mob_selected == nil then
			menu_data.tl_mob_selected = 0
		end

		if menu_data.tl_owner_selected == nil then
			menu_data.tl_owner_selected = 0
		end

		formspec = formspec .. "size[8,8]"
				.."label[0,-0.25;Member of factions:]"
				.."textlist[0,0.3;3.7,7;mobf_factions:tl_mob_factions:" .. new_id .. ";"

		local factionlist_mob = factions.get_factions(menu_data.entity.object)

		if #factionlist_mob ~= 0 then
			for i=1,#factionlist_mob,1 do
				formspec = formspec .. factionlist_mob[i] .. ","
			end
		else
			formspec = formspec .. "not member of any faction"
		end

		formspec = formspec .. ";" .. menu_data.tl_mob_selected .. "]"

		local factionlist_player = factions.get_factions(menu_data.player)

		formspec = formspec
				.."label[4,-0.25;Owner factions:]"
				.."textlist[4,0.3;3.7,7;mobf_factions:tl_owner_factions: " .. new_id .. ";"

		if #factionlist_player ~= 0 then
			for i=1,#factionlist_player,1 do
				formspec = formspec .. factionlist_player[i] .. ","
			end
		else
			formspec = formspec .. "not member of any faction"
		end

		formspec = formspec .. ";" .. menu_data.tl_owner_selected .. "]"

		formspec = formspec
			.. "button[0,7.5;3.95,0.5;mobf_factions:btn_drop_mob_faction:" .. new_id .. ";Remove from faction]"
			.. "button[4,7.5;3.95,0.5;mobf_factions:btn_add_mob_faction:" .. new_id .. ";<-- Mob join faction]"


	else
		formspec = "label[0,0;This is not your mob keep away!]"
	end

	--show formspec
	minetest.show_formspec(playername,"mobf:factions:main_menu",formspec)
end