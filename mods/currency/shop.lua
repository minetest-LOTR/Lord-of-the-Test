default.shop = {}
default.shop.current_shop = {}
default.shop.formspec = {
    customer = function(pos)
        local list_name = "nodemeta:"..pos.x..','..pos.y..','..pos.z
        local formspec = "size[8,9.5]"..
        "label[0,0;Customer gives (pay here !)]"..
        "list[current_player;customer_gives;0,0.5;3,2;]"..
        "label[0,2.5;Customer gets]"..
        "list[current_player;customer_gets;0,3;3,2;]"..
        "label[5,0;Owner wants]"..
        "list["..list_name..";owner_wants;5,0.5;3,2;]"..
        "label[5,2.5;Owner gives]"..
        "list["..list_name..";owner_gives;5,3;3,2;]"..
        "list[current_player;main;0,5.5;8,4;]"..
        "button[3,2;2,1;exchange;Exchange]"
        return formspec
    end,
    owner = function(pos)
        local list_name = "nodemeta:"..pos.x..','..pos.y..','..pos.z
        local formspec = "size[8,9.5]"..
        "label[0,0;Customers gave:]"..
        "list["..list_name..";customers_gave;0,0.5;3,2;]"..
        "label[0,2.5;Your stock:]"..
        "list["..list_name..";stock;0,3;3,2;]"..
        "label[5,0;You want:]"..
        "list["..list_name..";owner_wants;5,0.5;3,2;]"..
        "label[5,2.5;In exchange, you give:]"..
        "list["..list_name..";owner_gives;5,3;3,2;]"..
        "label[0,5;Owner, Use(E)+Place(RMB) for customer interface]"..
        "list[current_player;main;0,5.5;8,4;]"
        return formspec
    end,
}

default.shop.check_privilege = function(listname,playername,meta)
    --[[if listname == "pl1" then
        if playername ~= meta:get_string("pl1") then
            return false
        elseif meta:get_int("pl1step") ~= 1 then
            return false
        end
    end
    if listname == "pl2" then
        if playername ~= meta:get_string("pl2") then
            return false
        elseif meta:get_int("pl2step") ~= 1 then
            return false
        end
    end]]
    return true
end


default.shop.give_inventory = function(inv,list,playername)
    player = minetest.env:get_player_by_name(playername)
    if player then
        for k,v in ipairs(inv:get_list(list)) do
            player:get_inventory():add_item("main",v)
            inv:remove_item(list,v)
        end
    end
end

default.shop.cancel = function(meta)
    --[[default.shop.give_inventory(meta:get_inventory(),"pl1",meta:get_string("pl1"))
    default.shop.give_inventory(meta:get_inventory(),"pl2",meta:get_string("pl2"))
    meta:set_string("pl1","")
    meta:set_string("pl2","")
    meta:set_int("pl1step",0)
    meta:set_int("pl2step",0)]]
end

default.shop.exchange = function(meta)
    --[[default.shop.give_inventory(meta:get_inventory(),"pl1",meta:get_string("pl2"))
    default.shop.give_inventory(meta:get_inventory(),"pl2",meta:get_string("pl1"))
    meta:set_string("pl1","")
    meta:set_string("pl2","")
    meta:set_int("pl1step",0)
    meta:set_int("pl2step",0)]]
end

minetest.register_node("currency:shop", {
    description = "Shop",
    paramtype2 = "facedir",
    tiles = {"shop_top.png",
                    "shop_top.png",
            "shop_side.png",
            "shop_side.png",
            "shop_side.png",
            "shop_front.png"},
    inventory_image = "shop_front.png",
    groups = {choppy=2,oddly_breakable_by_hand=2},
    sounds = default.node_sound_wood_defaults(),
    after_place_node = function(pos, placer, itemstack)
        local owner = placer:get_player_name()
        local meta = minetest.env:get_meta(pos)
        meta:set_string("infotext", "Exchange shop (owned by "..owner..")")
        meta:set_string("owner",owner)
        --[[meta:set_string("pl1","")
        meta:set_string("pl2","")]]
        local inv = meta:get_inventory()
        inv:set_size("customers_gave", 3*2)
        inv:set_size("stock", 3*2)
        inv:set_size("owner_wants", 3*2)
        inv:set_size("owner_gives", 3*2)
    end,
    on_rightclick = function(pos, node, clicker, itemstack)
        clicker:get_inventory():set_size("customer_gives", 3*2)
        clicker:get_inventory():set_size("customer_gets", 3*2)
        default.shop.current_shop[clicker:get_player_name()] = pos
        local meta = minetest.env:get_meta(pos)
        if clicker:get_player_name() == meta:get_string("owner") and not clicker:get_player_control().aux1 then
            minetest.show_formspec(clicker:get_player_name(),"currency:shop_formspec",default.shop.formspec.owner(pos))
        else
            minetest.show_formspec(clicker:get_player_name(),"currency:shop_formspec",default.shop.formspec.customer(pos))
        end
    end,
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        local meta = minetest.env:get_meta(pos)
        if player:get_player_name() ~= meta:get_string("owner") then return 0 end
        return count
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        local meta = minetest.env:get_meta(pos)
        if player:get_player_name() ~= meta:get_string("owner") then return 0 end
        return stack:get_count()
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        local meta = minetest.env:get_meta(pos)
        if player:get_player_name() ~= meta:get_string("owner") then return 0 end
        return stack:get_count()
    end,
    can_dig = function(pos, player)
        local meta = minetest.env:get_meta(pos)
        local inv = meta:get_inventory()
        return inv:is_empty("stock") and inv:is_empty("customers_gave") and inv:is_empty("owner_wants") and inv:is_empty("owner_gives")
    end
})

minetest.register_on_player_receive_fields(function(sender, formname, fields)
    if formname == "currency:shop_formspec" and fields.exchange ~= nil and fields.exchange ~= "" then
        local name = sender:get_player_name()
        local pos = default.shop.current_shop[name]
        local meta = minetest.env:get_meta(pos)
        if meta:get_string("owner") == name then
            minetest.chat_send_player(name,"This is your own shop, you can't exchange to yourself !")
        else
            local minv = meta:get_inventory()
            local pinv = sender:get_inventory()
            local invlist_tostring = function(invlist)
                local out = {}
                for i, item in pairs(invlist) do
                    out[i] = item:to_string()
                end
                return out
            end
            local wants = minv:get_list("owner_wants")
            local gives = minv:get_list("owner_gives")
            if wants == nil or gives == nil then return end -- do not crash the server
            -- Check if we can exchange
            local can_exchange = true
            local owners_fault = false
            for i, item in pairs(wants) do
                if not pinv:contains_item("customer_gives",item) then
                    can_exchange = false
                end
                if not minv:room_for_item("customers_gave", item) then
                        can_exchange = false
                        owners_fault = true
                end
            end
            for i, item in pairs(gives) do
                if not minv:contains_item("stock",item) then
                    can_exchange = false
                    owners_fault = true
                end
            end
            if can_exchange then
                for i, item in pairs(wants) do
                    pinv:remove_item("customer_gives",item)
                    minv:add_item("customers_gave",item)
                end
                for i, item in pairs(gives) do
                    minv:remove_item("stock",item)
                    pinv:add_item("customer_gets",item)
                end
                minetest.chat_send_player(name,"Exchanged!")
            else
                if owners_fault then
                    minetest.chat_send_player(name,"Exchange can not be done, contact the shop owner.")
                else
                    minetest.chat_send_player(name,"Exchange can not be done, check if you put all items !")
                end
            end
        end
    end
end)
