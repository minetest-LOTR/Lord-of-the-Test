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
			tmp_node = {name="curwe:hatch_alder", param1=me.param1, param2=me.param2}
		else
			state = 1
			minetest.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="curwe:hatch_alder_open", param1=me.param1, param2=me.param2}
		end
		update_door(pos, tmp_node)
		meta:set_int("state", state)
end

minetest.register_node("curwe:hatch_alder", {
	description = "Alder Hatch",
	drawtype = "nodebox",
	tiles = {"curwe_hatch_alderwood.png", "curwe_hatch_alderwood.png",  "curwe_hatch_side.png",  "curwe_hatch_side.png", "curwe_hatch_side.png", "curwe_hatch_side.png"},
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

minetest.register_node("curwe:hatch_alder_open", {
	drawtype = "nodebox",
	tiles = {"curwe_hatch_side.png", "curwe_hatch_side.png",  "curwe_hatch_side.png",  "curwe_hatch_side.png", "curwe_hatch_alderwood_open.png", "curwe_hatch_alderwood_open.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = true,
	stack_max = 0,
	groups = {choppy=2,flammable=2,door=1},
	climbable = true,
	sounds = default.node_sound_wood_defaults(),
	drop = "curwe:hatch_alder",
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
	output = 'curwe:hatch_alder',
	recipe = {
		{'olvar:alderwood', 'olvar:alderwood'},
		{'olvar:alderwood', 'olvar:alderwood'},
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
			tmp_node = {name="curwe:hatch_birch", param1=me.param1, param2=me.param2}
		else
			state = 1
			minetest.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="curwe:hatch_birch_open", param1=me.param1, param2=me.param2}
		end
		update_door(pos, tmp_node)
		meta:set_int("state", state)
end

minetest.register_node("curwe:hatch_birch", {
	description = "Birch Hatch",
	drawtype = "nodebox",
	tiles = {"curwe_hatch_birchwood.png", "curwe_hatch_birchwood.png",  "curwe_hatch_side.png",  "curwe_hatch_side.png", "curwe_hatch_side.png", "curwe_hatch_side.png"},
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

minetest.register_node("curwe:hatch_birch_open", {
	drawtype = "nodebox",
	tiles = {"curwe_hatch_side.png", "curwe_hatch_side.png",  "curwe_hatch_side.png",  "curwe_hatch_side.png", "curwe_hatch_birchwood_open.png", "curwe_hatch_birchwood_open.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = true,
	stack_max = 0,
	groups = {choppy=3,flammable=2,door=1},
	climbable = true,
	sounds = default.node_sound_wood_defaults(),
	drop = "curwe:hatch_birch",
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
	output = 'curwe:hatch_birch',
	recipe = {
		{'olvar:birchwood', 'olvar:birchwood'},
		{'olvar:birchwood', 'olvar:birchwood'},
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
			tmp_node = {name="curwe:hatch_lebethron", param1=me.param1, param2=me.param2}
		else
			state = 1
			minetest.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="curwe:hatch_lebethron_open", param1=me.param1, param2=me.param2}
		end
		update_door(pos, tmp_node)
		meta:set_int("state", state)
end

minetest.register_node("curwe:hatch_lebethron", {
	description = "Lebethron Hatch",
	drawtype = "nodebox",
	tiles = {"curwe_hatch_lebethronwood.png", "curwe_hatch_lebethronwood.png",  "curwe_hatch_side.png",  "curwe_hatch_side.png", "curwe_hatch_side.png", "curwe_hatch_side.png"},
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

minetest.register_node("curwe:hatch_lebethron_open", {
	drawtype = "nodebox",
	tiles = {"curwe_hatch_side.png", "curwe_hatch_side.png",  "curwe_hatch_side.png",  "curwe_hatch_side.png", "curwe_hatch_lebethronwood_open.png", "curwe_hatch_lebethronwood_open.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = true,
	stack_max = 0,
	groups = {choppy=1,flammable=2,door=1},
	climbable = true,
	sounds = default.node_sound_wood_defaults(),
	drop = "curwe:hatch_lebethron",
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
	output = 'curwe:hatch_lebethron',
	recipe = {
		{'olvar:lebethronwood', 'olvar:lebethronwood'},
		{'olvar:lebethronwood', 'olvar:lebethronwood'},
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
			tmp_node = {name="curwe:hatch_mallorn", param1=me.param1, param2=me.param2}
		else
			state = 1
			minetest.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="curwe:hatch_mallorn_open", param1=me.param1, param2=me.param2}
		end
		update_door(pos, tmp_node)
		meta:set_int("state", state)
end

minetest.register_node("curwe:hatch_mallorn", {
	description = "Mallorn Hatch",
	drawtype = "nodebox",
	tiles = {"curwe_hatch_mallornwood.png", "curwe_hatch_mallornwood.png",  "curwe_hatch_side.png",  "curwe_hatch_side.png", "curwe_hatch_side.png", "curwe_hatch_side.png"},
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

minetest.register_node("curwe:hatch_mallorn_open", {
	drawtype = "nodebox",
	tiles = {"curwe_hatch_side.png", "curwe_hatch_side.png",  "curwe_hatch_side.png",  "curwe_hatch_side.png", "curwe_hatch_mallornwood_open.png", "curwe_hatch_mallornwood_open.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = true,
	stack_max = 0,
	groups = {choppy=1,flammable=2,door=1},
	climbable = true,
	sounds = default.node_sound_wood_defaults(),
	drop = "curwe:hatch_mallorn",
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
	output = 'curwe:hatch_mallorn',
	recipe = {
		{'olvar:mallornwood', 'olvar:mallornwood'},
		{'olvar:mallornwood', 'olvar:mallornwood'},
	}
})
