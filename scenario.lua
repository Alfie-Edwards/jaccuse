function init_scenario()
	main = {
		guilty = 1,
		guests = {
			{
				x = 10,
				y = 200,
				sprite = sprites.guest1,
				dialogue = {"Hello my name is a", "I like eating toast"},
			},
			{
				x = 10,
				y = 10,
				sprite = sprites.guest2,
				dialogue = {"Hello my name is b", "This week I have been mostly eating taramasalata"},
			},
			{
				x = 50,
				y = 15,
				sprite = sprites.guest3,
				dialogue = {"Hello my name is c"},
			},
			{
				x = 80,
				y = 12,
				sprite = sprites.guest4,
				dialogue = {"Hello my name is d"},
			},
			{
				x = 200,
				y = 200,
				sprite = sprites.guest5,
				dialogue = {"Hello my name is e"},
			},
			{
				x = 100,
				y = 230,
				sprite = sprites.guest6,
				dialogue = {"Hello my name is f"},
			},
			{
				x = 120,
				y = 230,
				sprite = sprites.guest7,
				dialogue = {"Hello my name is g"},
			},
			{
				x = 70,
				y = 90,
				sprite = sprites.guest8,
				dialogue = {"Hello my name is h"},
			}
		}
	}

	scenario = main
	interaction = nil
	for _,g in ipairs(main.guests) do
		g.next_dialogue_idx = 0
	end
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


-- talk to a guest (defaulting to current `interaction`)
function talk_to(guest)
	if guest == nil then guest = interaction end
	assert(guest ~= nil)
	assert(guest.next_dialogue_idx ~= nil)

	say(guest.dialogue[(guest.next_dialogue_idx % #guest.dialogue) + 1])
	guest.next_dialogue_idx += 1
end


function update_interaction()
	interaction = get_interaction()

	if interaction and btnp(4) then
		talk_to()
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


function draw_guests()
	for _, guest in ipairs(scenario.guests) do
		draw_sprite(sprites.guest_body, guest.x, guest.y)
		draw_sprite(guest.sprite, guest.x, guest.y - sprites.guest_body.h * 8)
	end
end
