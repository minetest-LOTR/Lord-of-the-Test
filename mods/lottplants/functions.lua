-- TREE FUNCTIONS

local function check_add_node(pos, name)
	local nn = minetest.get_node(pos).name
	if nn == "air" or minetest.get_item_group(nn, "sapling") then
		minetest.set_node(pos, name)
	end
end

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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:alderleaf"})
				end
			end
			end
		end
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:aldertree"})
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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:appleleaf"})
				end
				if math.random() > (absi + absk) / 12 then
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="default:apple"})
				end
			end
			end
		end
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:birchleaf"})
				end
			end
			end
		end
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:birchtree"})
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
		    check_add_node({x=pos.x+i,y=pos.y+j+7,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k},{name="lottplants:beechleaf"})
		    check_add_node({x=pos.x+i+2,y=pos.y+j+4,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i-2,y=pos.y+j+4,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k+2},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j+4,z=pos.z+k-2},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i+3,y=pos.y+j+1,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i-3,y=pos.y+j+1,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k+3},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k-3},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i+3,y=pos.y+j-2,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i-3,y=pos.y+j-2,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+3},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k-3},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i+4,y=pos.y+j-5,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i-4,y=pos.y+j-5,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k+4},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k-4},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i+4,y=pos.y+j-8,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i-4,y=pos.y+j-8,z=pos.z+k},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k+4},{name="lottplants:beechleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k-4},{name="lottplants:beechleaf"})
		end
	end
	end
	for j = -3, t do
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:culumaldaleaf"})
				end
				if math.random() > (absi + absk) / 12 then
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:yellowflowers"})
				end
			end
			end
		end
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:elmleaf"})
				end
			end
			end
		end
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
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
			check_add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="lottplants:firleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},{name="lottplants:firleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="lottplants:firleaf"})
		end
	end
	end
	for j = -3, t do
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:pinetree"})
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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:lebethronleaf"})
				end
			end
			end
		end
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:lebethrontree"})
	end
end

-- Mallorn

function add_tree_branch_mallorn(pos)
	check_add_node(pos, {name="lottplants:mallorntree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			check_add_node(p, {name="lottplants:mallornleaf"})
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				check_add_node(p, {name="lottplants:mallornleaf"})
			end
		end
	end
end

function lottplants_mallorntree(pos)
    local height = 25 + math.random(5)
		if height < 10 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				check_add_node(p, {name="lottplants:mallorntree"})
				if i == height then
					add_tree_branch_mallorn({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mallorn({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mallorn({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					check_add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="lottplants:mallorntree"})
					check_add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="lottplants:mallorntree"})
					check_add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="lottplants:mallorntree"})
					check_add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="lottplants:mallorntree"})
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
					check_add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="lottplants:mallorntree"})
					check_add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="lottplants:mallorntree"})
					check_add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="lottplants:mallorntree"})
					check_add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="lottplants:mallorntree"})
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
					check_add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="lottplants:mallorntree"})
					check_add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="lottplants:mallorntree"})
					check_add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="lottplants:mallorntree"})
					check_add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="lottplants:mallorntree"})
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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:mallornleaf"})
				end
			end
			end
		end
	end
	for j = -3, 15 do
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:mallorntree"})
		if j == 0 then
			check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:mallorntree_grower"})
		end
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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:mallornleaf"})
				end
			end
			end
		end
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:mallorntree_young"})
		if j == 0 then
			check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:mallorntree_young_grower"})
		end
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
			check_add_node({x=pos.x+i,y=pos.y+j+3,z=pos.z+k},{name="lottplants:firleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="lottplants:firleaf"})
			check_add_node({x=pos.x+i+1,y=pos.y+j-1,z=pos.z+k},{name="lottplants:firleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+1},{name="lottplants:firleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-3,z=pos.z+k},{name="lottplants:firleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-4,z=pos.z+k},{name="lottplants:firleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="lottplants:firleaf"})
		end
	end
	end
	for j = -5, t do
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:pinetree"})
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
			check_add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i+1,y=pos.y+j-2,z=pos.z+k},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i-1,y=pos.y+j-2,z=pos.z+k},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k+1},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-2,z=pos.z+k-1},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i+1,y=pos.y+j-5,z=pos.z+k},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i-1,y=pos.y+j-5,z=pos.z+k},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k+1},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-5,z=pos.z+k-1},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i+2,y=pos.y+j-8,z=pos.z+k},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i-2,y=pos.y+j-8,z=pos.z+k},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k+2},{name="lottplants:pineleaf"})
			check_add_node({x=pos.x+i,y=pos.y+j-8,z=pos.z+k-2},{name="lottplants:pineleaf"})
		end
	end
	end
	for j = -3, t do
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="lottplants:pinetree"})
	end
end

-- Plum Trees

function lottplants_plumtree(pos)
	local t = 3 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:plumleaf"})
				end
				if math.random() > (absi + absk) / 2 then
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:plum"})
				end
			end
			end
		end
		if j ~= t then
			check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
		end
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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:rowanleaf"})
				end
			end
			end
		end
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:whiteleaf"})
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
					check_add_node({x = pos.x + i, y = pos.y + j, z = pos.z}, {name="default:tree", param2 = 16})
					check_add_node({x = pos.x, y = pos.y + j, z = pos.z + k}, {name="default:tree", param2 = 10})
				end
			end
			end
		end
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z}, {name="default:tree"})
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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:yavannamireleaf"})
				end
				if math.random() > (absi + absk) / 12 then
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="lottplants:yavannamirefruit"})
				end
			end
			end
		end
		check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
end

--Mirk large

function add_tree_branch_mirktree(pos)
	check_add_node(pos, {name="default:jungletree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.get_node(p)
			if (n.name=="air") then
				check_add_node(p, {name="lottplants:mirkleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.get_node(p)
				if (n.name=="air") then
					check_add_node(p, {name="lottplants:mirkleaf"})
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
				check_add_node(p, {name="default:jungletree"})
				if i == height then
					add_tree_branch_mirktree({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktree({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					check_add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:jungletree"})
					check_add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="default:jungletree"})
					check_add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:jungletree"})
					check_add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="default:jungletree"})
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
					check_add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="default:jungletree"})
					check_add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="default:jungletree"})
					check_add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="default:jungletree"})
					check_add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="default:jungletree"})
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
					check_add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="default:jungletree"})
					check_add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="default:jungletree"})
					check_add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="default:jungletree"})
					check_add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="default:jungletree"})
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
					check_add_node({x=pos.x+i,y=pos.y+j+math.random(1, 2),z=pos.z+k},{name="lottplants:mirkleaf"})
				end
			end
			end
			for i = -1, 1, 2 do
			for k = -1, 1, 2 do
				check_add_node({x=pos.x+i,y=pos.y+j,z=pos.z+k},{name="default:jungletree"})
			end
			end
		elseif j == 7 then
			for i = -2, 2, 4 do
			for k = -2, 2, 4 do
				check_add_node({x=pos.x+i,y=pos.y+j,z=pos.z+k},{name="default:jungletree"})
			end
			end
		else
			check_add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:jungletree"})
		end
	end
end

-- SAPLINGS

local function can_grow(pos)
	local node = minetest.get_node_or_nil({x = pos.x, y = pos.y, z = pos.z})
	if not node then
		return false
	end
	local growable_nodes = { "soil", "stone", "sand", "water" }
	for i, growable_node in ipairs (growable_nodes) do
		if minetest.get_item_group(node.name, growable_node) ~= 0 then
			return true
		end
	end
	if "air" == node.name then
		return true
	end
	return false
end

local function large_roots(pos)
	for j = -5, 0 do
		for i = -1, 2 do
		for k = -1, 2 do
			if i == 0 and j == 0 and k == 0 then
				-- This is the sapling, ignore it
			elseif not can_grow({x = pos.x + i, y = pos.y + j, z = pos.z + k}) then
				return false
			end
		end
		end
	end
	return true
end

-- Alders sapling

minetest.register_abm({
    nodenames = {"lottplants:aldersapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_aldertree(pos)
			end
		end
    end,
})

-- Apple Tree sapling

minetest.register_abm({
    nodenames = {"lottplants:applesapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_appletree(pos)
			end
		end
    end,
})

-- Birch sapling

minetest.register_abm({
    nodenames = {"lottplants:birchsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 3, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_birchtree(pos)
			end
		end
    end,
})

-- Beech sapling

minetest.register_abm({
    nodenames = {"lottplants:beechsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 3, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_beechtree(pos)
			end
		end
    end,
})

-- Culumalda sapling

minetest.register_abm({
    nodenames = {"lottplants:culumaldasapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_culumaldatree(pos)
			end
		end
    end,
})

-- Elm sapling

minetest.register_abm({
    nodenames = {"lottplants:elmsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 3, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_elmtree(pos)
			end
		end
    end,
})

-- Fir sapling

minetest.register_abm({
    nodenames = {"lottplants:firsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 3, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_firtree(pos)
			end
		end
    end,
})

-- Lebethron sapling

minetest.register_abm({
    nodenames = {"lottplants:lebethronsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 3, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_lebethrontree(pos)
			end
		end
    end,
})

-- Mallorn sapling

minetest.register_abm({
    nodenames = {"lottplants:mallornsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		local light_level = minetest.get_node_light(pos)
		if not light_level then
			return
		end
		local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
		if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
			lottplants_young_mallorn(pos)
		end
    end,
})

minetest.register_abm({
    nodenames = {"lottplants:mallorntree_young_grower"},
    interval = 67,
    chance = 25,
    action = function(pos, node, active_object_count, active_object_count_wider)
		local na = minetest.get_node_or_nil({x = pos.x, y = pos.y + 1, z = pos.z})
		local naa = minetest.get_node_or_nil({x = pos.x, y = pos.y + 2, z = pos.z})
		if na and naa and na.name == "lottplants:mallorntree_young" and naa.name == "lottplants:mallorntree_young" then
			if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
			can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) and
			can_grow({x = pos.x, y = pos.y - 3, z = pos.z}) then
				local light_level = minetest.get_node_light(pos)
				if not light_level then
					return
				end
				local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
				if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
					lottplants_smallmallorntree(pos)
				end
			end
		end
    end,
})

minetest.register_abm({
	nodenames = {"lottplants:mallorntree_grower"},
	interval = 67,
	chance = 50,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local na = minetest.get_node_or_nil({x = pos.x, y = pos.y + 1, z = pos.z})
		local naa = minetest.get_node_or_nil({x = pos.x, y = pos.y + 2, z = pos.z})
		if na and naa and na.name == "lottplants:mallorntree" and naa.name == "lottplants:mallorntree" then
			if large_roots(pos) ~= false then
				local light_level = minetest.get_node_light(pos)
				if not light_level then
					return
				end
				local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
				if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
					lottplants_mallorntree(pos)
				end
			end
		end
	end,
})

-- Pine sapling

minetest.register_abm({
    nodenames = {"lottplants:pinesapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 3, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_pinetree(pos)
			end
		end
    end,
})

-- Plum sapling

minetest.register_abm({
    nodenames = {"lottplants:plumsapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_plumtree(pos)
			end
		end
    end,
})

-- Rowan sapling

minetest.register_abm({
    nodenames = {"lottplants:rowansapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			--print(light_level, c)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_rowantree(pos)
			end
		end
    end,
})

-- White Tree

minetest.register_abm({
    nodenames = {"lottplants:whitesapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_whitetree(pos)
			end
		end
    end,
})

-- Yavannamire Tree

minetest.register_abm({
    nodenames = {"lottplants:yavannamiresapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
		can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_yavannamiretree(pos)
			end
		end
    end,
})

--Mirk Tree

minetest.register_abm({
    nodenames = {"lottplants:mirksapling"},
    interval = 67,
    chance = 11,
    action = function(pos, node, active_object_count, active_object_count_wider)
		if math.random(2) == 1 and large_roots(pos) then
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				lottplants_mirktree(pos)
			end
		else
			if can_grow({x = pos.x, y = pos.y - 1, z = pos.z}) and
			can_grow({x = pos.x, y = pos.y - 2, z = pos.z}) and
			can_grow({x = pos.x, y = pos.y - 3, z = pos.z}) then
				local light_level = minetest.get_node_light(pos)
				if not light_level then
					return
				end
				local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
				if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
					lottplants_smallmirktree(pos)
				end
			end
		end
    end,
})
