function init_player()
	player = {
		x = 128,
		y = 255,
	}
end

function update_player()
	if not saying then
		if btn(0) then
			player.x = max(player.x - 1, 0)
		end
		if btn(1) then
			player.x = min(player.x + 1, 255)
		end
		if btn(2) then
			player.y = max(player.y - 1, 0)
		end
		if btn(3) then
			player.y = min(player.y + 1, 255)
		end
	end
end

function draw_player()
	draw_sprite(sprites.player, player.x, player.y)
end