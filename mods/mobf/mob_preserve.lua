-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file mob_preserve.lua
--! @brief component containing spawning features
--! @copyright Sapier
--! @author Sapier
--! @date 2013-01-29
--

--! @defgroup mob_preserve gui to reclaim mobs removed by error handling
--! @brief gui to reclaim error removed player spawned mobs
--! @ingroup framework_int
--! @{
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(mob_preserve == nil)
--! @class mob_preserve
--! @brief mob preserve features
--!@}
mob_preserve = {}
mob_preserve.entrys_per_page = 10

------------------------------------------------------------------------------
-- @function [parent=#mob_preserve] init()
--
--! @brief initialize dynamic data
--! @memberof mob_preserve
--! @public
------------------------------------------------------------------------------
function mob_preserve.init()

	local preserved_mobs_raw = mobf_get_world_setting("mobf_preserve_mobs")

	if preserved_mobs_raw ~= nil then
	mob_preserve.current_preserve_list =
			minetest.deserialize(preserved_mobs_raw)

	end

	if mob_preserve.current_preserve_list == nil then
		mob_preserve.current_preserve_list = {}
	end

	minetest.register_chatcommand("mobf_restore_mobs",
		{
			params		= "",
			description = "show list of stored mobs" ,
			privs		= {},
			func		= mob_preserve.handle_command
		})

	minetest.register_on_player_receive_fields(mob_preserve.button_callback)
end

------------------------------------------------------------------------------
-- @function [parent=#mob_preserve] handle_remove(entity,reason)
--
--! @brief check if a mob needs to be preserved
--! @memberof mob_preserve
--! @public
--
--! @param entity entity to check
--! @param reason reason for removal
-------------------------------------------------------------------------------
function mob_preserve.handle_remove(entity,reason)

	if reason ~= "cought" and
		reason ~= "killed" and
		reason ~= "died by sun" and
		reason ~= "replaced" then

		if entity.dynamic_data.spawning.player_spawned then
			local toset = {}

			toset.modname = entity.data.modname
			toset.name    = entity.data.name
			toset.owner   = entity.dynamic_data.spawning.spawner
			toset.reason  = reason

			if toset.owner ~= nil then
				dbg_mobf.mob_preserve_lvl2("MOBF: preserving " .. toset.modname ..
					":" .. toset.name .. " for player " .. toset.owner )
				table.insert(mob_preserve.current_preserve_list,toset)

				mobf_set_world_setting("mobf_preserve_mobs",
					minetest.serialize(mob_preserve.current_preserve_list))
			else
				dbg_mobf.mob_preserve_lvl1("MOBF: unable to preserve mob")
			end
		else
			dbg_mobf.mob_preserve_lvl2("MOBF: not preserving " .. entity.data.name
				.. " it's not playerspawned: " .. dump(entity.dynamic_data.spawning) )
		end
	else
		dbg_mobf.mob_preserve_lvl2("MOBF: not preserving " .. entity.data.name
			.. " removed by valid reason" )
	end
end

------------------------------------------------------------------------------
-- @function [parent=#mob_preserve] handle_rightclick(name,param)
--
--! @brief show list of removed mobs
--! @memberof mob_preserve
--! @public
--
--! @param name name of formspec
--! @param param unused parameter
-------------------------------------------------------------------------------
function mob_preserve.handle_command(name,param)

	local formspec = mob_preserve.get_formspec(name,0)
	minetest.show_formspec(name,"mob_preserve:main",formspec)
end


------------------------------------------------------------------------------
-- @function [parent=#mob_preserve] get_formspec(name,page)
--
--! @brief generate page form for mob_preserve
--! @memberof mob_preserve
--! @private
--
--! @param name player to create page for
--! @param pagenum pagenumber to create
-------------------------------------------------------------------------------
function mob_preserve.get_formspec(name,pagenum)
	mobf_assert_backtrace(name ~= nil)
	mobf_assert_backtrace(pagenum ~= nil)

	local isadmin = minetest.check_player_privs(name, {mobfw_admin=true}) or minetest.is_singleplayer()

	local min_entry_number = pagenum * mob_preserve.entrys_per_page +1

	local pageform = ""
	local elementcount = 1

	dbg_mobf.mob_preserve_lvl3("MOBF: preserve starting list at " .. dump(min_entry_number ))
	for n=1,#mob_preserve.current_preserve_list, 1 do

		if mob_preserve.current_preserve_list[n].owner == name or
			isadmin then

			if elementcount >= min_entry_number then
				local fixed_owner_name = mobf_fixed_size_string(name,12)
				local fixed_reason     = mobf_fixed_size_string(
					mob_preserve.current_preserve_list[n].reason,24)

				local y_pos = 1.0 + elementcount * 0.75

				pageform = pageform .. " " ..
							"label[0.5," .. y_pos .. ";" .. fixed_owner_name .. "]" ..
							"label[3.0," .. y_pos .. ";" .. fixed_reason .. "]" ..
							"label[6.5," .. y_pos .. ";" ..
							mob_preserve.current_preserve_list[n].modname .. ":" ..
							mob_preserve.current_preserve_list[n].name .. "]" ..
							"button[10.5," .. y_pos .. ";2,0.5;take_" ..
							elementcount .. "_" .. "_" ..
							#mob_preserve.current_preserve_list .. "_" ..
							pagenum .. ";take]"
			end

			elementcount = elementcount +1

			if elementcount > min_entry_number + mob_preserve.entrys_per_page then
				break
			end
		end
	end

	local pup = ""
	local pdown = ""

	if pagenum > 0 then
		local upper_page = pagenum -1
		pup = "button[5.5,0;2,0.5;page_" .. upper_page .. ";page up]"
	end

	if pagenum < (#mob_preserve.current_preserve_list /  mob_preserve.entrys_per_page) then
		local lower_page = pagenum +1
		pdown = "button[5.5,9.5;2,0.5;page_" .. lower_page .. ";page down]"
	end

	local admininfo = ":"
	if isadmin then
		admininfo = " total: " .. #mob_preserve.current_preserve_list
	end

	return "size[13,10]"
			..pup
			..pdown
			.."button_exit[11,9.5;2,0.5;main; Exit]"
			.."label[0.5,0;Stashed mobs".. admininfo .. "]"
			.."label[11.5,0;Page " .. pagenum .. "]"
			.. pageform
end


------------------------------------------------------------------------------
-- @function [parent=#mob_preserve] button_callback(player,formname,fields)
--
--! @brief handle button callback
--! @memberof mob_preserve
--! @private
--
--! @param player player doing button click
--! @param formname name of form clicked
--! @param fields fields active
-------------------------------------------------------------------------------
function mob_preserve.button_callback(player, formname, fields)

	dbg_mobf.mob_preserve_lvl3("MOBF: preserve checking formname " .. dump(formname))
	if formname == "mob_preserve:main" then
		dbg_mobf.mob_preserve_lvl3("MOBF: preserve detected own form: " .. dump(fields))
		--evaluate fields
		for k,v in pairs(fields) do
			dbg_mobf.mob_preserve_lvl3("MOBF: preserve splitting: >" .. k .. "<")
			local parts = string.split(k,"_")
			dbg_mobf.mob_preserve_lvl3("MOBF: preserve got " .. dump(parts[1]) .. " "
				.. dump(parts[2]) .. " " .. dump(parts[3]) .. " " .. dump(parts[4]))

			if parts[1] == "take" then
				local torestore = tonumber(parts[2])
				local totalnumber = tonumber(parts[3])

				--give mob to player
				mob_preserve.retake_mob(player,torestore,totalnumber)

				parts[1] = "page"
				parts[2] = parts[4]
			end

			if parts[1] == "page" then
				local count = tonumber(parts[2])
				local playername = player:get_player_name()

				if count ~= nil and
					playername ~= nil then
					local formspec = mob_preserve.get_formspec(playername,count)

					minetest.show_formspec(playername,"mob_preserve:main",formspec)
				else
					dbg_mobf.mob_preserve_lvl3("MOBF: preserve invalid data " ..
						dump(count) .. " " .. dump(playername))
				end
			end
		end

		return true
	end
	return false
end

------------------------------------------------------------------------------
-- @function [parent=#mob_preserve] retake_mob(player,entrynumber,totalnumber)
--
--! @brief give mob back to player
--! @memberof mob_preserve
--! @private
--
--! @param player player doing button click
--! @param entrynumber number of entry to give back to player
--! @param total number of entrys on time of form creation
-------------------------------------------------------------------------------
function mob_preserve.retake_mob(player,entrynumber,total)

	--this isn't a 100% check but reduces chance of list corruption
	if total ~= #mob_preserve.current_preserve_list then
		return
	end

	local playername = player:get_player_name()
	local isadmin = minetest.check_player_privs(playername, {mobfw_admin=true})

	local elementcount = 0

	for i=1,#mob_preserve.current_preserve_list,1 do

		if mob_preserve.current_preserve_list[i].owner == playername or
			isadmin then
			elementcount = elementcount +1
		end

		if elementcount == entrynumber then
			--TODO check if player has enough room

						--ADD to inventory
			player:get_inventory():add_item("main",
					mob_preserve.current_preserve_list[i].modname ..":"..
					mob_preserve.current_preserve_list[i].name.." 1")

			--remove from list
			table.remove(mob_preserve.current_preserve_list,i)
			mobf_set_world_setting("mobf_preserve_mobs",
					minetest.serialize(mob_preserve.current_preserve_list))
			return
		end
	end
end
