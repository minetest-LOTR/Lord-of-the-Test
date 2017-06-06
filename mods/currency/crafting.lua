minetest.register_craft({
    output = 'currency:safe',
    recipe = {
        {'', 'default:wood', ''},
        {'default:wood', 'default:steel_ingot', 'default:wood'},
        {'default:wood', 'default:wood', 'default:wood'},
    }
})

minetest.register_craft({
    output = 'currency:shop',
    recipe = {
        {'default:sign_wall'},
        {'default:chest_locked'},
    }
})

minetest.register_craft({
    output = 'currency:barter',
    recipe = {
        {'default:sign_wall'},
        {'default:chest'},
    }
})

minetest.register_craft({
    type = "shapeless",
    output = "currency:minegeld_5",
    recipe = {"currency:minegeld", "currency:minegeld", "currency:minegeld", "currency:minegeld", "currency:minegeld"},
})

minetest.register_craft({
    type = "shapeless",
    output = "currency:minegeld_10",
    recipe = {"currency:minegeld_5", "currency:minegeld_5"},
})

minetest.register_craft({
    type = "shapeless",
    output = "currency:minegeld_5 2",
    recipe = {"currency:minegeld_10"},
})

minetest.register_craft({
    type = "shapeless",
    output = "currency:minegeld 5",
    recipe = {"currency:minegeld_5"},
})
