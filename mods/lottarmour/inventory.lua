
lottarmour.inv_armour = function(player)
	local name = player:get_player_name()
	local meta = player:get_meta()
	return
	"image[7.35,0.1;2,4;character_preview.png]"..
	"list[detached:"..name.."_armour;armour;6.24,-0.15;1,4;]".. --armour
	"list[detached:"..name.."_armour;armour;9.24,-0.15;1,4;]".. --clothing
	"list[detached:"..name.."_armour;armour;8.24,1.85;1,1;4]".. --shield
	"listring[detached:"..name.."_armour;armour]"..
	--"listring[detached:"..name.."_clothing;clothing]"..
	
	"image_button[5.27,-0.2;0.9,0.9;armour_icon_fleshy.png;lottarmour_fleshy_protect;"..meta:get_string("lottarmour:fleshy")..";true;false;]"..
	"image_button[5.27,0.6;0.9,0.9;armour_icon_pierce.png;lottarmour_pierce_protect;"..meta:get_string("lottarmour:pierce")..";true;false;]"..
	"image_button[5.27,1.4;0.9,0.9;armour_icon_blunt.png;lottarmour_blunt_protect;"..meta:get_string("lottarmour:blunt")..";true;false;]"..
	"image_button[5.27,2.2;0.9,0.9;armour_icon_stab.png;lottarmour_stab_protect;"..meta:get_string("lottarmour:stab")..";true;false;]"..
	
	"tooltip[lottarmour_fleshy_protect;"..meta:get_string("lottarmour:fleshy").."% Protection against Slash weapons]"..
	"tooltip[lottarmour_pierce_protect;"..meta:get_string("lottarmour:pierce").."% Protection against Pierce weapons]"..
	"tooltip[lottarmour_blunt_protect;"..meta:get_string("lottarmour:blunt").."% Protection against Blunt weapons]"..
	"tooltip[lottarmour_stab_protect;"..meta:get_string("lottarmour:stab").."% Protection against Stab weapons]"
end
	
	
lottarmour.inv_armour_left = function(player)
	local name = player:get_player_name()
	local meta = player:get_meta()
	return
	"image[0.9,0.1;2,4;character_preview.png]"..
	"list[detached:"..name.."_armour;armour;-0.20,-0.15;1,4;]"..
	"list[detached:"..name.."_armour;armour;2.80,-0.15;1,4;]"..
	"list[detached:"..name.."_armour;armour;1.80,1.85;1,1;4]"..
	"listring[detached:"..name.."_armour;armour]"..
	--"listring[detached:"..name.."_clothing;clothing]"..
	
	"image_button[-1.19,-0.2;0.9,0.9;armour_icon_fleshy.png;lottarmour_fleshy_protect;"..meta:get_string("lottarmour:fleshy")..";true;false;]"..
	"image_button[-1.19,0.6;0.9,0.9;armour_icon_pierce.png;lottarmour_pierce_protect;"..meta:get_string("lottarmour:pierce")..";true;false;]"..
	"image_button[-1.19,1.4;0.9,0.9;armour_icon_blunt.png;lottarmour_blunt_protect;"..meta:get_string("lottarmour:blunt")..";true;false;]"..
	"image_button[-1.19,2.2;0.9,0.9;armour_icon_stab.png;lottarmour_stab_protect;"..meta:get_string("lottarmour:stab")..";true;false;]"..
	
	"tooltip[lottarmour_fleshy_protect;"..meta:get_string("lottarmour:fleshy").."% Protection against Slash weapons]"..
	"tooltip[lottarmour_pierce_protect;"..meta:get_string("lottarmour:pierce").."% Protection against Pierce weapons]"..
	"tooltip[lottarmour_blunt_protect;"..meta:get_string("lottarmour:blunt").."% Protection against Blunt weapons]"..
	"tooltip[lottarmour_stab_protect;"..meta:get_string("lottarmour:stab").."% Protection against Stab weapons]"
end

