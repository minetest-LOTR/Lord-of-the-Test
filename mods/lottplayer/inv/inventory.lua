
-- Inventory API --
--[[

>>> Support for nodemeta inventories

on_receive_fields -- required to update the inventories
	lottplayer.inv_update(player, fields)
	meta:set_string("formspec",
		<nodemeta_inventory>..
		lottplayer.inv(player))
		
	if fields.quit then -- required so that the switchable inventories is updated, because nodemeta receive fields doesnt update global receive fields
		lottplayer.inv_quit(player)
	end
	
on_rightclick -- required because on_construct doesn't have a player value that lottplayer.inv needs, so rightclick will be the one that is constructing the inventory instead
	meta:set_string("formspec",
		<nodemeta_inventory>..
		lottplayer.inv(player))

>>> Inventory sizes (to be added to formspecs)

lottplayer.inv_size("<size>")
Supported sizes: 4x4 / 4x6

]]

minetest.register_on_joinplayer(function(player)
	player:set_formspec_prepend([[
			bgcolor[#080808BB;true]
			listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF] ]])
end)

lottplayer.inv_size = function(size)
	if size == "4x4" then
		return
			"size[10,3.5]"..
			"background[10,3.5;0,0;gui_formbg_dual.png;true]"
	elseif size == "4x6" then
		return
			"size[10,5.5]"..
			"background[10,5.5;0,0;gui_formbg_dual_left_long.png;true]"
	else
		return
			"size[10,3.5]"..
			"background[10,3.5;0,0;gui_formbg_dual.png;true]"
	end
end

lottplayer.nav_buttons =
	"image_button[7.775,-1.10;1,1;icon_arrow_mini.png;lottplayer_inv_up;;true;false;icon_arrow_mini.png^\\[brighten]"..	"image_button[7.775,3.80;1,1;icon_arrow_mini_d.png;lottplayer_inv_down;;true;false;icon_arrow_mini_d.png^\\[brighten]"
	
lottplayer.nav_buttons_force =
	"image_button[7.775,-1.10;1,1;icon_arrow_mini.png;lottplayer_inv_up_force;;true;false;icon_arrow_mini.png^\\[brighten]"..	"image_button[7.775,3.80;1,1;icon_arrow_mini_d.png;lottplayer_inv_down_force;;true;false;icon_arrow_mini_d.png^\\[brighten]"

lottplayer.inv_survival =
	"list[current_player;main;6.24,-0.15;4,4;]"..
	"listring[current_player;main]"
	
lottplayer.inv_crafting =
	"list[current_player;craft;6.74,-0.15;3,3;]"..
	"list[current_player;craftpreview;7.74,2.85;1,1;]"..
	"listring[current_player;craft]"

lottplayer.inv_armour =
	"image[7.35,0.1;2,4;character_preview.png]"..
	"list[current_player;main;6.24,-0.15;1,4;]"..
	"list[current_player;main;9.24,-0.15;1,4;]"..
	"list[current_player;main;8.24,1.85;1,1;4]"..
	"listring[current_player;main]"
	
	
	
	
	
	