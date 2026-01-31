function init_player()
	player = {
		x = 0,
		y = 0,
	}
end

function update_player()
	if btn(0) then
		player.x = max(player.x - 1, 0)
	end
	if btn(1) then
		player.x = min(player.x + 1, 240)
	end
	if btn(2) then
		player.y = max(player.y - 1, 0)
	end
	if btn(3) then
		player.y = min(player.y + 1, 224)
	end
end

function draw_player()
	spr(64, player.x, player.y, 2, 4)
end