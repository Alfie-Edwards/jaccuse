function init_mouse()
	poke(0x5F2D, 1)
	update_mouse()
end

function update_mouse()
	local down_last = mouse ~= nil and mouse.down
	local down = (stat(34) & 1) != 0
	mouse = {
		x = stat(32) - 1,
		y = stat(33) - 1,
		pressed = (down and not down_last),
		released = (down_last and not down),
		down = down,
	}
end

function draw_mouse()
    color(1)
    circfill(mouse.x, mouse.y, 1)
end