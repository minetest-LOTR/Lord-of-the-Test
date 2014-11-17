dofile(minetest.get_modpath("olvar").."/trees/nodes.lua")
-- TREE FUNCTIONS

-- Alders

function olvar_aldertree(pos)
	local t = 6 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:alderleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="olvar:aldertree"})
	end
end

-- Apple tree

function olvar_appletree(pos)
	local t = 4 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:appleleaf"})
				end
				if math.random() > (absi + absk) / 12 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="default:apple"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- Birches

function olvar_birchtree(pos)
	local t = 7 + math.random(5) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:birchleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="olvar:birchtree"})
	end
end

-- Beeches

function olvar_beechtree(pos)
	local t = 10 + math.random(3) -- trunk height
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if absi >= absk then
			j = t - absi
		else
			j = t - absk
		end
		if math.random() > (absi + absk) / 24 then
		    minetest.add_node({x=pos.x+i,y=pos.y+j+7,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k},{name="olvar:beechleaf"})
		    minetest.add_node({x=pos.x+i+2,y=pos.y+j+4,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i-2,y=pos.y+j+4,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k+2},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k-2},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i+3,y=pos.y+j+1,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i-3,y=pos.y+j+1,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k+3},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k-3},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i+3,y=pos.y+j-2,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i-3,y=pos.y+j-2,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+3},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k-3},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i+4,y=pos.y+j-5,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i-4,y=pos.y+j-5,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k+4},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k-4},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i+4,y=pos.y+j-8,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i-4,y=pos.y+j-8,z=pos.z+k},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k+4},{name="olvar:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k-4},{name="olvar:beechleaf"})
		end
	end
	end
	for j = -3, t do
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- Culumalda

function olvar_culumaldatree(pos)
	local t = 4 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:culumaldaleaf"})
				end
				if math.random() > (absi + absk) / 12 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:yellowflowers"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- Elms

function olvar_elmtree(pos)
	local t = 20 + math.random(5) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:elmleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- Firs

function olvar_firtree(pos)
	local t = 10 + math.random(3) -- trunk height
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if absi >= absk then
			j = t - absi
		else
			j = t - absk
		end
		if math.random() > (absi + absk) / 24 then
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="olvar:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},{name="olvar:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="olvar:firleaf"})
		end
	end
	end
	for j = -3, t do
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- Lebethron

function olvar_lebethrontree(pos)
	local t = 3 + math.random(1) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:lebethronleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="olvar:lebethrontree"})
	end
end

-- Mallorn

function add_tree_branch_mallorn(pos)
	minetest.env:add_node(pos, {name="olvar:mallorntree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="olvar:mallornleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="olvar:mallornleaf"})
				end
			end
		end
	end
end

function olvar_mallorntree(pos)
    local height = 25 + math.random(5)
		if height < 10 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="olvar:mallorntree"})
				if i == height then
					add_tree_branch_mallorn({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="olvar:mallorntree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="olvar:mallorntree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="olvar:mallorntree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="olvar:mallorntree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mallorn(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mallorn(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="olvar:mallorntree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="olvar:mallorntree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="olvar:mallorntree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="olvar:mallorntree"})
				end
				if i == height then
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_mallorn({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_mallorn({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_mallorn({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_mallorn({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i, z=pos.z})
				else
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="olvar:mallorntree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="olvar:mallorntree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="olvar:mallorntree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="olvar:mallorntree"})
				end
			end
		end
end

-- Oaks

function olvar_oaktree(pos)
	local t = 10 + math.random(3) -- trunk height
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if absi >= absk then
			j = t - absi
		else
			j = t - absk
		end
		if math.random() > (absi + absk) / 24 then
			minetest.add_node({x=pos.x+i,y=pos.y+j+3,z=pos.z+k},{name="olvar:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="olvar:firleaf"})
			minetest.add_node({x=pos.x+i+1,y=pos.y+j-1,z=pos.z+k},{name="olvar:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+1},{name="olvar:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-3,z=pos.z+k},{name="olvar:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-4,z=pos.z+k},{name="olvar:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="olvar:firleaf"})
		end
	end
	end
	for j = -5, t do
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- Pines

function olvar_pinetree(pos)
	local t = 10 + math.random(3) -- trunk height
	for i = -2, 2 do
	for k = -2, 2 do
		local absi = math.abs(i)
		local absk = math.abs(k)
		if absi >= absk then
			j = t - absi
		else
			j = t - absk
		end
		if math.random() > (absi + absk) / 24 then
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i+1,y=pos.y+j-2,z=pos.z+k},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i-1,y=pos.y+j-2,z=pos.z+k},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+1},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k-1},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i+1,y=pos.y+j-5,z=pos.z+k},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i-1,y=pos.y+j-5,z=pos.z+k},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k+1},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k-1},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i+2,y=pos.y+j-8,z=pos.z+k},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i-2,y=pos.y+j-8,z=pos.z+k},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k+2},{name="olvar:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k-2},{name="olvar:pineleaf"})
		end
	end
	end
	for j = -3, t do
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- Plum Trees

function olvar_plumtree(pos)
	local t = 4 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:plumleaf"})
				end
				if math.random() > (absi + absk) / 12 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:plum"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end


-- Rowans

function olvar_rowantree(pos)
	local t = 4 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 12 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:rowanleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- White Tree

function olvar_whitetree(pos)
	local t = 4 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:whiteleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- Yavannamire

function olvar_yavannamiretree(pos)
	local t = 4 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:yavannamireleaf"})
				end
				if math.random() > (absi + absk) / 12 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="olvar:yavannamirefruit"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- SAPLINGS

-- Alders sapling

minetest.register_abm({
    nodenames = {"olvar:aldersapling"},
    interval = ALDINT,
    chance = ALDCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_aldertree(pos)
		print ("[olvar] Alder Grows")
    end,
})

-- Apple Tree sapling

minetest.register_abm({
    nodenames = {"olvar:applesapling"},
    interval = APPINT,
    chance = APPCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_appletree(pos)
		print ("[olvar] Apple Tree Grows")
    end,
})

-- Birch sapling

minetest.register_abm({
    nodenames = {"olvar:birchsapling"},
    interval = BIRINT,
    chance = BIRCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_birchtree(pos)
		print ("[olvar] Birch Grows")
    end,
})

-- Beech sapling

minetest.register_abm({
    nodenames = {"olvar:beechsapling"},
    interval = BEEINT,
    chance = BEECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_beechtree(pos)
		print ("[olvar] Beech Grows")
    end,
})

-- Culumalda sapling

minetest.register_abm({
    nodenames = {"olvar:culumaldasapling"},
    interval = CULINT,
    chance = CULCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_culumaldatree(pos)
		print ("[olvar] Culumalda Grows")
    end,
})

-- Elm sapling

minetest.register_abm({
    nodenames = {"olvar:elmsapling"},
    interval = ELMINT,
    chance = ELMCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_elmtree(pos)
		print ("[olvar] Elm Grows")
    end,
})

-- Fir sapling

minetest.register_abm({
    nodenames = {"olvar:firsapling"},
    interval = FIRINT,
    chance = FIRCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_firtree(pos)
		print ("[olvar] Fir Grows")
    end,
})

-- Lebethron sapling

minetest.register_abm({
    nodenames = {"olvar:lebethronsapling"},
    interval = LEBINT,
    chance = LEBCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_lebethrontree(pos)
		print ("[olvar] Lebethron Grows")
    end,
})

-- Mallorn sapling

minetest.register_abm({
    nodenames = {"olvar:mallornsapling"},
    interval = MALINT,
    chance = MALCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_mallorntree(pos)
		print ("[olvar] Mallorn Grows")
    end,
})

-- Pine sapling

minetest.register_abm({
    nodenames = {"olvar:pinesapling"},
    interval = PININT,
    chance = PINCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_pinetree(pos)
		print ("[olvar] Pine Grows")
    end,
})

-- Plum sapling

minetest.register_abm({
    nodenames = {"olvar:plumsapling"},
    interval = PLUINT,
    chance = PLUCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_plumtree(pos)
		print ("[olvar] Plum Tree Grows")
    end,
})

-- Rowan sapling

minetest.register_abm({
    nodenames = {"olvar:rowansapling"},
    interval = ROWINT,
    chance = ROWCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_rowantree(pos)
		print ("[olvar] Rowan Grows")
    end,
})

-- White Tree

minetest.register_abm({
    nodenames = {"olvar:whitesapling"},
    interval = WHIINT,
    chance = WHICHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_whitetree(pos)
		print ("[olvar] The White Tree of Minetest Grows")
    end,
})

-- Yavannamire Tree

minetest.register_abm({
    nodenames = {"olvar:yavannamiresapling"},
    interval = YAVINT,
    chance = YAVCHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		olvar_yavannamiretree(pos)
		print ("[olvar] Yavannamire Grows")
    end,
})