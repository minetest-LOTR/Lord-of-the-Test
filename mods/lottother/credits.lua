local green = "#109e03"
local blue = "#03159e"
local red = "#9e0310"
local purple = "#67039e"

local credits = "size[10,8]" ..
    "background[10,8;1,1;gui_formbg.png;true]" ..
    "label[0.5,0.25;" .. minetest.colorize("black", "LOTT Credits:") .. "]" ..
    "label[1,1;" .. minetest.colorize(green, "Main Developers:") .. "]" ..
    "label[1.5,1.5;" .. minetest.colorize(green, "fishyWET") .. "]" ..
    "label[1.5,2;" .. minetest.colorize(green, "Amaz") .. "]" ..
    "label[1,3;" .. minetest.colorize(blue, "Other Developers:") .. "]" ..
    "label[1.5,3.5;" .. minetest.colorize(blue, "catninja") .. "]" ..
    "label[1.5,4;" .. minetest.colorize(blue, "Flipsels") .. "]" ..
    "label[1.5,4.5;" .. minetest.colorize(blue, "MadTux") .. "]" ..
    "label[1.5,5;" .. minetest.colorize(blue, "BadToad2000") .. "]" ..
    "label[1.5,5.5;" .. minetest.colorize(blue, "lumidify") .. "]" ..
    "label[1.5,6;" .. minetest.colorize(blue, "narrnika") .. "]" ..
    "label[5,1;" .. minetest.colorize(red, "Model Makers:") .. "]" ..
    "label[5.5,1.5;" .. minetest.colorize(red, "STHGOM") .. "]" ..
    "label[5.5,2;" .. minetest.colorize(red, "AspireMint") .. "]" ..
    "label[5,3;" .. minetest.colorize(purple, "Main Texture Makers:") .. "]" ..
    "label[5.5,3.5;" .. minetest.colorize(purple, "philipbenr") .. "]" ..
    "label[5.5,4;" .. minetest.colorize(purple, "Gabo") .. "]" ..
    "label[5.5,4.5;" .. minetest.colorize(purple, "Many others!") .. "]" ..
    "button[5.5,5.5;2,1;mods;" .. minetest.colorize("yellow", "More info!!") .. "]"

local purple2 = "#c804cc"
local green2 = green

local mods = {
    "boats", "bones", "bucket", "creative",
    "darkage", "default", "doors", "dye", "farming",
    "fire", "flowers", "lottarmor", "lottblocks",
    "lottclasses", "lottclothes", "lottfarming",
    "lottinventory", "lottmapgen", "lottmobs",
    "lottores", "lottother", "lottplants",
    "lottpotion", "lottspecial", "lottthrowing",
    "lottweapons", "mobs", "screwdriver", "stairs",
    "stamina", "vessels", "wool"
}

local more_credits = "size[11,8]" ..
    "background[11,8;1,1;gui_formbg.png;true]" ..
    "label[0.25,0.25;" .. minetest.colorize("gray", "Mod License Information:") .. "]"

local colours = {
    "red",
    "orange",
    "yellow",
    green2,
    "blue",
    "purple",
    purple2
}

local count = 0
local distance = 0.5
for i,v in pairs(mods) do
    count = count + 1
    if count > 7 then
        count = 1
        distance = distance + 2
    end
    more_credits = more_credits ..
        "button[".. distance .. "," .. count .. ";2,1;" ..
        v .. ";" .. minetest.colorize(colours[count], v) .. "]"
    if count >= #mods then
        count = 0
        distance = 0.5
    end
end

minetest.register_chatcommand("credits", {
	params = "",
	description = "Credits of LOTT",
	func = function(name, param)
		minetest.show_formspec(name, "lott_credits", credits)
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "lott_credits" then
        if fields.mods then
            minetest.show_formspec(player:get_player_name(), "lott_more_credits",
                more_credits)
        end
    elseif formname == "lott_more_credits" then
        for i,v in pairs(mods) do
            if fields[v] then
                local form = "size[12,10]" ..
                    "background[10,8;1,1;gui_formbg.png;true]" ..
                    "label[0,-0.2;" ..
                    minetest.colorize("black", "License of " .. v .. " mod:") .. "]" ..
                    "button[10,1;2,1;back_to_mods;Back]" ..
                    "textlist[0,0.5;10,9;license;"
                local file = io.open(minetest.get_modpath(v) .. "/license.txt")
                if not file then return end
                local license = file:read('*a')
                file:close()
                local lines = {}
                for str in (license .. "\n"):gmatch("([^\n]*)[\n]") do
                	lines[#lines+1] = str
                end
                for j,w in pairs(lines) do
                    if j == #lines then
                        form = form .. "#000000" ..
                            minetest.formspec_escape(w) .. ";-1;true]"
                    elseif w ~= "" then
                        form = form .. "#000000" ..
                        minetest.formspec_escape(w) .. ","
                    end
                end
                minetest.show_formspec(player:get_player_name(), "mod_license",
                    form)
            end
        end
    elseif formname == "mod_license" then
        if fields.back_to_mods then
            minetest.show_formspec(player:get_player_name(), "lott_more_credits",
                more_credits)
        end
    end
end)
