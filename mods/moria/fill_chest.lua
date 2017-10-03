geomoria.random_chest_content = {};

local ADD_RCC = function( data )
	if( data and #data>3 and ( minetest.registered_nodes[ data[1] ] or minetest.registered_items[ data[1] ]) ) then
		data.chest_default = 1;
		table.insert( geomoria.random_chest_content, data );
	end
end

ADD_RCC({"default:pick_mese",		30,  1,  2})
ADD_RCC({"geomoria:gold_pile",		100, 16, 1})
ADD_RCC({"default:pick_stone",		80,  2,  1})
ADD_RCC({"default:shovel_steel",	20,  2,  1})      
ADD_RCC({"default:shovel_stone",	50,  1,  1})
