--Thanks to catninja for this code and textures!
local function update_door(pos, node)
	minetest.set_node(pos, node)
end

local function punch(pos)
	local meta = minetest.get_meta(pos)
	local state = meta:get_int("state")
	local me = minetest.get_node(pos)
	local tmp_node
	local tmp_node2
	oben = {x=pos.x, y=pos.y+1, z=pos.z}
		if state == 1 then
			state = 0
			minetest.sound_play("door_close", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="lottblocks:hatch_alder", param1=me.param1, param2=me.param2}
		else
			state = 1
			minetest.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="lottblocks:hatch_alder_open", param1=me.param1, param2=me.param2}
		end
		update_door(pos, tmp_node)
		meta:set_int("state", state)
end

minetest.register_node("lottblocks:hatch_alder", {
	description = "Alder Hatch",
	drawtype = "nodebox",
	tiles = {"lottblocks_hatch_alderwood.png", "lottblocks_hatch_alderwood.png",  "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png", "lottblocks_hatch_side.png", "lottblocks_hatch_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2,flammable=2,door=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	on_creation = function(pos)
		state = 0
	end,
	on_rightclick = function(pos, node, clicker)
		punch(pos)
	end,
})

minetest.register_node("lottblocks:hatch_alder_open", {
	drawtype = "nodebox",
	tiles = {"lottblocks_hatch_side.png", "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png", "lottblocks_hatch_alderwood_open.png", "lottblocks_hatch_alderwood_open.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = true,
	stack_max = 0,
	groups = {choppy=2,flammable=2,door=1},
	climbable = true,
	sounds = default.node_sound_wood_defaults(),
	drop = "lottblocks:hatch_alder",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5}
	},
	on_rightclick = function(pos, node, clicker)
		punch(pos)
	end,
})

minetest.register_craft({
	output = 'lottblocks:hatch_alder',
	recipe = {
		{'lottplants:alderwood', 'lottplants:alderwood'},
		{'lottplants:alderwood', 'lottplants:alderwood'},
	}
})

local function punch(pos)
	local meta = minetest.get_meta(pos)
	local state = meta:get_int("state")
	local me = minetest.get_node(pos)
	local tmp_node
	local tmp_node2
	oben = {x=pos.x, y=pos.y+1, z=pos.z}
		if state == 1 then
			state = 0
			minetest.sound_play("door_close", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="lottblocks:hatch_birch", param1=me.param1, param2=me.param2}
		else
			state = 1
			minetest.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="lottblocks:hatch_birch_open", param1=me.param1, param2=me.param2}
		end
		update_door(pos, tmp_node)
		meta:set_int("state", state)
end

minetest.register_node("lottblocks:hatch_birch", {
	description = "Birch Hatch",
	drawtype = "nodebox",
	tiles = {"lottblocks_hatch_birchwood.png", "lottblocks_hatch_birchwood.png",  "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png", "lottblocks_hatch_side.png", "lottblocks_hatch_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=3,flammable=2,door=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	on_creation = function(pos)
		state = 0
	end,
	on_rightclick = function(pos, node, clicker)
		punch(pos)
	end,
})

minetest.register_node("lottblocks:hatch_birch_open", {
	drawtype = "nodebox",
	tiles = {"lottblocks_hatch_side.png", "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png", "lottblocks_hatch_birchwood_open.png", "lottblocks_hatch_birchwood_open.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = true,
	stack_max = 0,
	groups = {choppy=3,flammable=2,door=1},
	climbable = true,
	sounds = default.node_sound_wood_defaults(),
	drop = "lottblocks:hatch_birch",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5}
	},
	on_rightclick = function(pos, node, clicker)
		punch(pos)
	end,
})

minetest.register_craft({
	output = 'lottblocks:hatch_birch',
	recipe = {
		{'lottplants:birchwood', 'lottplants:birchwood'},
		{'lottplants:birchwood', 'lottplants:birchwood'},
	}
})

local function punch(pos)
	local meta = minetest.get_meta(pos)
	local state = meta:get_int("state")
	local me = minetest.get_node(pos)
	local tmp_node
	local tmp_node2
	oben = {x=pos.x, y=pos.y+1, z=pos.z}
		if state == 1 then
			state = 0
			minetest.sound_play("door_close", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="lottblocks:hatch_lebethron", param1=me.param1, param2=me.param2}
		else
			state = 1
			minetest.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="lottblocks:hatch_lebethron_open", param1=me.param1, param2=me.param2}
		end
		update_door(pos, tmp_node)
		meta:set_int("state", state)
end

minetest.register_node("lottblocks:hatch_lebethron", {
	description = "Lebethron Hatch",
	drawtype = "nodebox",
	tiles = {"lottblocks_hatch_lebethronwood.png", "lottblocks_hatch_lebethronwood.png",  "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png", "lottblocks_hatch_side.png", "lottblocks_hatch_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=1,flammable=2,door=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	on_creation = function(pos)
		state = 0
	end,
	on_rightclick = function(pos, node, clicker)
		punch(pos)
	end,
})

minetest.register_node("lottblocks:hatch_lebethron_open", {
	drawtype = "nodebox",
	tiles = {"lottblocks_hatch_side.png", "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png", "lottblocks_hatch_lebethronwood_open.png", "lottblocks_hatch_lebethronwood_open.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = true,
	stack_max = 0,
	groups = {choppy=1,flammable=2,door=1},
	climbable = true,
	sounds = default.node_sound_wood_defaults(),
	drop = "lottblocks:hatch_lebethron",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5}
	},
	on_rightclick = function(pos, node, clicker)
		punch(pos)
	end,
})

minetest.register_craft({
	output = 'lottblocks:hatch_lebethron',
	recipe = {
		{'lottplants:lebethronwood', 'lottplants:lebethronwood'},
		{'lottplants:lebethronwood', 'lottplants:lebethronwood'},
	}
})

local function punch(pos)
	local meta = minetest.get_meta(pos)
	local state = meta:get_int("state")
	local me = minetest.get_node(pos)
	local tmp_node
	local tmp_node2
	oben = {x=pos.x, y=pos.y+1, z=pos.z}
		if state == 1 then
			state = 0
			minetest.sound_play("door_close", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="lottblocks:hatch_mallorn", param1=me.param1, param2=me.param2}
		else
			state = 1
			minetest.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="lottblocks:hatch_mallorn_open", param1=me.param1, param2=me.param2}
		end
		update_door(pos, tmp_node)
		meta:set_int("state", state)
end

minetest.register_node("lottblocks:hatch_mallorn", {
	description = "Mallorn Hatch",
	drawtype = "nodebox",
	tiles = {"lottblocks_hatch_mallornwood.png", "lottblocks_hatch_mallornwood.png",  "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png", "lottblocks_hatch_side.png", "lottblocks_hatch_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=1,flammable=2,door=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	on_creation = function(pos)
		state = 0
	end,
	on_rightclick = function(pos, node, clicker)
		punch(pos)
	end,
})

minetest.register_node("lottblocks:hatch_mallorn_open", {
	drawtype = "nodebox",
	tiles = {"lottblocks_hatch_side.png", "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png",  "lottblocks_hatch_side.png", "lottblocks_hatch_mallornwood_open.png", "lottblocks_hatch_mallornwood_open.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = true,
	stack_max = 0,
	groups = {choppy=1,flammable=2,door=1},
	climbable = true,
	sounds = default.node_sound_wood_defaults(),
	drop = "lottblocks:hatch_mallorn",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5}
	},
	on_rightclick = function(pos, node, clicker)
		punch(pos)
	end,
})

minetest.register_craft({
	output = 'lottblocks:hatch_mallorn',
	recipe = {
		{'lottplants:mallornwood', 'lottplants:mallornwood'},
		{'lottplants:mallornwood', 'lottplants:mallornwood'},
	}
})
