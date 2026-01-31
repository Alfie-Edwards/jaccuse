Line = class({}, function(self, text, maybe_clue)  -- (str, str|nil)
	self.text = text
	self.maybe_clue = maybe_clue
end)

Question = class({}, function(self, question, result, asked)  -- (str, Line|Questions, bool=false)
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
				name = "1",
				x = 10,
				y = 200,
				sprite = sprites.guest1,
				dialogue = {
					Line("Hello world 1."),
					Questions({
						Question("What's your name?", Line("My name is egg",
						                                   "Name is egg Lorem ipsum dolor sit amet, consectetur adipiscing elit")),
						Question("What's your favourite food?", Line("My favourite food is paper.",
						                                             "Favourite food is paper")),
					}, "Goodbye then."),
					Line("See you!"),
				},
			},
			{
				name = "2",
				x = 10,
				y = 10,
				sprite = sprites.guest2,
				dialogue = {
					Line("Hello world 2."),
					Questions({
						Question("What's your name?", Line("My name is egg",
						                                   "Name is egg the quick brown fox jumps over the lazy dog")),
						Question("What's your favourite food?", Line("My favourite food is paper.",
						                                             "Favourite food is paper")),
					}, "Goodbye then."),
					Line("See you!"),
				},
			},
			{
				name = "3",
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
				name = "4",
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
				name = "5",
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
				name = "6",
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
				name = "7",
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
				name = "8",
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
end


function get_interaction()
	if saying or clues_open then
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

function print_seen_clues()
	for g,clues in pairs(player.seen_clues) do
		for _,clue in ipairs(clues) do
			printh("    "..g..": "..clue)
		end
	end
end

-- if maybe_clue isn't nil, remember it on the player (associated with the given guest)
function see_clue(guest, maybe_clue)
	if maybe_clue == nil then return end

	if player.seen_clues[guest.name] == nil then
		player.seen_clues[guest.name] = {}
	end

	if index_of(player.seen_clues[guest.name], maybe_clue) == nil then
		add(player.seen_clues[guest.name], maybe_clue)
		add_clue(maybe_clue)
	end
end

-- start talking to a `guest` (defaulting to current `interaction`)
function start_talking_to(guest)
	if guest == nil then guest = interaction end
	assert(guest ~= nil)

	player.talking_to = {guest=guest, idx=1}

	say_line(player.talking_to.guest, player.talking_to.idx)
end

-- get `Line` corresponding to given guest & dialogue index (or `nil` if idx too large)
function get_line(guest, idx)
	if idx > #guest.dialogue then return nil end
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

	return line_to_say
end

-- say a given line, or the line corresponding to the given index, from a `guest`.
-- return `true` if there's a new line to say, or `false` if index too big (ie. end)
function say_line(guest, line_or_idx)
	local line = line_or_idx
	if type(line) == "number" then
		line = get_line(guest, line)
		if line == nil then
			return false
		end
	end
	see_clue(guest, line.maybe_clue)
	say(line.text)
	return true
end

function update_interaction()
	interaction = get_interaction()

	if interaction then
		if btnp(4) then
			start_talking_to()
			interaction = nil
		else
			prompt = { "❎ talk",  "🅾️ j'accuse!" }
		end
	end
end


function draw_guest(guest)
	draw_sprite(sprites.guest_body, guest.x, guest.y)
	draw_sprite(guest.sprite, guest.x, guest.y - sprites.guest_body.h * 8)
end
