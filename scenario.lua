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
	interaction = nil
end


function get_interaction()
	if saying then
		return nil
	end
	local closest
	local closest_dist = 999
	for _, guest in ipairs(scenario.guests) do
		-- Feels odd talking to people from behind.
		if player.y > guest.y then
			local dist = funnysqdist(guest.x, guest.y, player.x, player.y)
			if dist < closest_dist then
				closest = guest
				closest_dist = dist
			end
		end
	end
	if closest_dist < 0.15 then
		return closest
	end
end


function update_interaction()
	interaction = get_interaction()
	printh(interaction)

	if interaction and btnp(4) then
		say(interaction.dialogue)
		interaction = nil
	end
end


function draw_interaction_prompt()
	if interaction then
		color(0)
		print_centered("❎ talk        🅾️ accuse", 117)
		color(7)
		print_centered("❎ talk        🅾️ accuse", 116)
	end
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
