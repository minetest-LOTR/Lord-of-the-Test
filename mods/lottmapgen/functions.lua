--Plants

function lottmapgen_grass(data, vi, p2data)
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
	p2data[vi] = 40
end

function lottmapgen_lorien_grass(data, vi, p2data)
	local c_lorgrass1 = minetest.get_content_id("lottplants:lorien_grass_1")
	local c_lorgrass2 = minetest.get_content_id("lottplants:lorien_grass_2")
	local c_lorgrass3 = minetest.get_content_id("lottplants:lorien_grass_3")
	local c_lorgrass4 = minetest.get_content_id("lottplants:lorien_grass_4")
	local rand = math.random(4)
	if rand == 1 then
		data[vi] = c_lorgrass1
	elseif rand == 2 then
		data[vi] = c_lorgrass2
	elseif rand == 3 then
		data[vi] = c_lorgrass3
	else
		data[vi] = c_lorgrass4
	end
	p2data[vi] = 40
end

function lottmapgen_farmingplants(data, vi, p2data)
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
		p2data[vi] = 34
	elseif rand == 2 then
		data[vi] = c_plant2
		p2data[vi] = 3
	elseif rand == 3 then
		data[vi] = c_plant3
		p2data[vi] = 3
	elseif rand == 4 then
		data[vi] = c_plant4
		p2data[vi] = 40
	elseif rand == 5 then
		data[vi] = c_plant5
		p2data[vi] = 9
	elseif rand == 6 then
		data[vi] = c_plant6
		p2data[vi] = 34
	elseif rand == 7 then
		data[vi] = c_plant7
		p2data[vi] = 40
	elseif rand == 8 then
		data[vi] = c_plant8
		p2data[vi] = 10
	else
		data[vi] = c_plant9
	end
end

function lottmapgen_ithildinplants(data, vi, p2data)
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
	p2data[vi] = 40
end

function lottmapgen_lorienplants(data, vi, p2data)
	local c_lplant1 = minetest.get_content_id("lottplants:elanor")
	local c_lplant2 = minetest.get_content_id("lottplants:lissuin")
	local c_lplant3 = minetest.get_content_id("lottplants:niphredil")
	local rand = math.random(3)
	if rand == 1 then
		data[vi] = c_lplant1
		p2data[vi] = 10
	elseif rand == 2 then
		data[vi] = c_lplant2
		p2data[vi] = 41
	else
		data[vi] = c_lplant3
		p2data[vi] = 8
	end
end


function lottmapgen_papyrus(x, y, z, area, data, p2data)
	local c_papyrus = minetest.get_content_id("default:papyrus")
	local ph = math.random(0, 3)
	for j = 0, ph do
		local vip = area:index(x, y + j, z)
		data[vip] = c_papyrus
		p2data[vip] = 3
	end
end

function lottmapgen_farmingrareplants(data, vi, p2data)
	local c_rplant1 = minetest.get_content_id("lottplants:athelas")
	local c_rplant2 = minetest.get_content_id("lottplants:melon_wild")
	local rand = math.random(2)
	if rand == 1 then
		data[vi] = c_rplant1
		p2data[vi] = 2
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
	local t = 6 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 or j == t - 4 then
			for i = -3, 3 do
			for k = -3, 3 do
				local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
				if math.random(48) == 2 then
					data[vil] = c_whiteleaf
				elseif math.random(3) ~= 2 then
					data[vil] = c_whiteleaf
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
					local vil = area:index(x + i, y + j + 1, z + k)
					data[vil] = c_tree
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

function lottmapgen_young_mallorn(x, y, z, area, data)
	local c_youngmallorn = minetest.get_content_id("lottplants:mallorntree_young")
	local c_mallornleaf = minetest.get_content_id("lottplants:mallornleaf")
	local t = 6 + math.random(1) -- trunk height
	for j = 0, t do
		if j == t or j == t - 2 then
			for i = -1, 1 do
			for k = -1, 1 do
				local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					data[vil] = c_mallornleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_youngmallorn
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
	local c_tree = minetest.get_content_id("default:jungletree")
	local c_leaves = minetest.get_content_id("lottplants:mirkleaf")
	for j = -3, 7 do
		if j == 6 then
			for i = -4, 4 do
			for k = -4, 4 do
				if math.random(20) ~= 10 then
					local vil = area:index(x + i, y + j + math.random(1, 2), z + k)
					data[vil] = c_leaves
				end
			end
			end
      for i = -1, 1 do
			for k = -1, 1 do
          if math.abs(i) + math.abs(k) == 2 then
            local vit = area:index(x + i, y + j, z + k)
            data[vit] = c_tree
          end
      end
      end
		elseif j == 7 then
			for i = -2, 2, 4 do
			for k = -2, 2, 4 do
				local vit = area:index(x + i, y + j, z + k)
				data[vit] = c_tree
			end
			end
		else
			local vit = area:index(x, y + j, z)
			data[vit] = c_tree
		end
	end
end

function lottmapgen_pinetree(x, y, z, area, data)
	local c_pinetree = minetest.get_content_id("lottplants:pinetree")
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
		data[vit] = c_pinetree
	end
	local vil = area:index(x, y + 14, z)
	local vila = area:index(x, y + 15, z)
	local vilaa = area:index(x, y + 16, z)
	data[vil] = c_pineleaf
	data[vila] = c_pineleaf
	data[vilaa] = c_snow
end

function lottmapgen_firtree(x, y, z, area, data)
	local c_pinetree = minetest.get_content_id("lottplants:pinetree")
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
		data[vit] = c_pinetree
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

function lottmapgen_mallorntree(x, y, z, area, data)
	local c_maltree = minetest.get_content_id("lottplants:mallorntree")
	local c_malleaf = minetest.get_content_id("lottplants:mallornleaf")
	local top = math.random(25, 30)
	local mid = math.floor(top/2)
	for j = math.random(-4, -2), top do
		if j == top or j == top - 1 or j == top + 1
		or j == top - 2 or j == top - 3 then
			for i = -3, 2 do -- leaves
			for k = -3, 2 do
				local vi = area:index(x + i, y + j, z + k)
				if math.random(5) ~= 2 then
					data[vi] = c_malleaf
				end
			end
			end
			for i = -1, 4 do -- leaves
			for k = -1, 4 do
				local vi = area:index(x + i, y + j, z + k)
				if math.random(5) ~= 2 then
					data[vi] = c_malleaf
				end
			end
			end
		elseif j == mid + 5 or j == mid + 4 then
			for i = -1, 2 do -- leaves
			for k = -1, 2 do
				local vi = area:index(x + i, y + j, z + k)
				if math.random(5) ~= 2 then
					data[vi] = c_malleaf
				end
			end
			end
		elseif j == mid - 3 or j == mid - 2 or j == mid - 1 then
			for i = -2, 3 do -- leaves
			for k = -2, 3 do
				local vi = area:index(x + i, y + j, z + k)
				if math.random(5) ~= 2 then
					data[vi] = c_malleaf
				end
			end
			end
		end
		if j <= math.random(-1, 0) then -- roots
			for i = -2, 3 do
			for k = -2, 3 do
				if i == 0 and k == -1 or i == -1 and k == 1 or
				i == 1 and k == 2 or i == 2 and k == 0 then
					local vi = area:index(x + i, y + j, z + k)
					data[vi] = c_maltree
				end
			end
			end
		elseif j == top - 2 then
			for i = -2, 3 do
			for k = -2, 3 do
				if i == 0 and k == -1 or i == -1 and k == 1 or
				i == 1 and k == 2 or i == 2 and k == 0 then
					local vi = area:index(x + i, y + j, z + k)
					data[vi] = c_maltree
				elseif i == 0 and k == -2 or i == -2 and k == 1
				or i == 1 and k == 3 or i == 3 and k == 0 then
					local vi = area:index(x + i, y + j, z + k)
					data[vi] = c_maltree
				end
			end
			end
		end
		if j >= -1 and j <= top - 1 then -- trunk
			for i = 0, 1 do
			for k = 0, 1 do
				local vi = area:index(x + i, y + j, z + k)
				data[vi] = c_maltree
			end
			end
		end
	end
end

function lottmapgen_beechtree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_beechleaf = minetest.get_content_id("lottplants:beechleaf")
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
			data[area:index(x+i, y+j+7, z+k)] = c_beechleaf
			data[area:index(x+i, y+j+4, z+k)] = c_beechleaf
		    data[area:index(x+i+2, y+j+4, z+k)] = c_beechleaf
			data[area:index(x+i-2, y+j+4, z+k)] = c_beechleaf
			data[area:index(x+i, y+j+4, z+k+2)] = c_beechleaf
			data[area:index(x+i, y+j+4, z+k-2)] = c_beechleaf
			data[area:index(x+i, y+j+1, z+k)] = c_beechleaf
			data[area:index(x+i+3, y+j+1, z+k)] = c_beechleaf
			data[area:index(x+i-3, y+j+1, z+k)] = c_beechleaf
			data[area:index(x+i, y+j+1, z+k+3)] = c_beechleaf
			data[area:index(x+i, y+j+1, z+k-3)] = c_beechleaf
			data[area:index(x+i, y+j-2, z+k)] = c_beechleaf
			data[area:index(x+i+3, y+j-2, z+k)] = c_beechleaf
			data[area:index(x+i-3, y+j-2, z+k)] = c_beechleaf
			data[area:index(x+i, y+j-2, z+k+3)] = c_beechleaf
			data[area:index(x+i, y+j-2, z+k-3)] = c_beechleaf
			data[area:index(x+i, y+j-5, z+k)] = c_beechleaf
			data[area:index(x+i+4, y+j-5, z+k)] = c_beechleaf
			data[area:index(x+i-4, y+j-5, z+k)] = c_beechleaf
			data[area:index(x+i, y+j-5, z+k+4)] = c_beechleaf
			data[area:index(x+i, y+j-5, z+k-4)] = c_beechleaf
			data[area:index(x+i, y+j-8, z+k)] = c_beechleaf
			data[area:index(x+i+4, y+j-8, z+k)] = c_beechleaf
			data[area:index(x+i-4, y+j-8, z+k)] = c_beechleaf
			data[area:index(x+i, y+j-8, z+k+4)] = c_beechleaf
			data[area:index(x+i, y+j-8, z+k-4)] = c_beechleaf
		end
	end
	end
	for j = -3, t do
		data[area:index(x, y+j, z)] = c_tree
	end
end

function lottmapgen_mirktree(x, y, z, area, data)
	local c_juntree = minetest.get_content_id("default:jungletree")
	local c_junleaf = minetest.get_content_id("lottplants:mirkleaf")
	local top = math.random(6, 8)
	for j = math.random(-4, -2), top do
		if j == top or j == top - 1 or j == top + 1 or j == top - 2 then
			for i = -3, 4 do -- leaves
			for k = -3, 4 do
				local vi = area:index(x + i, y + j, z + k)
				if math.random(5) ~= 2 then
					data[vi] = c_junleaf
				end
			end
			end
		elseif j <= math.random(-1, 0) then -- roots
			for i = -1, 2, 3 do
			for k = -1, 2, 3 do
				local vi = area:index(x + i, y + j, z + k)
				data[vi] = c_juntree
			end
			end
		elseif j == top - 2 then
			for i = -2, 3 do
			for k = -2, 3 do
				if i == 0 and k == -1 or i == -1 and k == 1 or
				i == 1 and k == 2 or i == 2 and k == 0 then
					local vi = area:index(x + i, y + j, z + k)
					data[vi] = c_juntree
				elseif i == 0 and k == -2 or i == -2 and k == 1
				or i == 1 and k == 3 or i == 3 and k == 0 then
					local vi = area:index(x + i, y + j, z + k)
					data[vi] = c_juntree
				end
			end
			end
		end
		if j >= -1 and j <= top - 2 then -- trunk
			for i = 0, 1 do
			for k = 0, 1 do
				local vi = area:index(x + i, y + j, z + k)
				data[vi] = c_juntree
			end
			end
		end
	end
end

function lottmapgen_elf_workshop(x, y, z, area, data, p2data)
	local c_stonebrick = minetest.get_content_id("default:stonebrick")
	local c_cracked_stonebrick = minetest.get_content_id("default:cracked_stonebrick")
	local c_marblebrick = minetest.get_content_id("lottblocks:marble_brick")
	local c_elftorchwall = minetest.get_content_id("lottblocks:elf_torch_wall")
	local c_furnace = minetest.get_content_id("lottmapgen:furnace_spawner")
	local c_dual_furnace = minetest.get_content_id("lottmapgen:dual_furnace_spawner")
	local c_ringsilver_furnace = minetest.get_content_id("lottmapgen:ringsilver_furnace_spawner")
	local c_water = minetest.get_content_id("default:water_source")
	local c_ringchest = minetest.get_content_id("lottmapgen:ring_chest_spawner")
	local c_table = minetest.get_content_id("lottblocks:mallorn_table")
	local c_chair = minetest.get_content_id("lottblocks:mallorn_chair")
	local c_bedb = minetest.get_content_id("lottblocks:bed_bottom_blue")
	local c_bedt = minetest.get_content_id("lottblocks:bed_top_blue")
	local c_malpillar = minetest.get_content_id("lottblocks:mallorn_pillar")
	local c_air = minetest.get_content_id("air")
	for j = 0, 6 do
		if j == 0 then
			for i = 0, 7 do
			for k = 0, 9 do
				local vi = area:index(x + i, y + j, z + k)
				if i == 1 and k == 6 then
					data[vi] = c_water
				else
					data[vi] = c_marblebrick
				end
			end
			end
		elseif j == 6 then
			for i = 0, 7 do
			for k = 0, 9 do
				local vi = area:index(x + i, y + j, z + k)
				if math.random(1, 3) == 2 then
					data[vi] = c_cracked_stonebrick
				else
					data[vi] = c_stonebrick
				end
			end
			end
		else
			for i = 0, 7 do
			for k = 0, 9 do
				local vi = area:index(x + i, y + j, z + k)
				if i == 0 or i == 7 or k == 0 or k == 9 then
					if math.random(1, 3) == 2 then
						data[vi] = c_cracked_stonebrick
					else
						data[vi] = c_stonebrick
					end
				elseif (i == 1 and k == 1) or (i == 6 and k == 1) or
				(i == 1 and k == 8) or (i == 6 and k == 8) then
					data[vi] = c_malpillar
				elseif (i == 1 and j == 4 and k == 2) or
				(i == 6 and j == 4 and k == 2) or
				(i == 1 and j == 4 and k == 7) or
				(i == 6 and j == 4 and k == 7) then
					data[vi] = c_elftorchwall
					if i == 6 then
						p2data[vi] = 2
					else
						p2data[vi] = 3
					end
				elseif i == 1 and j == 1 and k == 2 then
					data[vi] = c_furnace
					p2data[vi] = 3
				elseif i == 1 and j == 1 and (k == 3 or k == 4) then
					data[vi] = c_dual_furnace
					p2data[vi] = 3
				elseif i == 1 and j == 1 and k == 5 then
					data[vi] = c_ringsilver_furnace
					p2data[vi] = 3
				elseif i == 1 and j == 1 and k == 7 then
					data[vi] = c_ringchest
					p2data[vi] = 3
				elseif i == 6 and j == 1 and k == 3 and math.random(1, 2) == 1 then
					data[vi] = c_table
				elseif i == 6 and j == 1 and (k == 2 or k == 4) and math.random(1, 3) == 1 then
					data[vi] = c_chair
					if k == 2 then
						p2data[vi] = 2
					end
				elseif i == 5 and j == 1 and k == 8 and math.random(1,4) == 2 then
					data[vi] = c_bedt
					p2data[vi] = 1
					vi = area:index(x + i - 1, y + j, z + k)
					data[vi] = c_bedb
					p2data[vi] = 1
				else
					data[vi] = c_air
				end
			end
			end
		end
	end
end

function lottmapgen_mithrilore(x, y, z, area, data)
	local c_ore = minetest.get_content_id("lottores:mithril_ore")
	local c_stone = minetest.get_content_id("default:stone")
	for j = -1, 0 do
	for i = -1, 0 do
	for k = -1, 0 do
		local vil = area:index(x + i, y + j, z + k)
		if math.random(3) == 1 then
			data[vil] = c_stone
		else
			data[vil] = c_ore
		end
	end
	end
	end
end

function lottmapgen_meseore(x, y, z, area, data)
	local c_ore = minetest.get_content_id("default:stone_with_mese")
	local c_stone = minetest.get_content_id("default:stone")
	for j = -1, 0 do
	for i = -1, 0 do
	for k = -1, 0 do
		local vil = area:index(x + i, y + j, z + k)
		if math.random(3) == 1 then
			data[vil] = c_stone
		else
			data[vil] = c_ore
		end
	end
	end
	end
end

function lottmapgen_orcore(x, y, z, area, data)
	local c_ore = minetest.get_content_id("lottores:orc_ore")
	local c_stone = minetest.get_content_id("default:stone")
	for j = -1, 0 do
	for i = -1, 0 do
	for k = -1, 0 do
		local vil = area:index(x + i, y + j, z + k)
		if math.random(10) == 1 then
			data[vil] = c_stone
		else
			data[vil] = c_ore
		end
	end
	end
	end
end

function lottmapgen_biomes(biome, n_temp, n_humid, n_ran, LOTET, LOHUT, LORAN, HITET, HIHUT, HIRAN)
	if n_temp < LOTET then
		if n_humid < LOHUT then
			return 1 -- (Angmar)
		elseif n_humid > HIHUT then
			return 3 -- (Trollshaws)
		else
			return 2 -- (Snowplains)
		end
	elseif n_temp > HITET then
		if n_humid < LOHUT then
			return 7 -- (Lorien)
		elseif n_humid > HIHUT then
			return 9 -- (Fangorn)
		elseif n_ran < LORAN then
			return 10 -- (Mirkwood)
		elseif n_ran > HIRAN then
			return 11 -- (Iron Hills)
		else
			return 4 -- (Dunlands)
		end
	else
		if n_humid < LOHUT then
			return 8 -- (Mordor)
		elseif n_humid > HIHUT then
			return 6 -- (Ithilien)
		elseif n_ran < LORAN then
			return 13 -- (Shire)
		elseif n_ran > HIRAN then
			return 12 -- (Rohan)
		else
			return 5 -- (Gondor)
		end
	end
end

