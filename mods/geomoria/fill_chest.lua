 
local ADD_RCC = function( data )
        if( data and #data>3 and ( minetest.registered_nodes[ data[1] ] or minetest.registered_items[ data[1] ]) ) then
                table.insert( geomoria.random_chest_content, data )
        end
end

geomoria.random_chest_content = {}

ADD_RCC({"geomoria:gold_pile", 1, 99, 1})
ADD_RCC({"default:pick_steel", 1, 2, 1})
