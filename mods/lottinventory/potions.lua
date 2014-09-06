ARMOR_INIT_DELAY = 1
ARMOR_INIT_TIMES = 1
ARMOR_BONES_DELAY = 1
ARMOR_UPDATE_TIME = 1
ARMOR_DROP = false
ARMOR_DESTROY = false
ARMOR_LEVEL_MULTIPLIER = 1
ARMOR_HEAL_MULTIPLIER = 1

local time = 0

local get_formspec = function(player,page)
	if page=="potions" then
		return "size[8,5.5]"
               .."background[5,5;1,1;gui_formbg.png;true]"
               .."label[0,0;Book of Potions]"
               .."button_exit[6,0;2,0.5;quit;Exit]"
               .."image_button[7,1;1,1;zcg_next.png;potions2;;false;false;zcg_next_press.png]"
               .."image[6,1;1,1;zcg_previous_inactive.png]"
               .."label[0,0.5;Base Potions:]"
               --First potion
               .."label[1,2.2; Mese Base Potion]"
               .."item_image_button[4,2;1,1;vessels:glass_bottle;zcg:vessels:glass_bottle;]"
               .."item_image_button[5,2;1,1;default:mese_crystal_fragment;zcg:mese_crystal_fragment;]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:glass_bottle_mese;zcg:glass_bottle_mese;]"
               --Second 
               .."label[1,3.2; Geodes Base Potion]"
               .."item_image_button[4,3;1,1;vessels:glass_bottle;zcg:glass_bottle;]"
               .."item_image_button[5,3;1,1;lottores:geodes_crystal_1;zcg:geodes_crystal_1;]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:glass_bottle_geodes;zcg:glass_bottle_geodes;]"
               --Third
               .."label[1,4.2; Seregon Base Potion]"
               .."item_image_button[4,4;1,1;vessels:glass_bottle;zcg:glass_bottle;]"
               .."item_image_button[5,4;1,1;lottplants:seregon;zcg:seregon;]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:glass_bottle_seregon;zcg:glass_bottle_seregon;]"
	end
     if page=="potions2" then
		return "size[8,5.5]"
               .."label[0,0;Book of Potions]"
               .."button_exit[6,0;2,0.5;quit;Exit]"
               .."image_button[7,1;1,1;zcg_next.png;potions3;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions;;false;false;zcg_previous_press.png]"
               .."label[0,0.5;Orc Draught (Hurting Potion)]"
               --First potion
               .."label[1,2.2; Power Level: 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_seregon;zcg:glass_bottle_seregon;]"
               .."item_image_button[5,2;1,1;lottmobs:meat_raw;zcg:meat_raw;5]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:orcdraught_power1;zcg:orcdraught_power1;]"
               --Second 
               .."label[1,3.2; Power Level: 2]"
               .."item_image_button[4,3;1,1;lottpotion:orcdraught_power1;zcg:orcdraught_power1;]"
               .."item_image_button[5,3;1,1;lottmobs:meat_raw;zcg:meat_raw;5]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:orcdraught_power2;zcg:orcdraught_power2;]"
               --Third
               .."label[1,4.2; Power Level: 3]"
               .."item_image_button[4,4;1,1;lottpotion:orcdraught_power2;zcg:orcdraught_power2;]"
               .."item_image_button[5,4;1,1;lottmobs:meat_raw;zcg:meat_raw;5]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:orcdraught_power3;zcg:orcdraught_power3;]"
               .."background[5,5;1,1;gui_formbg.png;true]"
     end
     if page=="potions3" then
		return "size[8,5.5]"
               .."label[0,0;Book of Potions]"
               .."button_exit[6,0;2,0.5;quit;Exit]"
               .."image_button[7,1;1,1;zcg_next.png;potions4;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions2;;false;false;zcg_previous_press.png]"
               .."label[0,0.5;Spider Poison (Speed Weakening Potion)]"
               --First potion
               .."label[1,2.2; Power Level: 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_seregon;zcg:glass_bottle_seregon;]"
               .."item_image_button[5,2;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:spiderpoison_power1;zcg:spiderpoison_power1;]"
               --Second 
               .."label[1,3.2; Power Level: 2]"
               .."item_image_button[4,3;1,1;lottpotion:spiderpoison_power1;zcg:spiderpoison_power1;]"
               .."item_image_button[5,3;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:spiderpoison_power2;zcg:spiderpoison_power2;]"
               --Third
               .."label[1,4.2; Power Level: 3]"
               .."item_image_button[4,4;1,1;lottpotion:spiderpoison_power2;zcg:spiderpoison_power2;]"
               .."item_image_button[5,4;1,1;lottmobs:spiderpoison;zcg:lottmobs:spiderpoison;2]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:spiderpoison_power2;zcg:spiderpoison_power3;]"
               .."background[5,5;1,1;gui_formbg.png;true]"
	end
     if page=="potions4" then
		return "size[8,5.5]"
               .."label[0,0;Book of Potions]"
               .."button_exit[6,0;2,0.5;quit;Exit]"
               .."image_button[7,1;1,1;zcg_next.png;potions5;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions3;;false;false;zcg_previous_press.png]"
               .."label[0,0.5;Limpe (Breathing Underwater Potion)]"
               --First potion
               .."label[1,2.2; Power Level: 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_mese;zcg:glass_bottle_mese;]"
               .."item_image_button[5,2;1,1;lottplants:yavannamireleaf;zcg:yavannamireleaf;10]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:limpe_power1;zcg:limpe_power1;]"
               --Second 
               .."label[1,3.2; Power Level: 2]"
               .."item_image_button[4,3;1,1;lottpotion:limpe_power1;zcg:limpe_power1;]"
               .."item_image_button[5,3;1,1;lottplants:yavannamireleaf;zcg:yavannamireleaf;10]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:limpe_power2;zcg:limpe_power2;]"
               --Third
               .."label[1,4.2; Power Level: 3]"
               .."item_image_button[4,4;1,1;lottpotion:limpe_power2;zcg:limpe_power2;]"
               .."item_image_button[5,4;1,1;lottplants:yavannamireleaf;zcg:yavannamireleaf;10]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:limpe_power3;zcg:limpe_power3;]"
               .."background[5,5;1,1;gui_formbg.png;true]"
	end
     if page=="potions5" then
		return "size[8,5.5]"
               .."label[0,0;Book of Potions]"
               .."button_exit[6,0;2,0.5;quit;Exit]"
               .."image_button[7,1;1,1;zcg_next.png;potions6;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions4;;false;false;zcg_previous_press.png]"
               .."label[0,0.5;Miruvor (Speed Boost Potion)]"
               --First potion
               .."label[1,2.2; Power Level: 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_mese;zcg:glass_bottle_mese;]"
               .."item_image_button[5,2;1,1;lottplants:yavannamirefruit;zcg:yavannamirefruit;2]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:miruvor_power1;zcg:miruvor_power1;]"
               --Second 
               .."label[1,3.2; Power Level: 2]"
               .."item_image_button[4,3;1,1;lottpotion:miruvor_power1;zcg:miruvor_power1;]"
               .."item_image_button[5,3;1,1;lottplants:yavannamirefruit;zcg:yavannamirefruit;2]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:miruvor_power2;zcg:miruvor_power2;]"
               --Third
               .."label[1,4.2; Power Level: 3]"
               .."item_image_button[4,4;1,1;lottpotion:miruvor_power2;zcg:miruvor_power2;]"
               .."item_image_button[5,4;1,1;lottplants:yavannamirefruit;zcg:yavannamirefruit;2]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:miruvor_power3;zcg:miruvor_power3;]"
               .."background[5,5;1,1;gui_formbg.png;true]"
	end
     if page=="potions6" then
		return "size[8,5.5]"
               .."label[0,0;Book of Potions]"
               .."button_exit[6,0;2,0.5;quit;Exit]"
               .."image_button[7,1;1,1;zcg_next.png;potions7;;false;false;zcg_next_press.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions5;;false;false;zcg_previous_press.png]"
               .."label[0,0.5;Athelas Brew (Healing Potion)]"
               --First potion
               .."label[1,2.2; Power Level: 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_geodes;zcg:glass_bottle_geodes;]"
               .."item_image_button[5,2;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:athelasbrew_power1;zcg:athelasbrew_power1;]"
               --Second 
               .."label[1,3.2; Power Level: 2]"
               .."item_image_button[4,3;1,1;lottpotion:athelasbrew_power1;zcg:athelasbrew_power1;]"
               .."item_image_button[5,3;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:athelasbrew_power2;zcg:athelasbrew_power2;]"
               --Third
               .."label[1,4.2; Power Level: 3]"
               .."item_image_button[4,4;1,1;lottpotion:athelasbrew_power2;zcg:athelasbrew_power2;]"
               .."item_image_button[5,4;1,1;lottfarming:athelas;zcg:athelas;3]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:athelasbrew_power3;zcg:athelasbrew_power3;]"
               .."background[5,5;1,1;gui_formbg.png;true]"
	end
     if page=="potions7" then
		return "size[8,5.5]"
               .."label[0,0;Book of Potions]"
               .."button_exit[6,0;2,0.5;quit;Exit]"
               .."image[7,1;1,1;zcg_next_inactive.png]"
               .."image_button[6,1;1,1;zcg_previous.png;potions6;;false;false;zcg_previous_press.png]"
               .."label[0,0.5;Ent Draught (Healing & Jump Weakening Potion)]"
               --First potion
               .."label[1,2.2; Power Level: 1]"
               .."item_image_button[4,2;1,1;lottpotion:glass_bottle_geodes;zcg:glass_bottle_geodes;]"
               .."item_image_button[5,2;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,2;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,2;1,1;lottpotion:entdraught_power1;zcg:entdraught_power1;]"
               --Second 
               .."label[1,3.2; Power Level: 2]"
               .."item_image_button[4,3;1,1;lottpotion:entdraught_power1;zcg:entdraught_power1;]"
               .."item_image_button[5,3;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,3;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,3;1,1;lottpotion:entdraught_power2;zcg:entdraught_power2;]"
               --Third
               .."label[1,4.2; Power Level: 3]"
               .."item_image_button[4,4;1,1;lottpotion:entdraught_power2;zcg:entdraught_power2;]"
               .."item_image_button[5,4;1,1;default:leaves;zcg:leaves;10]"
               .."image[6,4;1,1;zcg_craft_arrow.png]"
               .."item_image_button[7,4;1,1;lottpotion:entdraught_power3;zcg:entdraught_power3;]"
               .."background[5,5;1,1;gui_formbg.png;true]"
	end
end

minetest.register_on_player_receive_fields(function(player,formname,fields)
	if fields.potions then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions"))
	end
     if fields.potions2 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions2"))
	end
     if fields.potions3 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions3"))
	end
     if fields.potions4 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions4"))
	end
     if fields.potions5 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions5"))
	end
     if fields.potions6 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions6"))
	end
     if fields.potions7 then
	     inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions7"))
	end
end)

minetest.register_tool("lottinventory:potions_book",{
    description = "Book of Potions",
    groups = {}, 
    inventory_image = "lottinventory_potion_book.png",
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    stack_max = 1, 
    groups = {cook_crafts=1},
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=0,
        groupcaps={
            fleshy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
            snappy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
            choppy={times={[3]=0.90}, maxwear=0.05, maxlevel=0}
        }
    },
    on_place = function(itemstack, player, pointed_thing)
       inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions"))
       return itemstack; -- nothing consumed, nothing changed
    end,
    on_use = function(itemstack, player, pointed_thing)
          inventory_plus.set_inventory_formspec(player, get_formspec(player,"potions"))
          return itemstack; -- nothing consumed, nothing changed
    end,
})