

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
		wall_corner = sprite(222, 1, 2, 0, 16),
		wall_edge_h = sprite(223, 1, 2, 0, 16),
		wall_edge_v = sprite(254, 1, 1, 0, 0),
		floor = sprite(255, 1, 1, 0, 0),
	}
end


function reset_palette()
	
end


function sprite(id, w, h, ox, oy)
	return {
		type = "basic",
		id = id,
		w = w,
		h = h,
		ox = ox,
		oy = oy,
	}
end


function adv_sprite(func)
	return {
		type = "advanced",
		func = func,
	}
end


function draw_sprite(sprite, x, y, flip_x, flip_y)
	if sprite.type == "basic" then
		if flip_x == nil then flip_x = false end
		if flip_y == nil then flip_y = false end
		spr(sprite.id, x - sprite.ox, y - sprite.oy, sprite.w, sprite.h, flip_x, flip_y)
	elseif sprite.type == "advanced" then
		sprite.func(x, y)
	end
end


function draw_rotated_anticlockwise(x, y, w_tiles, h_tiles, map_x, map_y, flip_y)
	if (flip_y == nil) flip_y = false

	local w_px = w_tiles * 8 - 1
	local h_px = h_tiles * 8 - 1

	for i = 0, h_px do
		local map_y_idx = flip_y and (h_px - i)/8 or i/8
		tline(
			x + i, (y + w_px),
			x + i, (y + w_px) - w_px,
			map_x, map_y + map_y_idx
		)
	end
end


function draw_rotated_clockwise(x, y, w_tiles, h_tiles, map_x, map_y, flip_y)
	if (flip_y == nil) flip_y = false

	local w_px = w_tiles * 8 - 1
	local h_px = h_tiles * 8 - 1

	for i = 0, h_px do
		local map_y_idx = flip_y and (h_px - i)/8 or i/8
		tline(
			x + i, y,
			x + i, y + w_px,
			map_x, map_y + map_y_idx
		)
	end
end
