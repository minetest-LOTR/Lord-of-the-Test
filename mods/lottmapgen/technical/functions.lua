--Plants

function lottmapgen.grass(data, vi, p2data)
	local c_grass = minetest.get_content_id("lottplants:grass_" ..math.random(5))
	data[vi] = c_grass
	p2data[vi] = 40
end

function lottmapgen.dry_grass(data, vi, p2data)
	local c_grass = minetest.get_content_id("default:dry_grass_" ..math.random(5))
	data[vi] = c_grass
	p2data[vi] = 40
end

function lottmapgen.lorien_grass(data, vi, p2data)
	local c_lorgrass = minetest.get_content_id("lottplants:lorien_grass_" .. math.random(3))
	data[vi] = c_lorgrass
	p2data[vi] = 40
end

function lottmapgen.pine_grass(data, vi, p2data)
	local c_pinegrass = minetest.get_content_id("lottplants:pine_grass_" .. math.random(3))
	data[vi] = c_pinegrass
	p2data[vi] = 40
end

function lottmapgen.tall_grass(x, y, z, area, data, p2data)
	local c_tallgrassb = minetest.get_content_id("lottplants:tall_grass_bottom")
	local c_tallgrasst = minetest.get_content_id("lottplants:tall_grass_" .. math.random(5))
	local vi = area:index(x, y, z)
	data[vi] = c_tallgrassb
	vi = area:index(x, y + 1, z)
	data[vi] = c_tallgrasst
end

function lottmapgen.farming_plants(data, vi, p2data)
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

function lottmapgen.ithildin_plants(data, vi, p2data)
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

function lottmapgen.lorien_plants(data, vi, p2data, via)
	local c_elanor = minetest.get_content_id("lottplants:elanor")
	local c_lissuin = minetest.get_content_id("lottplants:lissuin_short")
	local c_lissuin_b = minetest.get_content_id("lottplants:lissuin_tall_bottom")
	local c_lissuin_t = minetest.get_content_id("lottplants:lissuin_tall_top")
	local c_niphredil = minetest.get_content_id("lottplants:niphredil")
	local rand = math.random(3)
	if rand == 1 then
		data[vi] = c_elanor
		p2data[vi] = 10
	elseif rand == 2 then
		if math.random(5) == 1 then
			data[vi] = c_lissuin_b
			data[vi + 112] = c_lissuin_t
		else
			data[vi] = c_lissuin
			p2data[vi] = 3
		end
	else
		data[vi] = c_niphredil
		p2data[vi] = 8
	end
end


function lottmapgen.papyrus(x, y, z, area, data, p2data)
	local c_papyrus = minetest.get_content_id("default:papyrus")
	local ph = math.random(0, 3)
	for j = 0, ph do
		local vip = area:index(x, y + j, z)
		data[vip] = c_papyrus
		p2data[vip] = 3
	end
end

function lottmapgen.cactus(x, y, z, area, data)
	local c_cactus = minetest.get_content_id("lottplants:cactus")
	local h = math.random(1, 4)
	for j = -1, h do
		local vic = area:index(x, y + j, z)
		data[vic] = c_cactus
	end
end

function lottmapgen.farming_plants_rare(data, vi, p2data)
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

local basic_flowers = {
	"chrysanthemum_green",
	"dandelion_white",
	"dandelion_yellow",
	"geranium",
	"rose",
	"tulip",
	"violet",
}

function lottmapgen.basic_flowers(data, vi, p2data)
	local rand = math.random(#basic_flowers)
	local c_flower = minetest.get_content_id("lottplants:" .. basic_flowers[rand])
	data[vi] = c_flower
end

local petuniae = {
	"white",
	"pink",
	"blue"
}

function lottmapgen.petuniae(data, vi, p2data)
	local rand = math.random(#petuniae)
	local c_flower = minetest.get_content_id("lottplants:petunia_" .. petuniae[rand])
	data[vi] = c_flower
end

local mountain_flowers = {
	"parnassus",
	"snow_glory",
	"sericea",
}

function lottmapgen.mountain_flowers(data, vi, p2data)
	local rand = math.random(#mountain_flowers)
	local c_flower = minetest.get_content_id("lottplants:" .. mountain_flowers[rand])
	data[vi] = c_flower
end

local desert_flowers = {
	"desert_canaigre",
	"desert_bigelow",
	"desert_plume",
	"desert_phacelia",
	"desert_poppy",
	"desert_star",
}

function lottmapgen.desert_flowers(data, vi, p2data)
	local rand = math.random(#desert_flowers)
	local c_flower = minetest.get_content_id("lottplants:" .. desert_flowers[rand])
	data[vi] = c_flower
end

local gerberae = {
	"orange",
	"red",
	"pink",
	"yellow"
}

function lottmapgen.gerberae(data, vi, p2data)
	local rand = math.random(#gerberae)
	local c_flower = minetest.get_content_id("lottplants:gerbera_" .. gerberae[rand])
	data[vi] = c_flower
end

local shire_flowers = {
	"iris_blue",
	"iris_purple",
	"buttercup",
	"amaryllis_pink",
	"amaryllis_red",
	"amaryllis_white",
	"lilly",
}

function lottmapgen.shire_flowers(data, vi, p2data)
	local rand = math.random(#shire_flowers + 16)
	if rand > #shire_flowers + 5 then
		lottmapgen.basic_flowers(data, vi, p2data)
	elseif rand > #shire_flowers then
		lottmapgen.petuniae(data, vi, p2data)
	else
		local c_flower = minetest.get_content_id("lottplants:" .. shire_flowers[rand])
		data[vi] = c_flower
	end
end


function lottmapgen.generate_log(x, y, z, area, data, p2data, tree, length)
	local c_tree = minetest.get_content_id(tree)
	local c_dirt = minetest.get_content_id("lottitems:dirt")
	local orent = math.random(1, 2)
	for i = 0, length - 1 do
		local vi
		if orent == 1 then
			vi = area:index(x, y, z + i)
		else
			vi = area:index(x + i, y, z)
		end
		data[vi] = c_tree
		if orent == 1 then
			p2data[vi] = 4
		else
			p2data[vi] = 12
		end
	end
	if orent == 1 then
		local vi = area:index(x, y - 1, z + 1)
		data[vi] = c_dirt
	else
		local vi = area:index(x + 1, y - 1, z)
		data[vi] = c_dirt
	end
end

function lottmapgen.generate_bush(x, y, z, area, data, tree, leaves)
	local c_tree = minetest.get_content_id(tree)
	local c_leaves = minetest.get_content_id(leaves)
	for j = -1, 0 do
		if j == 0 then
			for i = -1, 1 do
			for k = -1, 1 do
					if math.abs(i) + math.abs(k) <= 1 then
						local vil = area:index(x + i, y + j + 1, z + k)
						data[vil] = c_leaves
					end
					local vil = area:index(x + i, y + j, z + k)
					data[vil] = c_leaves
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
	if math.random(4) ~= 1 then
		local vi = area:index(x, y + 2, z)
		data[vi] = c_leaves
	end
end

function lottmapgen.generate_tree(x, y, z, area, data, tree, leaves, height, fruit)
	local c_tree = minetest.get_content_id(tree)
	local c_leaves = minetest.get_content_id(leaves)
	local c_fruit = c_leaves
	if fruit then
		c_fruit = minetest.get_content_id(fruit)
	end
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	for j = -2, height do
		if j >= (height - 3) then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				if math.random(48) == 2 then
					if data[vil] == c_air or data[vil] ==  c_ignore then
						data[vil] = c_fruit
					end
				elseif math.random(3) ~= 2 then
					if data[vil] == c_air or data[vil] == c_ignore then
						data[vil] = c_leaves
					end
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen.generate_tall_tree(x, y, z, area, data, tree, leaves)
	local c_tree = minetest.get_content_id(tree)
	local c_leaves = minetest.get_content_id(leaves)
	for j = -3, 15 do
		if j == 7 or j == 11 or j == 15 then
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

function lottmapgen.generate_large_tree(x, y, z, area, data, tree, leaves, height)
	local c_tree = minetest.get_content_id(tree)
        local c_leaves = minetest.get_content_id(leaves)
        for j = -2, height do
                if j >= (height - 4) then
                        local rad = j - height + 4
                        for i = -rad, rad do
                        for k = -rad, rad do
                                if math.abs(i) + math.abs(k) < rad * 2 - 1 then
                                        local vil = area:index(x + i, y + j + 1, z + k)
                                        if math.random(48) == 2 then
                                                data[vil] = c_leaves
                                        elseif math.random(3) ~= 2 then
                                                data[vil] = c_leaves
                                        end
                                end
                        end
                        end
                end
                local vit = area:index(x, y + j, z)
                data[vit] = c_tree
        end
end

function lottmapgen.burned_tree(x, y, z, area, data)
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

function lottmapgen.dead_tree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	for j = -1, math.random(4, 5) do
		local vi = area:index(x, y + j, z)
		data[vi] = c_tree
	end
end

function lottmapgen.frozen_tree(x, y, z, area, data, p2data)
	local c_frozentree = minetest.get_content_id("lottplants:frozentree")
	local c_snow = minetest.get_content_id("default:snow")
	local h = math.random(4, 6)
	for j = -1, h do
		local vi = area:index(x, y + j, z)
		data[vi] = c_frozentree
	end
	local vi = area:index(x, y + h, z)
	data[vi] = c_snow
	p2data[vi] = math.random(100, 200)
end

function lottmapgen.apple_tree(x, y, z, area, data)
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

function lottmapgen.apple_tree2(x, y, z, area, data)
	local c_tree = minetest.get_content_id("lottplants:apple_trunk")
	local c_apple = minetest.get_content_id("default:apple")
	local c_leaves = minetest.get_content_id("lottplants:apple_leaves")
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

function lottmapgen.plum_tree(x, y, z, area, data)
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

function lottmapgen.rowan_tree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("lottplants:rowan_trunk")
	local c_rowanberry = minetest.get_content_id("lottplants:rowanberry")
	local c_rowanleaf = minetest.get_content_id("lottplants:rowan_leaves")
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

function lottmapgen.rowan_bush(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_leaves = minetest.get_content_id("lottplants:rowanleaf")
	local c_berry = minetest.get_content_id("lottplants:rowanberry")
	for j = -1, 0 do
		if j == 0 then
			for i = -1, 1 do
			for k = -1, 1 do
				if math.abs(i) + math.abs(k) <= 1 then
					local vil = area:index(x + i, y + j + 1, z + k)
					if math.random(22) == 2 then
						data[vil] = c_berry
					else
						data[vil] = c_leaves
					end
				end
				vil = area:index(x + i, y + j, z + k)
				if math.random(22) == 2 then
					data[vil] = c_berry
				else
					data[vil] = c_leaves
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
	local vi = area:index(x, y + 2, z)
	data[vi] = c_leaves
end

function lottmapgen.culumalda_tree(x, y, z, area, data)
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

function lottmapgen.yavannamire_tree(x, y, z, area, data)
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

function lottmapgen.default_tree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("lottplants:oak_tree")
	local c_leaves = minetest.get_content_id("lottplants:oak_leaves")
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

function lottmapgen.default_bush(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_leaves = minetest.get_content_id("default:leaves")
	for j = -1, 0 do
		if j == 0 then
			for i = -1, 1 do
			for k = -1, 1 do
				if math.abs(i) + math.abs(k) <= 1 then
					local vil = area:index(x + i, y + j + 1, z + k)
					data[vil] = c_leaves
				end
				local vil = area:index(x + i, y + j, z + k)
				data[vil] = c_leaves
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
	local vi = area:index(x, y + 2, z)
	data[vi] = c_leaves
end

function lottmapgen.alder_tree(x, y, z, area, data)
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

function lottmapgen.lebethron_tree(x, y, z, area, data)
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

function lottmapgen.white_tree(x, y, z, area, data)
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

function lottmapgen.white_bush(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_leaves = minetest.get_content_id("lottplants:whiteleaf")
	for j = -1, 1 do
		if j == 0 or j == 1 then
			for i = -1, 1 do
			for k = -1, 1 do
				if math.abs(i) + math.abs(k) <= 1 and j == 1 then
					local vil = area:index(x + i, y + j + 1, z + k)
					data[vil] = c_leaves
				end
				vil = area:index(x + i, y + j, z + k)
				data[vil] = c_leaves
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
	local vi = area:index(x, y + 3, z)
	data[vi] = c_leaves
end

function lottmapgen.birch_tree(x, y, z, area, data)
	local c_birchtree = minetest.get_content_id("lottplants:birch_trunk")
	local c_birchleaf = minetest.get_content_id("lottplants:birch_leaves")
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

function lottmapgen.birch_bush(x, y, z, area, data)
	local c_tree = minetest.get_content_id("lottplants:birchtree")
	local c_leaves = minetest.get_content_id("lottplants:birchleaf")
	for j = -1, 0 do
		if j == 0 then
			for i = -1, 1 do
			for k = -1, 1 do
					if math.abs(i) + math.abs(k) <= 1 then
						local vil = area:index(x + i, y + j + 1, z + k)
						data[vil] = c_leaves
					end
					vil = area:index(x + i, y + j, z + k)
					data[vil] = c_leaves
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
	local vi = area:index(x, y + 2, z)
	data[vi] = c_leaves
end

function lottmapgen.poplar_tree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("lottplants:poplar_trunk")
	local c_poplarleaf = minetest.get_content_id("lottplants:poplar_leaves")
	for j = -3, 15 do
		if j == 7 or j == 11 or j == 15 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
				if math.random(5) ~= 2 then
					data[vil] = c_poplarleaf
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen.short_elm_tree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("lottplants:elm_trunk")
	local c_elmleaf = minetest.get_content_id("lottplants:elm_leaves")
	for j = -5, 9 do
		if j >= 7 then
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

function lottmapgen.small_mallorn_tree(x, y, z, area, data)
	local c_mallorntree = minetest.get_content_id("lottplants:mallorn_trunk")
	local c_mallornleaf = minetest.get_content_id("lottplants:mallorn_leaves")
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

function lottmapgen.young_mallorn_tree(x, y, z, area, data)
	local c_youngmallorn = minetest.get_content_id("lottplants:young_mallorn_trunk")
	local c_mallornleaf = minetest.get_content_id("lottplants:mallorn_leaves")
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

function lottmapgen.jungle_tree(x, y, z, area, data)
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

function lottmapgen.large_oak_tree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("lottplants:dark_oak_trunk")
	local c_leaves = minetest.get_content_id("lottplants:dark_oak_leaves")
	for j = -3, 7 do
		if j == 5 or j == 6 or j == 7 then
			for i = -(j - 2), j - 2 do
			for k = -(j - 2), j - 2 do
				if math.random(20) ~= 10 and
				math.abs(i) + math.abs(k) < ((j - 2) * 2) - 2 then
					local vil = area:index(x + i, y + j + math.random(1, 2), z + k)
					data[vil] = c_leaves
				end
			end
			end
		end
		if j == 6 then
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

function lottmapgen.pine_tree(x, y, z, area, data, snow)
	local c_pinetree = minetest.get_content_id("lottplants:pine_trunk")
	local c_pineleaf = minetest.get_content_id("lottplants:pine_needles")
	local c_snow = minetest.get_content_id("lottitems:snow_layer")
	if snow == false then
		c_snow = minetest.get_content_id("air")
	end
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

function lottmapgen.pine_bush(x, y, z, area, data)
	local c_pinetree = minetest.get_content_id("lottplants:pinetree")
	local c_pineleaf = minetest.get_content_id("lottplants:pineleaf")
	for j = -1, 0 do
		if j == 0 then
			for i = -1, 1 do
			for k = -1, 1 do
					if math.abs(i) + math.abs(k) <= 1 then
						local vil = area:index(x + i, y + j + 1, z + k)
						data[vil] = c_pineleaf
					end
					vil = area:index(x + i, y + j, z + k)
					data[vil] = c_pineleaf
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_pinetree
	end
	local vi = area:index(x, y + 2, z)
	data[vi] = c_pineleaf
end

function lottmapgen.fir_tree(x, y, z, area, data)
	local c_pinetree = minetest.get_content_id("lottplants:pine_tree")
	local c_firleaf = minetest.get_content_id("lottplants:pine_needles")
	local c_snow = minetest.get_content_id("lottitems:snow_layer")
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

function lottmapgen.oak_tree(x, y, z, area, data)
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

function lottmapgen.holly_tree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("lottplants:holly_trunk")
	local c_hollyleaf = minetest.get_content_id("lottplants:holly_leaves")
	for j = -1, 4 do
		if j >= 0 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j + 1, z + k)
				local abs = math.abs(i) + math.abs(k)
				if j == 4 then
					if abs == 0 then
						data[vil] = c_hollyleaf
					end
				elseif j == 3 then
					if abs <= 1 then
						data[vil] = c_hollyleaf
					end
				elseif j == 2 then
					if abs <= 2 then
						data[vil] = c_hollyleaf
					end
				elseif j <= 1 then
					if abs <= 3 then
						data[vil] = c_hollyleaf
					end
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_tree
	end
end

function lottmapgen.holly_bush(x, y, z, area, data)
	local c_hollyleaf = minetest.get_content_id("lottplants:hollyleaf")
	local c_tree = minetest.get_content_id("default:tree")
	for j = -1, 2 do
		if j >= 0 then
			for i = -1, 1 do
			for k = -1, 1 do
				local vi = area:index(x + i, y + j, z + k)
				if j == 2 then
					if math.abs(i) + math.abs(k) == 1 then
						data[vi] = c_hollyleaf
					end
				else
					data[vi] = c_hollyleaf
				end
			end
			end
		end
		local vi = area:index(x, y + j, z)
		data[vi] = c_tree
	end
	local vi = area:index(x, y + 3, z)
	data[vi] = c_hollyleaf
end

-- Trees Big

function lottmapgen.mallorn_tree(x, y, z, area, data)
	local c_maltree = minetest.get_content_id("lottplants:mallorn_trunk")
	local c_malleaf = minetest.get_content_id("lottplants:mallorn_leaves")
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

function lottmapgen.beech_tree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("lottplants:beech_trunk")
	local c_beechleaf = minetest.get_content_id("lottplants:beech_leaves")
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

function lottmapgen.mirk_tree(x, y, z, area, data)
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

function lottmapgen.jungle_tree(x, y, z, area, data, p2data)
	local c_air = minetest.get_content_id("air")
	local c_jungletree = minetest.get_content_id("default:jungletree")
	local c_jungleleaf = minetest.get_content_id("lottmapgen:jungle_leaves")
	local h = math.random(12, 15)
	for j = -2, h do
		if j >= h-5 and j <= h-2 then
			for i = -3, 3 do
			for k = -3, 3 do
				if math.abs(i) + math.abs(k) ~= 6 then
				if math.random(5) > 2 then
					local vil = area:index(x + i, y + j, z + k)
					if data[vil] == c_air then
						data[vil] = c_jungleleaf
						p2data[vil] = math.random(1,8)
					end
				end
				end
			end
			end
		elseif j == h-6 or j == h-1 then
			for i = -2, 2 do
			for k = -2, 2 do
				if not (i == 0 and j == 0) then
					if math.random(7) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						if data[vil] == c_air then
							data[vil] = c_jungleleaf
							p2data[vil] = math.random(1,8)
						end
					end
				end
			end
			end
		elseif j == h then
			for i = -1, 1 do
			for k = -1, 1 do
				if not (i == 0 and j == 0) then
					if math.random(7) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						if data[vil] == c_air then
							data[vil] = c_jungleleaf
							p2data[vil] = math.random(1,8)
						end
					end
				end
			end
			end
		end
		local vit = area:index(x, y + j, z)
		data[vit] = c_jungletree
	end
	local vil = area:index(x, y + h + 1, z)
	data[vil] = c_jungleleaf
	p2data[vil] = math.random(1,8)
end

function lottmapgen.great_oak_tree(x, y, z, area, data, p2data)
	local c_air = minetest.get_content_id("air")
	local c_jungletree = minetest.get_content_id("lottplants:oak_trunk")
	local c_jungleleaf = minetest.get_content_id("lottplants:oak_leaves")
	local h = math.random(20, 27)
	local lf = math.random(9, 14)
	for j = -2, h do
		if j >= h-5 and j <= h - 1 then
			for i = -6, 7 do
			for k = -6, 7 do
				if math.abs(i) + math.abs(k) < 10 then
					if math.random(5) > 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = c_jungleleaf
					end
				end
			end
			end
			if j == h - 2 then
				for i = -5, 6 do
				for k = 0, 1 do
					local vil = area:index(x + i, y + j, z + k)
					data[vil] = c_jungletree
					vil = area:index(x + k, y + j, z + i)
					data[vil] = c_jungletree
				end
				end
			elseif j == h - 4 then
				for i = -3, 4 do
					local vil = area:index(x + i, y + j, z + i)
					data[vil] = c_jungletree
					vil = area:index(x + 1 - i, y + j, z + i)
					data[vil] = c_jungletree
				end
			end
		elseif j == h - 6 then
			for i = -4, 5 do
			for k = -4, 5 do
				if math.abs(i) + math.abs(k) < 8 then
					if math.random(5) > 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = c_jungleleaf
					end
				end
			end
			end
		elseif j == h then
			for i = -5, 6 do
			for k = -5, 6 do
				if math.abs(i) + math.abs(k) < 7 then
					if math.random(5) > 1 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = c_jungleleaf
					end
				end
			end
			end
			for i = -2, 3 do
			for k = -2, 3 do
				if math.abs(i) + math.abs(k) < 7 then
					if math.random(5) > 1 then
						local vil = area:index(x + i, y + j + 1, z + k)
						data[vil] = c_jungleleaf
					end
				end
			end
			end
		elseif j == h - lf then
			for i = -2, 3 do
			for k = -2, 3 do
			for l = -1, 1 do
				if math.abs(i) + math.abs(k) < 5 then
					if math.random(5) > 2 then
						local vil = area:index(x + i, y + j + l, z + k)
						data[vil] = c_jungleleaf
					end
				end
			end
			end
			end
		end
		if j ~= h then
			for i = 0, 1 do
			for k = 0, 1 do
				local vit = area:index(x + i, y + j, z + k)
				data[vit] = c_jungletree
			end
			end
		end
	end
end

function lottmapgen.jungle_bush(x, y, z, area, data, p2data)
	local c_air = minetest.get_content_id("air")
	local c_jungletree = minetest.get_content_id("default:jungletree")
	local c_jungleleaf = minetest.get_content_id("lottmapgen:jungle_leaves")
	local vi = area:index(x, y, z)
	data[vi] = c_jungletree
	for i = -1, 1 do
	for k = -1, 1 do
		if math.random(6) >= 4 then
			vi = area:index(x + i, y, z + k)
			if data[vi] == c_air then
				data[vi] = c_jungletree
			end
		end
	end
	end
	for i = -3, 4 do
	for j = 0, 1 do
	for k = -4, 3 do
		if math.abs(i) + math.abs(j) + math.abs(k) < 5 then
			if math.random(5) > 2 then
				vi = area:index(x + i, y + j, z + k)
				if data[vi] == c_air then
					data[vi] = c_jungleleaf
					p2data[vi] = math.random(1,8)
				end
			end
		end
	end
	end
	end
end

function lottmapgen.rock(x, y, z, area, data, stone, snow)
	local c_stone = minetest.get_content_id("lottitems:stone")
	if stone then
		c_stone = minetest.get_content_id(stone)
	end
	local c_snow = minetest.get_content_id("lottitems:snow_layer")
	local c_air = minetest.get_content_id("air")
	local r = math.random(1, 3)
	for i = -2, 2 do
	for k = -2, 2 do
	for j = 0, r do
		if math.random(math.abs(i) + j + math.abs(k)) <= 1 then
			local viu = area:index(x + i, y + j - 1, z + k)
			if data[viu] ~= c_air and data[viu] ~= c_snow then
				local vi = area:index(x + i, y + j, z + k)
				data[vi] = c_stone
				if j == 0 then
					local viu = area:index(x + i, y + j - 1, z + k)
					data[viu] = c_stone
				end
			end
		end
	end
	if snow then
		for j = r, 0, -1 do
			local vi = area:index(x + i, y + j, z + k)
			if data[vi] == c_stone then
				local via = area:index(x + i, y + j + 1, z + k)
				data[via] = c_snow
				break
			end
		end
	end
	end
	end
end

function lottmapgen.elf_workshop(x, y, z, area, data, p2data)
	local c_stonebrick = minetest.get_content_id("default:stonebrick")
	local c_cracked_stonebrick = minetest.get_content_id("default:cracked_stonebrick")
	local c_marblebrick = minetest.get_content_id("lottblocks:marble_brick")
	local c_elftorch = minetest.get_content_id("lottblocks:elf_torch")
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
					data[vi] = c_elftorch
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

