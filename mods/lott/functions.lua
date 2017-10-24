-- Replace _ with a space, and capitalize first letters.
-- i.e. converts "lord_of_the_test" to Lord Of The  Test

function lott.str_to_desc(str)
	return string.gsub(" " .. str:gsub("_", " "), "%W%l", string.upper):sub(2)
end
