
-- Player stats and animations
local player_model = {}
local player_textures = {}
local player_anim = {}
local player_sneak = {}
lottplayer.player_attached = {}

-- Standard animations.
local animations = {
	-- Standard animations.
	stand     			= { x=  0, y= 79, },
	lay       			= { x=162, y=166, },
	walk      			= { x=168, y=187, },
	mine      			= { x=189, y=198, },
	walk_mine 			= { x=200, y=219, },
	sit       			= { x= 81, y=160, },
	-- Extra animations
	sneak_static		= { x=221, y= 260, },
	sneak				= { x=262, y= 301, },
	sneak_mine			= { x=303, y= 342, },
	sneak_static_mine	= { x=344, y= 383, },
		
	sneak_shield_static		 = { x=385, y= 424, },
	sneak_shield			 = { x=426, y= 465, },
	sneak_shield_mine		 = { x=467, y= 506, },
	sneak_shield_static_mine = { x=508, y= 547, },
		
	crawl				= { x=549, y= 588, },
	crawl_static		= { x=590, y= 629, },
		
	fly					= { x=631, y= 710, },
	fly_mine			= { x=712, y= 791, },
		
	ride_static			= { x=793, y= 832, },
	ride_static_mine	= { x=884, y= 873, },
	ride				= { x=875, y= 914, },
	ride_mine			= { x=916, y= 955, },
		
	swim				= { x=957, y= 996, },
	swim_static			= { x=998, y= 1037, },
	swim_mine			= { x=1039, y= 1078, },
	swim_static_mine	= { x=1080, y= 1119, },
		
	-- Bow Animations
	stand_bow					= { x=1150, y=1159, },
	walk_bow					= { x=1161, y=1180, },
	sneak_bow					= { x=1182, y=1221, },
	sneak_static_bow			= { x=1223, y=1262, },
	sneak_shield_bow			= { x=1264, y=1303, },
	sneak_shield_static_bow		= { x=1305, y=1344, },
	fly_bow						= { x=1346, y=1425, },
	ride_static_bow				= { x=1427, y=1466, },
	ride_bow					= { x=1468, y=1507, },
	swim_bow					= { x=1509, y=1548, },
	
	-- == Looking up ==
	u_stand     			= { x=2000, y=2079, },
	u_lay       			= { x=2162, y=2166, },
	u_walk      			= { x=2168, y=2187, },
	u_mine      			= { x=2189, y=2198, },
	u_walk_mine 			= { x=2200, y=2219, },
	u_sit       			= { x=2081, y=2160, },
	-- Extra animations
	u_sneak_static		= { x=2221, y= 2260, },
	u_sneak				= { x=2262, y= 2301, },
	u_sneak_mine			= { x=2303, y= 2342, },
	u_sneak_static_mine	= { x=2344, y= 2383, },
		
	u_sneak_shield_static		 = { x=2385, y= 2424, },
	u_sneak_shield			 = { x=2426, y= 2465, },
	u_sneak_shield_mine		 = { x=2467, y= 2506, },
	u_sneak_shield_static_mine = { x=2508, y= 2547, },
		
	u_crawl				= { x=2549, y= 2588, },
	u_crawl_static		= { x=2590, y= 2629, },
		
	u_fly					= { x=2631, y= 2710, },
	u_fly_mine			= { x=2712, y= 2791, },
		
	u_ride_static			= { x=2793, y= 2832, },
	u_ride_static_mine	= { x=2884, y= 2873, },
	u_ride				= { x=2875, y= 2914, },
	u_ride_mine			= { x=2916, y= 2955, },
		
	u_swim				= { x=2957, y= 2996, },
	u_swim_static			= { x=2998, y= 3037, },
	u_swim_mine			= { x=3039, y= 3078, },
	u_swim_static_mine	= { x=3080, y= 3119, },
		
	-- Bow Animations
	u_stand_bow					= { x=3150, y=3159, },
	u_walk_bow					= { x=3161, y=3180, },
	u_sneak_bow					= { x=3182, y=3221, },
	u_sneak_static_bow			= { x=3223, y=3262, },
	u_sneak_shield_bow			= { x=3264, y=3303, },
	u_sneak_shield_static_bow		= { x=3305, y=3344, },
	u_fly_bow						= { x=3346, y=3425, },
	u_ride_static_bow				= { x=3427, y=3466, },
	u_ride_bow					= { x=3468, y=3507, },
	u_swim_bow					= { x=3509, y=3548, },
	
	-- == Looking down ==
	d_stand     			= { x=4000, y=4079, },
	d_lay       			= { x=4162, y=4166, },
	d_walk      			= { x=4168, y=4187, },
	d_mine      			= { x=4189, y=4198, },
	d_walk_mine 			= { x=4200, y=4219, },
	d_sit       			= { x=4081, y=4160, },
	-- Extra animations
	d_sneak_static		= { x=4221, y= 4260, },
	d_sneak				= { x=4262, y= 4301, },
	d_sneak_mine			= { x=4303, y= 4342, },
	d_sneak_static_mine	= { x=4344, y= 4383, },
		
	d_sneak_shield_static		 = { x=4385, y= 4424, },
	d_sneak_shield			 = { x=4426, y= 4465, },
	d_sneak_shield_mine		 = { x=4467, y= 4506, },
	d_sneak_shield_static_mine = { x=4508, y= 4547, },
		
	d_crawl				= { x=4549, y= 4588, },
	d_crawl_static		= { x=4590, y= 4629, },
		
	d_fly					= { x=4631, y= 4710, },
	d_fly_mine			= { x=4712, y= 4791, },
		
	d_ride_static			= { x=4793, y= 4832, },
	d_ride_static_mine	= { x=4884, y= 4873, },
	d_ride				= { x=4875, y= 4914, },
	d_ride_mine			= { x=4916, y= 4955, },
	
	d_swim				= { x=4957, y= 4996, },
	d_swim_static			= { x=4998, y= 5037, },
	d_swim_mine			= { x=5039, y= 5078, },
	d_swim_static_mine	= { x=5080, y= 5119, },
	
	-- Bow Animations
	d_stand_bow					= { x=5150, y=5159, },
	d_walk_bow					= { x=5161, y=5180, },
	d_sneak_bow					= { x=5182, y=5221, },
	d_sneak_static_bow			= { x=5223, y=5262, },
	d_sneak_shield_bow			= { x=5264, y=5303, },
	d_sneak_shield_static_bow		= { x=5305, y=5344, },
	d_fly_bow						= { x=5346, y=5425, },
	d_ride_static_bow				= { x=5427, y=5466, },
	d_ride_bow					= { x=5468, y=5507, },
	d_swim_bow					= { x=5509, y=5548, },
}

function lottplayer.set_animation(player, anim_name, speed)
	local name = player:get_player_name()
	if player_anim[name] == anim_name then
		return
	end
	player_anim[name] = anim_name
	player:set_animation(animations[anim_name], speed or 30, 0)
end

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player_model[name] = nil
	player_anim[name] = nil
	player_textures[name] = nil
end)

-- Localize for better performance.
local player_set_animation = lottplayer.set_animation
local player_attached = lottplayer.player_attached

local function is_flying(player)
	local ppos = player:get_pos()
	local name = player:get_player_name()
	if minetest.check_player_privs(name, {fly = true}) and
		minetest.get_node({x=ppos.x, y=ppos.y-1, z=ppos.z}).name == "air" and
		minetest.get_node({x=ppos.x, y=ppos.y-2, z=ppos.z}).name == "air" then
		return true
	end
end

local math_deg = math.deg
local function get_pitch_deg(player)
	return math_deg(player:get_look_vertical())
end

pitchmod = {}
-- Check each player and apply animations
minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local meta = player:get_meta()
		if not player_attached[name] then
			local controls = player:get_player_control()
			local walking = false
			local animation_speed_mod = 30
			
			-- Determine whether player is looking up or down
			if tonumber(get_pitch_deg(player)) > 50 then
				pitchmod[name] = "d_"
			elseif tonumber(get_pitch_deg(player)) < -50 then
				pitchmod[name] = "u_"
			else pitchmod[name] = ""
			end
			
			-- Apply animations based on what the player is doing
			local bow_active = meta:get_string("lott:bow_state")
			if player:get_hp() == 0 then
				player_set_animation(player, "lay")
				
			-- Swimming
			elseif minetest.get_node(player:get_pos()).name == "default:water_source" then
				if bow_active ~= "" then
					player_set_animation(player, pitchmod[name].."swim_bow", animation_speed_mod)
				elseif controls.up or controls.down or controls.left or controls.right then
					if controls.LMB then
						player_set_animation(player, pitchmod[name].."swim_mine", animation_speed_mod)
					else
						player_set_animation(player, pitchmod[name].."swim", animation_speed_mod)
					end
				else
					if controls.LMB then
						player_set_animation(player, pitchmod[name].."swim_static_mine", animation_speed_mod)
					else
						player_set_animation(player, pitchmod[name].."swim_static", animation_speed_mod)
					end
				end
			-- Flying
			elseif is_flying(player) then
				if bow_active ~= "" then
					player_set_animation(player, pitchmod[name].."fly_bow", animation_speed_mod)
				elseif controls.LMB then
					player_set_animation(player, pitchmod[name].."fly_mine", animation_speed_mod)
				else
					player_set_animation(player, pitchmod[name].."fly", animation_speed_mod)
				end
			elseif controls.sneak then
				local shield_active = meta:get_string("lott:shield_state")
				-- Crawling
				if controls.aux1 then
					if controls.up or controls.down or controls.left or controls.right then
						player_set_animation(player, pitchmod[name].."crawl", animation_speed_mod)
					else
						player_set_animation(player, pitchmod[name].."crawl_static", animation_speed_mod)
					end
				-- Sneaking
				elseif controls.up or controls.down or controls.left or controls.right then
					if bow_active ~= "" then
						if shield_active ~= "" then
							player_set_animation(player, pitchmod[name].."sneak_shield_bow", animation_speed_mod)
						else
							player_set_animation(player, pitchmod[name].."sneak_bow", animation_speed_mod)
						end
					elseif controls.LMB then
						if shield_active ~= "" then
							player_set_animation(player, pitchmod[name].."sneak_shield_mine", animation_speed_mod)
						else
							player_set_animation(player, pitchmod[name].."sneak_mine", animation_speed_mod)
						end
					else
						if shield_active ~= "" then
							player_set_animation(player, pitchmod[name].."sneak_shield", animation_speed_mod)
						else
							player_set_animation(player, pitchmod[name].."sneak", animation_speed_mod)
						end
					end
				elseif bow_active ~= "" then
					if shield_active ~= "" then
						player_set_animation(player, pitchmod[name].."sneak_shield_static_bow", animation_speed_mod)
					else
						player_set_animation(player, pitchmod[name].."sneak_static_bow", animation_speed_mod)
					end
				elseif controls.LMB then
					if shield_active ~= "" then
						player_set_animation(player, pitchmod[name].."sneak_shield_static_mine", animation_speed_mod)
					else
						player_set_animation(player, pitchmod[name].."sneak_static_mine", animation_speed_mod)
					end
				else
					if shield_active ~= "" then
						player_set_animation(player, pitchmod[name].."sneak_shield_static", animation_speed_mod)
					else
						player_set_animation(player, pitchmod[name].."sneak_static", animation_speed_mod)
					end
				end
			-- Walking/Standing
			else
				if controls.up or controls.down or controls.left or controls.right then
					if bow_active ~= "" then
						player_set_animation(player, pitchmod[name].."walk_bow", animation_speed_mod)
					elseif controls.LMB then
						player_set_animation(player, pitchmod[name].."walk_mine", animation_speed_mod)
					else
						player_set_animation(player, pitchmod[name].."walk", animation_speed_mod)
					end
				elseif bow_active ~= "" then
					player_set_animation(player, pitchmod[name].."stand_bow", 5)
				elseif controls.LMB then
					player_set_animation(player, pitchmod[name].."mine", animation_speed_mod)
				else
					player_set_animation(player, pitchmod[name].."stand", animation_speed_mod)
				end
			end
		end
	end
end)

-- Function to set a player's skin, texture, etc. based on their race.
function lottplayer.set_player_props(race, player)
	local name = player:get_player_name()
	lottplayer.player_attached[name] = false
	lottplayer.textures[name] = {"blank.png", "blank.png", "blank.png", "lottplayer_" .. lottplayer.races[race][1] .. ".png", "blank.png", "blank.png" , "blank.png"},
	player:set_properties({
		physical = true,
		collides_with_objects = true,
		mesh = "character.b3d",
		textures = {"blank.png", "blank.png", "blank.png", "lottplayer_" .. lottplayer.races[race][1] .. ".png", "blank.png", "blank.png" , "blank.png"},
		visual = "mesh",
		hp_max = lottplayer.races[race][3],
		eye_height = lottplayer.races[race][4],
		can_zoom = lottplayer.races[race][5],
		collisionbox = lottplayer.races[race][6],
		nametag_color = lottplayer.races[race][7],
		visual_size = lottplayer.races[race][9],
		is_visible = true,
	})
	
end

-- Set the player's appearance and characteristics on join
minetest.register_on_joinplayer(function(player)
	player:set_attribute("lottplayer:clouds_changing", "false")
	player:hud_set_hotbar_image("gui_hotbar.png")
	player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
	local race = player:get_attribute("race")
	if not race or race == "" then
		player:set_properties({
			textures = {"blank.png", "blank.png"},
			is_visible = false
		})
		return
	end
	race = tonumber(race)
	lottplayer.set_player_props(race, player)
	local meta = player:get_meta()
	meta:set_string("lott:bow_state", true)
end)

-- Changing races
minetest.register_chatcommand("race", {
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local meta = player:get_meta()
		local race = tonumber(param)
		player:set_attribute("race", race)
		lottplayer.set_player_props(race, player)
		player:set_hp(lottplayer.races[race][3])
	end,
})