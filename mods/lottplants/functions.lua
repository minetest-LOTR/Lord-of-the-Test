-- TREE FUNCTIONS

-- Alders

function lottplants_aldertree(pos)
	local t = 6 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:alderleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:aldertree"})
	end
end

-- Apple tree

function lottplants_appletree(pos)
	local t = 4 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:appleleaf"})
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

function lottplants_birchtree(pos)
	local t = 7 + math.random(5) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:birchleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:birchtree"})
	end
end

-- Beeches

function lottplants_beechtree(pos)
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
		    minetest.add_node({x=pos.x+i,y=pos.y+j+7,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k},{name="lottplants:beechleaf"})
		    minetest.add_node({x=pos.x+i+2,y=pos.y+j+4,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i-2,y=pos.y+j+4,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k+2},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k-2},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i+3,y=pos.y+j+1,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i-3,y=pos.y+j+1,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k+3},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k-3},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i+3,y=pos.y+j-2,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i-3,y=pos.y+j-2,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+3},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k-3},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i+4,y=pos.y+j-5,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i-4,y=pos.y+j-5,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k+4},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k-4},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i+4,y=pos.y+j-8,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i-4,y=pos.y+j-8,z=pos.z+k},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k+4},{name="lottplants:beechleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k-4},{name="lottplants:beechleaf"})
		end
	end
	end
	for j = -3, t do
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- Culumalda

function lottplants_culumaldatree(pos)
	local t = 4 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:culumaldaleaf"})
				end
				if math.random() > (absi + absk) / 12 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:yellowflowers"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- Elms

function lottplants_elmtree(pos)
	local t = 20 + math.random(5) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:elmleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- Firs

function lottplants_firtree(pos)
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
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="lottplants:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},{name="lottplants:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="lottplants:firleaf"})
		end
	end
	end
	for j = -3, t do
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:pinetree"})
	end
end

-- Lebethron

function lottplants_lebethrontree(pos)
	local t = 3 + math.random(1) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:lebethronleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:lebethrontree"})
	end
end

-- Mallorn

function add_tree_branch_mallorn(pos)
	minetest.env:add_node(pos, {name="lottplants:mallorntree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="lottplants:mallornleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="lottplants:mallornleaf"})
				end
			end
		end
	end
end

function lottplants_mallorntree(pos)
    local height = 25 + math.random(5)
		if height < 10 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="lottplants:mallorntree"})
				if i == height then
					add_tree_branch_mallorn({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="lottplants:mallorntree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="lottplants:mallorntree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="lottplants:mallorntree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="lottplants:mallorntree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mallorn(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mallorn(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="lottplants:mallorntree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="lottplants:mallorntree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="lottplants:mallorntree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="lottplants:mallorntree"})
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
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="lottplants:mallorntree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="lottplants:mallorntree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="lottplants:mallorntree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="lottplants:mallorntree"})
				end
			end
		end
end

function lottplants_smallmallorntree(pos)
	for j = -3, 15 do
		if j == 11 or j == 15 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:mallornleaf"})
				end
			end
			end
		end
	end
	for j = -5, 15 do
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:mallorntree"})
	end
end

function lottplants_young_mallorn(pos)
	local t = 6 + math.random(1) -- trunk height
	for j = 0, t do
		if j == t or j == t - 2 then
			for i = -1, 1 do
			for k = -1, 1 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:mallornleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:mallorntree_young"})
	end
end

-- Oaks

function lottplants_oaktree(pos)
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
			minetest.add_node({x=pos.x+i,y=pos.y+j+3,z=pos.z+k},{name="lottplants:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="lottplants:firleaf"})
			minetest.add_node({x=pos.x+i+1,y=pos.y+j-1,z=pos.z+k},{name="lottplants:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+1},{name="lottplants:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-3,z=pos.z+k},{name="lottplants:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-4,z=pos.z+k},{name="lottplants:firleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="lottplants:firleaf"})
		end
	end
	end
	for j = -5, t do
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:pinetree"})
	end
end

-- Pines

function lottplants_pinetree(pos)
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
			minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i+1,y=pos.y+j-2,z=pos.z+k},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i-1,y=pos.y+j-2,z=pos.z+k},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+1},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k-1},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i+1,y=pos.y+j-5,z=pos.z+k},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i-1,y=pos.y+j-5,z=pos.z+k},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k+1},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k-1},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i+2,y=pos.y+j-8,z=pos.z+k},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i-2,y=pos.y+j-8,z=pos.z+k},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k+2},{name="lottplants:pineleaf"})
			minetest.add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k-2},{name="lottplants:pineleaf"})
		end
	end
	end
	for j = -3, t do
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:pinetree"})
	end
end

-- Plum Trees

function lottplants_plumtree(pos)
	local t = 4 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:plumleaf"})
				end
				if math.random() > (absi + absk) / 12 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:plum"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end


-- Rowans

function lottplants_rowantree(pos)
	local t = 4 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 12 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:rowanleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

-- White Tree

function lottplants_whitetree(pos)
	local t = 6 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 or j == t - 4 then
			for i = -3, 3 do
			for k = -3, 3 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:whiteleaf"})
				end
			end
			end
		end
		if j == t - 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				if i == -1 and k == 0 or i == 1 and k == 0
				or k == 1 and i == 0 or k == -1 and i == 0
				or i == -2 and k == 0 or i == 2 and k == 0
				or k == 2 and i == 0 or k == -2 and i == 0 then
					minetest.add_node({x = pos.x + i, y = pos.y + j, z = pos.z}, {name="default:tree", param2 = 16})
					minetest.add_node({x = pos.x, y = pos.y + j, z = pos.z + k}, {name="default:tree", param2 = 10})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z}, {name="default:tree"})
	end
end

-- Yavannamire

function lottplants_yavannamiretree(pos)
	local t = 4 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:yavannamireleaf"})
				end
				if math.random() > (absi + absk) / 12 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:yavannamirefruit"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

--Mirk large

function add_tree_branch_mirktree(pos)
	minetest.env:add_node(pos, {name="default:jungletree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="lottplants:mirkleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="lottplants:mirkleaf"})
				end
			end
		end
	end
end

function lottplants_mirktree(pos)
    local height = 5 + math.random(1)
		if height < 1 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="default:jungletree"})
				if i == height then
					add_tree_branch_mirktree({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktree({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:jungletree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="default:jungletree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:jungletree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="default:jungletree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mirktree(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					local branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mirktree(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="default:jungletree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="default:jungletree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="default:jungletree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="default:jungletree"})
				end
				if i == height then
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_mirktree({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_mirktree({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_mirktree({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_mirktree({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i, z=pos.z})
				else
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="default:jungletree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="default:jungletree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="default:jungletree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="default:jungletree"})
				end
			end
		end
end

--Mirk Small

function lottplants_smallmirktree(pos)
	for j = -3, 7 do
		if j == 6 then
			for i = -4, 4 do
			for k = -4, 4 do
				if math.random(20) ~= 10 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(1, 2),z=pos.z+k},{name="lottplants:mirkleaf"})
				end
			end
			end
      for i = -1, 1 do
			for k = -1, 1 do
          if math.abs(i) + math.abs(k) == 2 then
            minetest.add_node({x=pos.x+i,y=pos.y+j,z=pos.z+k},{name="default:jungletree"})
          end
      end
      end
		elseif j == 7 then
			for i = -2, 2, 4 do
			for k = -2, 2, 4 do
				minetest.add_node({x=pos.x+i,y=pos.y+j,z=pos.z+k},{name="default:jungletree"})
			end
			end
		else
			minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:jungletree"})
		end
	end
end

-- SAPLINGS

-- Alders sapling

minetest.register_abm({
    nodenames = {"lottplants:aldersapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_aldertree(pos)
		print ("[lottplants] Alder Grows")
    end,
})

-- Apple Tree sapling

minetest.register_abm({
    nodenames = {"lottplants:applesapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_appletree(pos)
		print ("[lottplants] Apple Tree Grows")
    end,
})

-- Birch sapling

minetest.register_abm({
    nodenames = {"lottplants:birchsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_birchtree(pos)
		print ("[lottplants] Birch Grows")
    end,
})

-- Beech sapling

minetest.register_abm({
    nodenames = {"lottplants:beechsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_beechtree(pos)
		print ("[lottplants] Beech Grows")
    end,
})

-- Culumalda sapling

minetest.register_abm({
    nodenames = {"lottplants:culumaldasapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_culumaldatree(pos)
		print ("[lottplants] Culumalda Grows")
    end,
})

-- Elm sapling

minetest.register_abm({
    nodenames = {"lottplants:elmsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_elmtree(pos)
		print ("[lottplants] Elm Grows")
    end,
})

-- Fir sapling

minetest.register_abm({
    nodenames = {"lottplants:firsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_firtree(pos)
		print ("[lottplants] Fir Grows")
    end,
})

-- Lebethron sapling

minetest.register_abm({
    nodenames = {"lottplants:lebethronsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_lebethrontree(pos)
		print ("[lottplants] Lebethron Grows")
    end,
})

-- Mallorn sapling

minetest.register_abm({
    nodenames = {"lottplants:mallornsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if math.random(3) == 1 then
			lottplants_mallorntree(pos)
		elseif math.random(3) == 2 then
			lottplants_smallmallorntree(pos)
		else
			lottplants_young_mallorn(pos)
		end
		print ("[lottplants] Mallorn Grows")
    end,
})

-- Pine sapling

minetest.register_abm({
    nodenames = {"lottplants:pinesapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_pinetree(pos)
		print ("[lottplants] Pine Grows")
    end,
})

-- Plum sapling

minetest.register_abm({
    nodenames = {"lottplants:plumsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_plumtree(pos)
		print ("[lottplants] Plum Tree Grows")
    end,
})

-- Rowan sapling

minetest.register_abm({
    nodenames = {"lottplants:rowansapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_rowantree(pos)
		print ("[lottplants] Rowan Grows")
    end,
})

-- White Tree

minetest.register_abm({
    nodenames = {"lottplants:whitesapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_whitetree(pos)
		print ("[lottplants] The White Tree of Minetest Grows")
    end,
})

-- Yavannamire Tree

minetest.register_abm({
    nodenames = {"lottplants:yavannamiresapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottplants_yavannamiretree(pos)
		print ("[lottplants] Yavannamire Grows")
    end,
})

--Mirk Tree

minetest.register_abm({
    nodenames = {"lottplants:mirksapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if math.random(2) == 1 then
			lottplants_mirktree(pos)
		else
			lottplants_smallmirktree(pos)
		end
		print ("[lottplants] Mirk Tree Grows")
    end,
})
