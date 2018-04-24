--Modified from builtin/game/chatcommands.lua to hide privs starting with GAME

minetest.register_chatcommand("privs", {
	params = "<name>",
	description = "print out privileges of player",
	func = function(name, param)
		param = (param ~= "" and param or name)
		local privs_table = minetest.get_player_privs(param)
		local privs = ""
		local i = 1
		for key,value in pairs(privs_table) do
			if key:match("GAME", 1) then
				key, value = nil
			elseif i == 1 then
				privs = privs .. key
				i = i + 1
			else
				privs = privs .. ", " .. key
				i = i + 1
			end
		end
		return true, "Privileges of " .. param .. ": " .. privs
	end,
})

minetest.register_chatcommand("grant", {
	params = "<name> <privilege>|all",
	description = "Give privilege to player",
	func = function(name, param)
		if not minetest.check_player_privs(name, {privs=true}) and
			not minetest.check_player_privs(name, {basic_privs=true}) then
			return false, "Your privileges are insufficient."
		end
		local grant_name, grantprivstr = string.match(param, "([^ ]+) (.+)")
		if not grant_name or not grantprivstr then
			return false, "Invalid parameters (see /help grant)"
		elseif not minetest.player_exists(grant_name) then
			return false, "Player " .. grant_name .. " does not exist."
		end
		local grantprivs = minetest.string_to_privs(grantprivstr)
		if grantprivstr == "all" then
			grantprivs = minetest.registered_privileges
		end
		local privs = minetest.get_player_privs(grant_name)
		local privs_unknown = ""
		for priv, _ in pairs(grantprivs) do
			if priv ~= "interact" and priv ~= "shout" and
					not minetest.check_player_privs(name, {privs=true}) then
				return false, "Your privileges are insufficient."
			end
			if not minetest.registered_privileges[priv] then
				privs_unknown = privs_unknown .. "Unknown privilege: " .. priv .. "\n"
			end
			if not priv:match("GAME", 1) then
				privs[priv] = true
            end
		end
		if privs_unknown ~= "" then
			return false, privs_unknown
		end
		minetest.set_player_privs(grant_name, privs)
		local privs_table = minetest.get_player_privs(grant_name)
		local privs_string = ""
		local i = 1
		for key,value in pairs(privs_table) do
			if key:match("GAME", 1) then
				key, value = nil
			elseif i == 1 then
				privs_string = privs_string .. key
				i = i + 1
			else
				privs_string = privs_string .. ", " .. key
				i = i + 1
			end
		end
		minetest.log("action", name..' granted ' .. privs_string .. ' privileges to '.. grant_name)
		if grant_name ~= name then
			minetest.chat_send_player(grant_name, name
					.. " granted you privileges: "
					.. privs_string)
		end
		return true, "Privileges of " .. grant_name .. ": " .. privs_string
	end,
})

minetest.register_chatcommand("grantme", {
	params = "<privilege>|all",
	description = "Give privilege to yourself",
	func = function(name, param)
		if not minetest.check_player_privs(name, {privs=true}) and
			not minetest.check_player_privs(name, {basic_privs=true}) then
			return false, "Your privileges are insufficient."
		end
		if not param then
			return false, "Invalid parameters (see /help grant)"
		end
		local grantprivs = minetest.string_to_privs(param)
		if param == "all" then
			grantprivs = minetest.registered_privileges
		end
		local privs = minetest.get_player_privs(name)
		local privs_unknown = ""
		for priv, _ in pairs(grantprivs) do
			if priv ~= "interact" and priv ~= "shout" and
					not minetest.check_player_privs(name, {privs=true}) then
				return false, "Your privileges are insufficient."
			end
			if not minetest.registered_privileges[priv] then
				privs_unknown = privs_unknown .. "Unknown privilege: " .. priv .. "\n"
			end
			if not priv:match("GAME", 1) then
				privs[priv] = true
            end
		end
		if privs_unknown ~= "" then
			return false, privs_unknown
		end
		minetest.set_player_privs(name, privs)
		local privs_table = minetest.get_player_privs(name)
		local privs_string = ""
		local i = 1
		for key,value in pairs(privs_table) do
			if key:match("GAME", 1) then
				key, value = nil
			elseif i == 1 then
				privs_string = privs_string .. key
				i = i + 1
			else
				privs_string = privs_string .. ", " .. key
				i = i + 1
			end
		end
		minetest.log("action", name ..' granted ' .. privs_string .. ' privileges to him/herself')
		return true, "Privileges of " .. name .. ": " .. privs_string
	end,
})

minetest.register_chatcommand("revoke", {
	params = "<name> <privilege>|all",
	description = "Remove privilege from player",
	privs = {},
	func = function(name, param)
		if not minetest.check_player_privs(name, {privs=true}) and
				not minetest.check_player_privs(name, {basic_privs=true}) then
			return false, "Your privileges are insufficient."
		end
		local revoke_name, revoke_priv_str = string.match(param, "([^ ]+) (.+)")
		if not revoke_name or not revoke_priv_str then
			return false, "Invalid parameters (see /help revoke)"
		elseif not minetest.player_exists(revoke_name) then
			return false, "Player " .. revoke_name .. " does not exist."
		end
		local revoke_privs = minetest.string_to_privs(revoke_priv_str)
		local privs = minetest.get_player_privs(revoke_name)
		for priv, _ in pairs(revoke_privs) do
			if priv ~= "interact" and priv ~= "shout" and
					not minetest.check_player_privs(name, {privs=true}) then
				return false, "Your privileges are insufficient."
			end
		end
		if revoke_priv_str == "all" then
            for priv, _ in pairs(privs) do
                if priv:find("GAME", 1) == nil then
                    privs[priv] = nil
                end
			end
		else
			for priv, _ in pairs(revoke_privs) do
                if priv:find("GAME", 1) == nil then
                    privs[priv] = nil
                end
			end
		end
		minetest.set_player_privs(revoke_name, privs)
        local privs_table = minetest.get_player_privs(revoke_name)
		local privs_string = ""
		local i = 1
		for key,value in pairs(privs_table) do
			if key:match("GAME", 1) then
				key, value = nil
			elseif i == 1 then
				privs_string = privs_string .. key
				i = i + 1
			else
				privs_string = privs_string .. ", " .. key
				i = i + 1
			end
		end
		minetest.log("action", name..' revoked ('
				.. privs_string
				..') privileges from '..revoke_name)
		if revoke_name ~= name then
			minetest.chat_send_player(revoke_name, name
					.. " revoked privileges from you: "
					.. privs_string)
		end
		return true, "Privileges of " .. revoke_name .. ": " .. privs_string
	end,
})
