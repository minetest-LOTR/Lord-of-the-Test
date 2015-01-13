--Plants

function lottmapgen_grass(data, vi)
	local c_grass1 = minetest.get_content_id("default:grass_1")
	local c_grass2 = minetest.get_content_id("default:grass_2")
	local c_grass3 = minetest.get_content_id("default:grass_3")
	local c_grass4 = minetest.get_content_id("default:grass_4")
	local c_grass5 = minetest.get_content_id("default:grass_5")
	local rand = math.random(5)
	if rand == 1 then
		data[vi] = c_grass1
	elseif rand == 2 then
		data[vi] = c_grass2
	elseif rand == 3 then
		data[vi] = c_grass3
	elseif rand == 4 then
		data[vi] = c_grass4
	else
		data[vi] = c_grass5
	end
end

function lottmapgen_farmingplants(data, vi)
	local c_plant1 = minetest.get_content_id("lottplants:pipeweed_wild")
	local c_plant2 = minetest.get_content_id("lottplants:barley_wild")
	local c_plant3 = minetest.get_content_id("lottplants:corn_wild")
	local c_plant4 = minetest.get_content_id("lottplants:potato_wild")
	local c_plant5 = minetest.get_content_id("lottplants:mushroom_wild")
     local c_plant6 = minetest.get_content_id("lottplants:berries_wild")
     local c_plant7 = minetest.get_content_id("lottplants:turnips_wild")
     local c_plant8 = minetest.get_content_id("lottplants:tomatoes_wild")
     local c_plant9 = minetest.get_content_id("lottplants:cabbage_wild")
	local rand = math.random(9)
	if rand == 1 then
		data[vi] = c_plant1
	elseif rand == 2 then
		data[vi] = c_plant2
	elseif rand == 3 then
		data[vi] = c_plant3
	elseif rand == 4 then
		data[vi] = c_plant4
	elseif rand == 5 then
		data[vi] = c_plant5
     elseif rand == 6 then
          data[vi] = c_plant6
     elseif rand == 7 then
		data[vi] = c_plant7
	elseif rand == 8 then
		data[vi] = c_plant8
     else
		data[vi] = c_plant9
	end
end

function lottmapgen_ithildinplants(data, vi)
	local c_iplant1 = minetest.get_content_id("lottplants:asphodel")
	local c_iplant2 = minetest.get_content_id("lottplants:anemones")
	local c_iplant3 = minetest.get_content_id("lottplants:eglantive")
	local c_iplant4 = minetest.get_content_id("lottplants:iris")
	local rand = math.random(4)
	if rand == 1 then
		data[vi] = c_iplant1
	elseif rand == 2 then
		data[vi] = c_iplant2
	elseif rand == 3 then
		data[vi] = c_iplant3
	else
		data[vi] = c_iplant4
	end
end

function lottmapgen_lorienplants(data, vi)
	local c_lplant1 = minetest.get_content_id("lottplants:elanor")
	local c_lplant2 = minetest.get_content_id("lottplants:lissuin")
	local c_lplant3 = minetest.get_content_id("lottplants:niphredil")
	local rand = math.random(3)
	if rand == 1 then
		data[vi] = c_lplant1
	elseif rand == 2 then
		data[vi] = c_lplant2
	else
		data[vi] = c_lplant3
	end
end


function lottmapgen_papyrus(x, y, z, area, data)
	local c_papyrus = minetest.get_content_id("default:papyrus")
	local ph = math.random(0, 3)
	for j = 0, ph do
		local vip = area:index(x, y + j, z)
		data[vip] = c_papyrus
	end
end

function lottmapgen_farmingrareplants(data, vi)
     local c_rplant1 = minetest.get_content_id("lottplants:athelas")
	local c_rplant2 = minetest.get_content_id("lottplants:melon_wild")
	local rand = math.random(2)
	if rand == 1 then
		data[vi] = c_rplant1
     else
		data[vi] = c_rplant2
	end
end

function lottmapgen_burnedtree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	for j = -2, 4 do
	for i = -2, 2 do
		if i == 0 or j == 2 or (j == 3 and math.abs(i) == 2) then
			local vic = area:index(x + i, y + j, z)
			data[vic] = c_tree
		end
	end
	end
end

function lottmapgen_appletree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_apple = minetest.get_content_id("default:apple")
	local c_leaves = minetest.get_content_id("default:leaves")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = c_apple
				elseif math.random(3) ~= 2 then
					data[vil] = c_leaves
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen_plumtree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_plum = minetest.get_content_id("lottplants:plum")
	local c_plumleaf = minetest.get_content_id("lottplants:plumleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = c_plum
				elseif math.random(3) ~= 2 then
					data[vil] = c_plumleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen_rowantree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_rowanberry = minetest.get_content_id("lottplants:rowanberry")
	local c_rowanleaf = minetest.get_content_id("lottplants:rowanleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = c_rowanberry
				elseif math.random(3) ~= 2 then
					data[vil] = c_rowanleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen_culumaldatree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_yellowflowers = minetest.get_content_id("lottplants:yellowflowers")
	local c_culumaldaleaf = minetest.get_content_id("lottplants:culumaldaleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = c_yellowflowers
				elseif math.random(3) ~= 2 then
					data[vil] = c_culumaldaleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen_yavannamiretree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_yavannamirefruit = minetest.get_content_id("lottplants:yavannamirefruit")
	local c_yavannamireleaf = minetest.get_content_id("lottplants:yavannamireleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = c_yavannamirefruit
				elseif math.random(3) ~= 2 then
					data[vil] = c_yavannamireleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen_defaulttree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_leaves = minetest.get_content_id("default:leaves")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = c_leaves
				elseif math.random(3) ~= 2 then
					data[vil] = c_leaves
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen_aldertree(x, y, z, area, data)
	local c_aldertree = minetest.get_content_id("lottplants:aldertree")
	local c_alderleaf = minetest.get_content_id("lottplants:alderleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = c_alderleaf
				elseif math.random(3) ~= 2 then
					data[vil] = c_alderleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_aldertree
	end
end

function lottmapgen_lebethrontree(x, y, z, area, data)
	local c_lebethrontree = minetest.get_content_id("lottplants:lebethrontree")
	local c_lebethronleaf = minetest.get_content_id("lottplants:lebethronleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = c_lebethronleaf
				elseif math.random(3) ~= 2 then
					data[vil] = c_lebethronleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_lebethrontree
	end
end

function lottmapgen_whitetree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_whiteleaf = minetest.get_content_id("lottplants:whiteleaf")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					data[vil] = c_whiteleaf
				elseif math.random(3) ~= 2 then
					data[vil] = c_whiteleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen_birchtree(x, y, z, area, data)
	local c_birchtree = minetest.get_content_id("lottplants:birchtree")
	local c_birchleaf = minetest.get_content_id("lottplants:birchleaf")
	for j = -5, 12 do
		if j == 8 or j == 11 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
				if math.random(5) ~= 2 then
					data[vil] = c_birchleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_birchtree
	end
end

function lottmapgen_elmtree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_elmleaf = minetest.get_content_id("lottplants:elmleaf")
	for j = -5, 25 do
		if j == 11 or j == 18 or j == 24 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
				if math.random(5) ~= 2 then
					data[vil] = c_elmleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen_mallornsmalltree(x, y, z, area, data)
	local c_mallorntree = minetest.get_content_id("lottplants:mallorntree")
	local c_mallornleaf = minetest.get_content_id("lottplants:mallornleaf")
	for j = -5, 15 do
		if j == 11 or j == 15 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
				if math.random(5) ~= 2 then
					data[vil] = c_mallornleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_mallorntree
	end
end

function lottmapgen_jungletree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_leaves = minetest.get_content_id("default:leaves")
	for j = -2, 5 do
		if j == 4 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
				if math.random(5) ~= 2 then
					data[vil] = c_leaves
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen_jungletree2(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_leaves = minetest.get_content_id("default:leaves")
	for j = -3, 7 do
		if j == 5 then
			for i = -4, 4 do
			for k = -4, 4 do
				if not (i == 0 or k == 0) then
					if math.random(5) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = c_leaves
					end
				end
			end
			end
		elseif j == 6 then
			for i = -2, 2, 4 do
			for k = -2, 2, 4 do
				local vit = area:index(x + i, y + j, z + k)
				data[vit] = c_tree
			end
			end
		elseif j == 5 then
			for i = -1, 1 do
			for k = -1, 1 do
				if math.abs(i) + math.abs(k) == 2 then
					local vit = area:index(x + i, y + j, z + k)
					data[vit] = c_tree
				end
			end
			end
		else
			local vit = area:index(x, y + j, z)
			data[vit] = c_tree
		end
	end
end

function lottmapgen_pinetree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_pineleaf = minetest.get_content_id("lottplants:pineleaf")
	local c_snow = minetest.get_content_id("default:snow")
	for j = -4, 13 do
		if j == 3 or j == 6 or j == 9 or j == 12 then
			for i = -2, 2 do
			for k = -2, 2 do
				if math.abs(i) == 2 or math.abs(k) == 2 then
					if math.random(5) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = c_pineleaf
						local vila = area:index(x + i, y + j + 1, z + k)
						data[vila] = c_snow
					end
				end
			end
			end
		elseif j == 4 or j == 7 or j == 10 or j == 13 then
			for i = -1, 1 do
			for k = -1, 1 do
				if not (i == 0 and j == 0) then
					if math.random(7) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = c_pineleaf
						local vila = area:index(x + i, y + j + 1, z + k)
						data[vila] = c_snow
					end
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
	local vil = area:index(x, y + 14, z)
	local vila = area:index(x, y + 15, z)
	local vilaa = area:index(x, y + 16, z)
	data[vil] = c_pineleaf
	data[vila] = c_pineleaf
	data[vilaa] = c_snow
end

function lottmapgen_firtree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_firleaf = minetest.get_content_id("lottplants:firleaf")
	local c_snow = minetest.get_content_id("default:snow")
	for j = -4, 13 do
		if j == 3 or j == 6 or j == 9 or j == 12 then
			for i = -2, 2 do
			for k = -2, 2 do
				if math.abs(i) == 2 or math.abs(k) == 2 then
					if math.random(5) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = c_firleaf
						local vila = area:index(x + i, y + j + 1, z + k)
						data[vila] = c_snow
					end
				end
			end
			end
		elseif j == 4 or j == 7 or j == 10 or j == 13 then
			for i = -1, 1 do
			for k = -1, 1 do
				if not (i == 0 and j == 0) then
					if math.random(7) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = c_firleaf
						local vila = area:index(x + i, y + j + 1, z + k)
						data[vila] = c_snow
					end
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
	local vil = area:index(x, y + 14, z)
	local vila = area:index(x, y + 15, z)
	local vilaa = area:index(x, y + 16, z)
	data[vil] = c_firleaf
	data[vila] = c_firleaf
	data[vilaa] = c_snow
end



function lottmapgen_oaktree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_leaves = minetest.get_content_id("default:leaves")
	for j = -4, 13 do
		if j == 3 or j == 6 or j == 9 or j == 12 then
			for i = -2, 2 do
			for k = -2, 2 do
				if math.abs(i) == 2 or math.abs(k) == 2 then
					if math.random(5) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = c_leaves
					end
				end
			end
			end
		elseif j == 4 or j == 7 or j == 10 or j == 13 then
			for i = -1, 1 do
			for k = -1, 1 do
				if not (i == 0 and j == 0) then
					if math.random(7) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = c_leaves
					end
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
	local vil = area:index(x, y + 14, z)
	local vila = area:index(x, y + 15, z)
	data[vil] = c_leaves
	data[vila] = c_leaves
end

-- Trees Big

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

function lottmapgen_mallorntree(pos)
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

minetest.register_node("lottmapgen:mirkleaves", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
     sunlight_propagates = false,
	waving = 1,
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1, not_in_creative_inventory =1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'default:sapling'},
				rarity = 20,
			},
			{
				items = {'default:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

function add_tree_branch_mirktree(pos)
	minetest.env:add_node(pos, {name="default:tree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="lottmapgen:mirkleaves"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="lottmapgen:mirkleaves"})
				end
			end
		end
	end
end

function lottmapgen_beechtree(pos)
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

function lottmapgen_mirktree(pos)
    local height = 5 + math.random(1)
		if height < 1 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="default:tree"})
				if i == height then
					add_tree_branch_mirktree({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mirktree({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktree({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mirktree({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="default:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="default:tree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mirktree(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mirktree(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="default:tree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="default:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="default:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="default:tree"})
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
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="default:tree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="default:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="default:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="default:tree"})
				end
			end
		end
end

minetest.register_node("lottmapgen:mallorngen", {
	tiles = {"lottmapgen_lorien_grass.png", "default_dirt.png", "default_dirt.png^lottmapgen_lorien_grass_side.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = '',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottmapgen:beechgen", {
	tiles = {"default_snow.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = '',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottmapgen:mirktreegen", {
	tiles = {"lottmapgen_mirkwood_grass.png", "default_dirt.png", "default_dirt.png^lottmapgen_mirkwood_grass_side.png"}, 
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = '',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_abm({
	nodenames = {"lottmapgen:mallorngen"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
          lottmapgen_mallorntree(pos)
     end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:mirktreegen"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
          lottmapgen_mirktree(pos)
     end,
})

minetest.register_abm({
    nodenames = {"lottmapgen:beechgen"},
    	interval = 1,
	chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottmapgen_beechtree(pos)
    end,
})

function add_tree_branch_mirktreetest(pos)
	minetest.env:add_node(pos, {name="default:tree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="lottmapgen:mirkleaves"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="lottmapgen:mirkleaves"})
				end
			end
		end
	end
end

function lottmapgen_mirktreetest(pos)
    local height = 13 + math.random(1)
		if height < 1 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="default:tree"})
				if i == height then
					add_tree_branch_mirktreetest({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_mirktreetest({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktreetest({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_mirktreetest({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_mirktreetest({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="default:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="default:tree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mirktreetest(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_mirktreetest(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="default:tree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="default:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="default:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="default:tree"})
				end
				if i == height then
					add_tree_branch_mirktreetest({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_mirktreetest({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktreetest({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_mirktreetest({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_mirktreetest({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_mirktreetest({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktreetest({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_mirktreetest({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_mirktreetest({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_mirktreetest({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktreetest({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_mirktreetest({x=pos.x, y=pos.y+i, z=pos.z})
				else
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="default:tree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="default:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="default:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="default:tree"})
				end
			end
		end
end

minetest.register_abm({
    nodenames = {"lottmapgen:mirktest"},
    	interval = 1,
	chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
		lottmapgen_mirktreetest(pos)
    end,
})

minetest.register_node("lottmapgen:mirktest", {
	tiles = {"default_glass.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = '',
	sounds = default.node_sound_stone_defaults(),
})