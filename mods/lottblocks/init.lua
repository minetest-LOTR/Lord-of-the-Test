lottblocks = {}
lottblocks.beds.player = {}
lottblocks.beds.pos = {}

lottblocks.beds.formspec = "size[8,15;true]" ..
	"bgcolor[#080808BB; true]" ..
  "button_exit[2,12;4,0.75;leave;Leave Bed]"

local path = minetest.get_modpath("lottblocks")

dofile(path.."/wooden_stuff.lua") --This has trapdoors, doors, tables and chairs in all the kinds of wood.
dofile(path.."/misc.lua")
dofile(path.."/beds.lua") --This has beds.
dofile(path.."/music.lua") --This has musical insturments, and the music they play.
dofile(path.."/decoration.lua") --This has various decoration nodes, by catninja.
dofile(path.."/chests.lua")
dofile(path.."/lamps.lua")
dofile(path.."/banners.lua")
dofile(path.."/doors.lua")
dofile(path.."/palantiri.lua")
dofile(path.."/crafting.lua")
dofile(path.."/guides.lua")
