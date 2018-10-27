-- Replace _ with a space, and capitalize first letters.
-- i.e. converts "lord_of_the_test" to Lord Of The Test

function lott.str_to_desc(str)
	return string.gsub(" " .. str:gsub("_", " "), "%W%l", string.upper):sub(2)
end

function lott.swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    minetest.rotate_node(itemstack, placer, pointed_thing)
end)