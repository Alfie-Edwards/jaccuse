main = {
	guilty = 1,
	guests = {
		{
			x = 10,
			y = 200,
			sprite = 0,
			head_x_offset = 4,
			dialogue = "Hello my name is a",
		},
		{
			x = 10,
			y = 10,
			sprite = 2,
			dialogue = "Hello my name is b",
		},
		{
			x = 50,
			y = 15,
			sprite = 4,
			head_x_offset = 4,
			dialogue = "Hello my name is c",
		},
		{
			x = 80,
			y = 12,
			sprite = 6,
			dialogue = "Hello my name is d",
		},
		{
			x = 200,
			y = 200,
			sprite = 8,
			head_x_offset = 4,
			dialogue = "Hello my name is e",
		},
		{
			x = 100,
			y = 230,
			sprite = 10,
			dialogue = "Hello my name is f",
		},
		{
			x = 120,
			y = 230,
			sprite = 12,
			head_x_offset = 4,
			dialogue = "Hello my name is g",
		},
		{
			x = 70,
			y = 90,
			sprite = 14,
			dialogue = "Hello my name is h",
		}
	}
}

function init_scenario()
	scenario = main
end

function draw_characters()
	for _, guest in ipairs(scenario.guests) do
		local head_x = guest.x
		if guest.head_x_offset ~= nil then
			head_x += guest.head_x_offset
		end
		spr(guest.sprite, head_x - 8, guest.y - 32, 2, 2)
		spr(sprites.guest_body, guest.x - 8, guest.y - 16, 2, 2)
	end
end
