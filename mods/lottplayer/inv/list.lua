
minetest.after(0, function()
	lottplayer.inv_list = {
		{ lottplayer.inv_survival..lottplayer.nav_buttons, 	lottplayer.inv_survival..lottplayer.nav_buttons_force },
		{ lottplayer.inv_armour..lottplayer.nav_buttons,	lottplayer.inv_armour..lottplayer.nav_buttons_force },
		{ lottplayer.inv_crafting..lottplayer.nav_buttons, 	lottplayer.inv_crafting..lottplayer.nav_buttons_force },
	}
	
	lottplayer.inv_list_left = {
		{ lottplayer.inv_survival_left..lottplayer.nav_buttons_left },
		{ lottplayer.inv_armour_left..lottplayer.nav_buttons_left },
		{ lottplayer.inv_crafting_left..lottplayer.nav_buttons_left },
	}
end)