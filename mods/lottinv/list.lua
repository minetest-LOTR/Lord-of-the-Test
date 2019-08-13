
minetest.after(0, function()
	lottinv.inv_list = function(player)
		return {
			{ lottinv.inv_survival..lottinv.nav_buttons, 	lottinv.inv_survival..lottinv.nav_buttons_force },
			{ lottarmour.inv_armour(player)..lottinv.nav_buttons,	lottarmour.inv_armour(player)..lottinv.nav_buttons_force },
			{ lottinv.inv_crafting..lottinv.nav_buttons, 	lottinv.inv_crafting..lottinv.nav_buttons_force },
		}
	end
	
	lottinv.inv_list_left = function(player)
		return {
			{ lottinv.inv_survival_left..lottinv.nav_buttons_left },
			{ lottarmour.inv_armour_left(player)..lottinv.nav_buttons_left },
			{ lottinv.inv_crafting_left..lottinv.nav_buttons_left },
		}
	end
end)