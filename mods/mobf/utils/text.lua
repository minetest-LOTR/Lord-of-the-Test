-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file text.lua
--! @brief generic functions used in many different places
--! @copyright Sapier
--! @author Sapier
--! @date 2013-02-04
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @defgroup gen_func Generic functions
--! @brief functions for various tasks
--! @ingroup framework_int
--! @{

-------------------------------------------------------------------------------
-- name: printpos(pos)
--
--! @brief convert pos to string of type "(X,Y,Z)"
--
--! @param pos position to convert
--! @return string with coordinates of pos
-------------------------------------------------------------------------------
function printpos(pos)
	if pos ~= nil then
		if pos.y ~= nil then
			mobf_assert_backtrace(type(pos.x) == "number")
			mobf_assert_backtrace(type(pos.z) == "number")
			mobf_assert_backtrace(type(pos.y) == "number")
			return "("..string.format("%3f",pos.x)..","
						..string.format("%3f",pos.y)..","
						..string.format("%3f",pos.z)..")"
		else
			mobf_assert_backtrace(type(pos.x) == "number")
			mobf_assert_backtrace(type(pos.z) == "number")
			return "("..string.format("%3f",pos.x)..", ? ,"
						..string.format("%3f",pos.z)..")"
		end
	end
	return ""
end

-------------------------------------------------------------------------------
-- name: mobf_print(text)
--
--! @brief print adding timestamp in front of text
--
--! @param text to show
-------------------------------------------------------------------------------
function mobf_print(text)
	print("[" .. string.format("%10f",os.clock()) .. "]" .. text)
end

-------------------------------------------------------------------------------
-- name: mobf_fixed_size_string(text,length)
--
--! @brief make a text fixed length
--
--! @param text text to enforce lenght
--! @param length lenght to enforce
--!
--! @return text with exactly lenght characters
-------------------------------------------------------------------------------
function mobf_fixed_size_string(text,length)
	mobf_assert_backtrace(length ~= nil)
	
	if text == nil then
		text="nil"
	end
	
	local current_length = string.len(text)
	
	if current_length == nil then 
		current_length = 0
		text = ""
	end
	
	if current_length < length then
		
		while current_length < length do
			text = text .. " "
			current_length = current_length +1
		end
		
		return text
	else
		return string.sub(text,1,length)
	end
end
--!@}