Line = class({}, function(self, text, maybe_clue)  -- (str, str|nil)
	self.text = text
	self.maybe_clue = maybe_clue
end)

Question = class({}, function(self, question, result, asked)  -- (str, Line|{Question}, bool=false)
	if asked == nil then asked = false end
	self.question = question
	self.result = result
	self.asked = asked
end)

Questions = class({}, function(self, normal_questions, final_question)  -- ([Question], str)
	self.normal_questions = normal_questions
	self.final_question = final_question
end)

function init_scenario()
	main = {
		guilty = 1,
		guests = {
			{
				x = 10,
				y = 200,
				sprite = sprites.guest1,
				dialogue = {
					Line("Hello world 1."),
					Questions({
						Question("What's your name?", Line("My name is egg",
						                                   "Name is egg")),
						Question("What's your favourite food?", Line("My favourite food is paper.",
						                                             "Favourite food is paper")),
					}, "Goodbye then."),
					Line("See you!"),
				},
			},
			{
				x = 10,
				y = 10,
				sprite = sprites.guest2,
				dialogue = {
					Line("Hello world 2."),
					Questions({
						Question("What's your name?", Line("My name is egg",
						                                   "Name is egg")),
						Question("What's your favourite food?", Line("My favourite food is paper.",
						                                             "Favourite food is paper")),
					}, "Goodbye then."),
					Line("See you!"),
				},
			},
			{
				x = 50,
				y = 15,
				sprite = sprites.guest3,
				dialogue = {
					Line("Hello world 3."),
					Questions({
						Question("What's your name?", Line("My name is egg",
						                                   "Name is egg")),
						Question("What's your favourite food?", Line("My favourite food is paper.",
						                                             "Favourite food is paper")),
					}, "Goodbye then."),
					Line("See you!"),
				},
			},
			{
				x = 80,
				y = 12,
				sprite = sprites.guest4,
				dialogue = {
					Line("Hello world 4."),
					Questions({
						Question("What's your name?", Line("My name is egg",
						                                   "Name is egg")),
						Question("What's your favourite food?", Line("My favourite food is paper.",
						                                             "Favourite food is paper")),
					}, "Goodbye then."),
					Line("See you!"),
				},
			},
			{
				x = 200,
				y = 200,
				sprite = sprites.guest5,
				dialogue = {
					Line("Hello world 5."),
					Questions({
						Question("What's your name?", Line("My name is egg",
						                                   "Name is egg")),
						Question("What's your favourite food?", Line("My favourite food is paper.",
						                                             "Favourite food is paper")),
					}, "Goodbye then."),
					Line("See you!"),
				},
			},
			{
				x = 100,
				y = 230,
				sprite = sprites.guest6,
				dialogue = {
					Line("Hello world 6."),
					Questions({
						Question("What's your name?", Line("My name is egg",
						                                   "Name is egg")),
						Question("What's your favourite food?", Line("My favourite food is paper.",
						                                             "Favourite food is paper")),
					}, "Goodbye then."),
					Line("See you!"),
				},
			},
			{
				x = 120,
				y = 230,
				sprite = sprites.guest7,
				dialogue = {
					Line("Hello world 7."),
					Questions({
						Question("What's your name?", Line("My name is egg",
						                                   "Name is egg")),
						Question("What's your favourite food?", Line("My favourite food is paper.",
						                                             "Favourite food is paper")),
					}, "Goodbye then."),
					Line("See you!"),
				},
			},
			{
				x = 70,
				y = 90,
				sprite = sprites.guest8,
				dialogue = {
					Line("Hello world 8."),
					Questions({
						Question("What's your name?", Line("My name is egg",
						                                   "Name is egg")),
						Question("What's your favourite food?", Line("My favourite food is paper.",
						                                             "Favourite food is paper")),
					}, "Goodbye then."),
					Line("See you!"),
				},
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
		if (player.y - guest.y) > -8 then
			local dist = funnysqdist(guest.x, guest.y, player.x, player.y)
			if dist < closest_dist then
				closest = guest
				closest_dist = dist
			end
		end
	end
	if closest_dist < 0.06 then
		return closest
	end
end


-- talk to a guest (defaulting to current `interaction`)
function talk_to(guest)
	if guest == nil then guest = interaction end
	assert(guest ~= nil)
	assert(guest.next_dialogue_idx ~= nil)

	-- TODO #finish: if you stop talking, should reset to zero
	local idx = (guest.next_dialogue_idx % #guest.dialogue) + 1
	local current_stage = guest.dialogue[idx]

	local line_to_say = nil
	assert(current_stage.class ~= nil)
	if current_stage.class == Line then
		line_to_say = current_stage
	elseif current_stage.class == Questions then
		-- TODO #finish
		line_to_say = current_stage.normal_questions[1].result
	else
		assert(false == "unexpected class")
	end
	assert(line_to_say ~= nil)

	-- TODO #finish: register clues
	say(line_to_say.text)
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
