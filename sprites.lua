

function init_sprites()
	sprites = {
		player_front = sprite(64, 2, 4, 8, 32),
		player_side = sprite(66, 2, 4, 8, 32),
		player_back = sprite(68, 2, 4, 8, 32),
		guest_body = sprite(32, 2, 2, 8, 16),
		guest1 = sprite(0, 2, 2, 4, 16),
		guest2 = sprite(2, 2, 2, 8, 16),
		guest3 = sprite(4, 2, 2, 4, 16),
		guest4 = sprite(6, 2, 2, 8, 16),
		guest5 = sprite(8, 2, 2, 4, 16),
		guest6 = sprite(10, 2, 2, 8, 16),
		guest7 = sprite(12, 2, 2, 4, 16),
		guest8 = sprite(14, 2, 2, 8, 16),
		wall_corner = sprite(128, 1, 2, 0, 16),
		wall_edge_h = sprite(129, 1, 2, 0, 16),
		wall_edge_v = sprite(160, 1, 1, 0, 0),
		floor = adv_sprite(function(x, y)
				spr(78, x, y, 2, 2)
			end),

		carpet = adv_sprite(function(x, y, flip_x, flip_y)
				sspr(51, 64, 16, 16, x, y, 16, 16, flip_x, flip_y)
			end),

		body = adv_sprite(function(x, y)
				sspr(16, 64, 11, 16, x, y)
			end),
		body2 = adv_sprite(function(x, y)
			sspr(8, 80, 10, 16, x, y)
			end),
		body3 = adv_sprite(function(x, y)
				sspr(18, 80, 14, 16, x, y)
			end),
		body4 = adv_sprite(function(x, y)
				sspr(44, 80, 13, 16, x, y)
			end),


		small_ghost_neutral = adv_sprite(function(x, y)
				sspr(42, 32, 12, 16, x, y)
			end),
		small_unicorn = adv_sprite(function(x, y)
				sspr(56, 32, 15, 16, x, y + 1)
			end),
		small_alien = adv_sprite(function(x, y)
				sspr(71, 32, 12, 16, x - 1, y + 1)
			end),
		small_horse = adv_sprite(function(x, y)
				sspr(83, 32, 16, 16, x, y)
			end),
		small_ghost_move = adv_sprite(function(x, y, flip)
				local w,h = 13, 16
				if flip == nil then flip = false end
				sspr(99, 32, w, h, x, y, w, h, flip, false)
			end),
		small_croc = adv_sprite(function(x, y)
				sspr(0, 53, 16, 11, x, y + 5)
			end),
		small_doctor = adv_sprite(function(x, y)
				sspr(22, 53, 15, 10, x - 6, y + 6)
			end),
		small_headless = adv_sprite(function(x, y)
				-- rotate(38, 51, 2, x, y, 4, 13)
				sspr(48, 19, 13, 4, x - 2, y + 12)
			end),
		small_lion = adv_sprite(function(x, y)
				sspr(44, 49, 14, 15, x - 3, y + 2)
			end),
		small_cat = adv_sprite(function(x, y)
				sspr(59, 50, 12, 14, x - 1, y + 2)
			end),
		small_pig = adv_sprite(function(x, y)
				sspr(71, 50, 14, 14, x - 3, y + 2)
			end),
		small_blackbeard = adv_sprite(function(x, y)
				sspr(85, 48, 16, 16, x - 4, y + 2)
			end),
		small_police = adv_sprite(function(x, y)
				sspr(101, 48, 14, 14, x - 2, y + 2)
			end),
		small_goblin = adv_sprite(function(x, y)
				sspr(115, 48, 13, 12, x - 2, y + 4)
			end),
	}
end


function draw_small_ghost(x, y)
	sprites.small_ghost_neutral.func(x, y)
end

function draw_small_unicorn(x, y)
	sprites.body.func(x, y)
	sprites.small_unicorn.func(x + 1, y - 16)
end

function reset_palette()
	pal()

	-- pal(0, 0, 1)
	-- pal(1, 1, 1)
	-- pal(2, 130, 1)
	-- pal(3, 3, 1)
	-- pal(4, 4, 1)
	-- pal(5, 8, 1)
	-- pal(6, 131, 1)
	-- pal(7, 7, 1)
	-- pal(8, 135, 1)
	-- pal(9, 139, 1)
	-- pal(10, 10, 1)
	-- pal(11, 143, 1)
	-- pal(12, 142, 1)
	-- pal(13, 13, 1)
	-- pal(14, 136, 1)
	-- pal(15, 15, 1)

	pal(0,    0, 1)
	pal(1,    1, 1)
	pal(2,  130, 1)
	pal(3,    3, 1)
	pal(4,    4, 1)
	pal(5,  131, 1)
	pal(6,  135, 1)
	pal(7,    7, 1)
	pal(8,    8, 1)
	pal(9,  142, 1)
	pal(10,  10, 1)
	pal(11, 139, 1)
	pal(12, 136, 1)
	pal(13,  13, 1)
	pal(14, 143, 1)
	pal(15,  15, 1)

	palt(0, false)
	palt(13, true)
end


function sprite(id, w, h, ox, oy)
	return {
		kind = "basic",
		id = id,
		w = w,
		h = h,
		ox = ox,
		oy = oy,
	}
end


function adv_sprite(func)
	return {
		kind = "advanced",
		func = func,
	}
end


function draw_sprite(sprite, x, y, flip_x, flip_y)
	if type(sprite) == "function" then
		sprite(x, y, flip_x, flip_y)
	elseif sprite.kind == "basic" then
		if flip_x == nil then flip_x = false end
		if flip_y == nil then flip_y = false end
		spr(sprite.id, x - sprite.ox, y - sprite.oy, sprite.w, sprite.h, flip_x, flip_y)
	elseif sprite.kind == "advanced" then
		sprite.func(x, y, flip_x, flip_y)
	end
end


-- mode 0: clockwise 90
-- mode 1: clockwise 270
-- mode 2: mirror + clockwise 90
-- mode 3: mirror + clockwise 270
-- dx,dy: screen position
-- function rotate(sprite,mode,dx,dy,w,h)
function rotate(sprite_x_px, sprite_y_px,mode,dx,dy,w_px,h_px)
	local sx=sprite_x_px
	local sy=sprite_y_px
	w,h=w_px,h_px
	local ya,yb,xa,xb=0,1,0,1
	if mode==0 then
		ya,yb=h,-1
	elseif mode==1 then
		xa,xb=w,-1
	elseif mode==2 then
		ya,yb,xa,xb=h,-1,w,-1
	end
	for y=0,h do
		for x=0,w do
			pset((y-ya)*yb+dx,(x-xa)*xb+dy,sget(x+sx,y+sy))
		end
	end
end

-- function draw_rotated_anticlockwise_px(x, y, w_px, h_px, map_x, map_y, flip_y)
-- 	if (flip_y == nil) flip_y = false

-- 	for i = 0, h_px do
-- 		local map_y_idx = flip_y and (h_px - i)/8 or i/8
-- 		tline(
-- 			x + i, (y + w_px),
-- 			x + i, (y + w_px) - w_px,
-- 			map_x, map_y + map_y_idx
-- 		)
-- 	end
-- end

-- function draw_rotated_anticlockwise(x, y, w_tiles, h_tiles, map_x, map_y, flip_y)
-- 	if (flip_y == nil) flip_y = false

-- 	local w_px = w_tiles * 8 - 1
-- 	local h_px = h_tiles * 8 - 1

-- 	for i = 0, h_px do
-- 		local map_y_idx = flip_y and (h_px - i)/8 or i/8
-- 		tline(
-- 			x + i, (y + w_px),
-- 			x + i, (y + w_px) - w_px,
-- 			map_x, map_y + map_y_idx
-- 		)
-- 	end
-- end


-- function draw_rotated_clockwise(x, y, w_tiles, h_tiles, map_x, map_y, flip_y)
-- 	if (flip_y == nil) flip_y = false

-- 	local w_px = w_tiles * 8 - 1
-- 	local h_px = h_tiles * 8 - 1

-- 	for i = 0, h_px do
-- 		local map_y_idx = flip_y and (h_px - i)/8 or i/8
-- 		tline(
-- 			x + i, y,
-- 			x + i, y + w_px,
-- 			map_x, map_y + map_y_idx
-- 		)
-- 	end
-- end
