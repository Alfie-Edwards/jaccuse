direction = {
	up = "up",
	down = "down",
	left = "left",
	right = "right",
}

input_map = {
	[0] = direction.left,
	[1] = direction.right,
	[2] = direction.up,
	[3] = direction.down
}

function init_player()
	player = {
		x = room.w / 2,
		y = room.h - 1,

		max_speed = 1,

		questions_remaining = maximum_questions,

		talking_to = nil,  -- nil|{guest=(table),idx=(int)}

		seen_clues = {},  -- {guest name (str): list of clues (strs)}

		dir = direction.down,
		last_started_pressing = {
			up = 0,
			down = 0,
			left = 0,
			right = 0,
		},
		last_released = direction.down,
	}
end

function choose_question()
	player.questions_remaining -= 1
	if player.questions_remaining < 0 then
		-- TODO #finish
		printh("you lose!!!")
	end
end

function move(dir)
	local offset = { x=0, y=0 }
	if dir == direction.up then
		offset.y = -player.max_speed
	elseif dir == direction.down then
		offset.y = player.max_speed
	elseif dir == direction.left then
		offset.x = -player.max_speed
	elseif dir == direction.right then
		offset.x = player.max_speed
	else
		assert(false == "unexpected direction "..dir)
	end

	if player.last_started_pressing[dir] == 0 then
		player.last_started_pressing[dir] = time()
	end

	player.x = min(max(player.x + offset.x, 0), room.w - 1)
	player.y = min(max(player.y + offset.y, 0), room.h - 1)
end

function stop_moving(dir)
	if player.last_started_pressing[dir] ~= 0 then
		player.last_released = dir
	end
	player.last_started_pressing[dir] = 0
end

function update_player()
	if player.talking_to == nil and not clues_open then
		-- moving
		for b,d in pairs(input_map) do
			if btn(b) then
				move(d)
			else
				stop_moving(d)
			end
		end

		local visual_direction = player.last_released
		for d,t in pairs(player.last_started_pressing) do
			if t > player.last_started_pressing[visual_direction] then
				visual_direction = d
			end
		end
		player.dir = visual_direction
	elseif not saying and player.talking_to ~= nil then
		-- talking (and have run out of submitted dialogue, so advance it)
		player.talking_to.idx += 1
		if not say_idx(player.talking_to.guest, player.talking_to.idx) then
			player.talking_to = nil
		end
	end
end

function draw_player()
	local flip = false
	local sprite = nil
	if player.dir == direction.up then
		sprite = sprites.player_back
	elseif player.dir == direction.down then
		sprite = sprites.player_front
	elseif player.dir == direction.left then
		sprite = sprites.player_side
	elseif player.dir == direction.right then
		sprite = sprites.player_side
		flip = true
	else
		assert(false == "unexpected direction "..player.dir)
	end
	assert(sprite ~= nil)

	draw_sprite(sprite, player.x, player.y, flip)
end