minetest.register_chatcommand("npcf", {
	params = "<cmd> [npc_name] [args]",
	description = "NPC Management",
	func = function(name, param)
		local index = npcf:get_index()
		local admin = minetest.check_player_privs(name, {server=true})
		local cmd, npc_name, args = string.match(param, "^([^ ]+) (.-) (.+)$")
		if cmd and npc_name and args then
			if cmd == "setguardhome" then
				if admin or name == index[npc_name] then
					local pos = minetest.string_to_pos(args)
					if args == "here" then
						local player = minetest.get_player_by_name(name)
						if player then
							pos = player:getpos()
						end
					end
					if pos then
						pos.y = pos.y + 1
						local luaentity = npcf:get_luaentity(npc_name)
						if luaentity then
							if admin or luaentity.owner == name then
								luaentity.object:setpos(pos)
								luaentity.origin.pos = pos
								npcf:save(luaentity)
								pos = minetest.pos_to_string(pos)
								minetest.log("action", name.." set the Guard "..npc_name.." home to "..pos)
							end 
						end
					else
						minetest.chat_send_player(name, "Invalid position "..args)
					end
				end
			elseif cmd == "teleport" then
				if admin or name == index[npc_name] then
					local pos = minetest.string_to_pos(args)
					if args == "here" then
						local player = minetest.get_player_by_name(name)
						if player then
							pos = player:getpos()
						end
					end
					if pos then
						pos.y = pos.y + 1
						if npcf:load(npc_name, pos) then
							minetest.after(1, function()
								local luaentity = npcf:get_luaentity(npc_name)
								if luaentity then
									npcf:save(luaentity)
									pos = minetest.pos_to_string(pos)
									minetest.log("action", name.." heals and teleport Guard "..npc_name.." to "..pos)
								else
									minetest.chat_send_player(name, "Unable to teleport and heal "..npc_name)
								end
							end)
						end
					else
						minetest.chat_send_player(name, "Invalid position "..args)
					end
				end
			elseif cmd == "tell" then
				if admin or name == index[npc_name] then
					local luaentity = npcf:get_luaentity(npc_name)
					if luaentity and luaentity.on_tell then
						luaentity.on_tell(luaentity, name, args)
					end
				else
					minetest.chat_send_player(name, "You don't have permission to tell "..npc_name.." things")
				end
			elseif cmd == "setskin" then
				if admin or name == index[npc_name] then
					if args == "random" then
						local textures = {}
						if minetest.get_modpath("skins") then
							for _,skin in ipairs(skins.list) do
								if string.match(skin, "^character_") then
									table.insert(textures, skin..".png")
								end
							end
							args = textures[math.random(1, #textures)]
						else
							minetest.chat_send_player(name, "Skins mod not found!")
							return
						end
					end
					local luaentity = npcf:get_luaentity(npc_name)
					if luaentity then
						luaentity.properties.textures[1] = args
						luaentity.object:set_properties(luaentity.properties)
					end
				end
			end
			return
		end
		cmd, npc_name = string.match(param, "([^ ]+) (.+)")
		if cmd and npc_name then
			if cmd == "kill" then
                    if admin or name == index[npc_name] then
				npcf:clear(npc_name)
				local input = io.open(NPCF_DATADIR.."/"..npc_name..".npc", "r")
				if input then
					io.close(input)
					os.remove(NPCF_DATADIR.."/"..npc_name..".npc")
				end
				if index[npc_name] then
					index[npc_name] = nil
					local output = io.open(NPCF_DATADIR.."/index.txt", 'w')
					if output then
						output:write(minetest.serialize(index))
						io.close(output)
					end
					minetest.log("action", name.." kills NPC "..npc_name)
				end
               end
			elseif cmd == "clear" then
				if admin or name == index[npc_name] then
					npcf:clear(npc_name)
					minetest.log("action", name.." clears NPC "..npc_name)
				end
			elseif cmd == "heal" then
				if admin or name == index[npc_name] then
					if npcf:load(npc_name, nil) then
						minetest.log("action", name.." heals Guard "..npc_name)
					else
						minetest.chat_send_player(name, "Unable to heal "..npc_name)
					end
				end
			elseif cmd == "save" then
				if admin or name == index[npc_name] then
					local saved = false
					local luaentity = npcf:get_luaentity(npc_name)
					if luaentity then
						if npcf:save(luaentity) then
							saved = true
							minetest.chat_send_player(name, npc_name.." has been saved")
							minetest.log("action", name.." saves NPC "..npc_name)
						end
					end
					if saved == false then
						minetest.chat_send_player(name, "Unable to save "..npc_name)
					end
				end
			elseif cmd == "getpos" then
				local located = false
				local luaentity = npcf:get_luaentity(npc_name)
				if luaentity then
					local pos = luaentity.object:getpos()
					if pos then
						pos.x = math.floor(pos.x * 10) * 0.1
						pos.y = math.floor(pos.y * 10) * 0.1 - 1
						pos.z = math.floor(pos.z * 10) * 0.1
						local msg = npc_name.." located at "..minetest.pos_to_string(pos)
						minetest.chat_send_player(name, msg)
						located = true
					end
				end
				if located == false then
					minetest.chat_send_player(name, "Unable to locate "..npc_name)
				end
			end
			return
		end
		cmd = string.match(param, "([^ ]+)")
		if cmd then
			if cmd == "list" then
				local npclist = {}
				local index = npcf:get_index()
				if index then
					for npc_name,_ in pairs(index) do
						table.insert(npclist, npc_name)
					end
				end
				local msg = "None"
				if #npclist > 0 then
					msg = table.concat(npclist, ", ")
				end
				minetest.chat_send_player(name, "NPC List: "..msg)
			elseif cmd == "clearobjects" and admin then
				minetest.log("action", name.." clears all NPC objects")
				for _,ref in pairs(minetest.luaentities) do
					if ref.object and ref.npcf_id then
						ref.object:remove()
					end
				end
			elseif cmd == "loadobjects" and admin then
				minetest.log("action", name.." reloads all NPC objects")
				for npc_name,_ in pairs(index) do
					npcf:load(npc_name, nil)
				end
			end
		end
	end,
})

