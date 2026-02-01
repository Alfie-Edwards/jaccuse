Line = class({}, function(self, text, maybe_clue)  -- (str, str|nil)
	self.text = text
	self.maybe_clue = maybe_clue
end)

Question = class({}, function(self, question, result, asked)  -- (str, Line|Questions, bool=false)
	if asked == nil then asked = false end
	self.question = question
	self.result = result
	-- TODO #cleanup
	self.asked = asked
end)

Questions = class({}, function(self, normal_questions, final_question)  -- ([Question], str)
	self.normal_questions = normal_questions
	self.final_question = final_question
end)

function init_scenario()
	main = {
		guilty = "crocodile",
		guests = {
			{
				name = "unicorn",
				x = 44,
				y = 66,
				sprite = sprites.guest1,
				dialogue = {
					Line("hey there :)"),
					Questions({
						Question("tell me about your costume.", Line("i'm a unicorn... duh!",
						                                            "dressed as a unicorn.")),
						Question("don't unicorns have 4 legs?", Line("actually, unicorns love to magically disguising themselves to blend in with humans!",
						                                             "unicorns use magic to blend in with humans.")),
					}, "bye then."),
					Line("see you :)"),
				},
			},
			{
				name = "alien",
				x = 29,
				y = 13,
				sprite = sprites.guest2,
				dialogue = {
					Line("greetings earthling."),
					Questions({
						Question("tell me about your costume.", Line("i'm the recently sited bristol harbor alien!",
						                                             "dressed as the recently sited bristol harbor alien.")),
						Question("know any alien facts?", Line("i heard electronic signals get all messed up when aliens are near",
						                                        "aliens interfere with electronic signals.")),
						Question("noticed any strange goings on?", Line("the lights went out earler. i think the goblin guy got them to come back on. maybe they work here?",
						                                                "the lights went out earlier and the goblin fixed them")),
					}, "bye then."),
					Line("goodbye... earthling"),
				},
			},
			{
				name = "crocodile",
				x = 92,
				y = 27,
				sprite = sprites.guest3,
				dialogue = {
					Line("Hello world 3."),
					Questions({
						Question("tell me about your costume.", Line("bristol crocodile. beloved character. lives in river!",
						                                             "dressed as the bristol crocodile.")),
						Question("why are you talking like that?", Line("hahaha, no good at english!",
						                                                "doesn't speak good english.")),
						Question("are you having fun?", Line("tasty food but all gone!",
						                                     "liked the food but now it's all gone.")),
					}, "bye then."),
					Line("bye then!"),
				},
			},
			{
				name = "plague doctor",
				x = 26,
				y = 66,
				sprite = sprites.guest4,
				dialogue = {
					Line("heyy"),
					Questions({
						Question("tell me about your costume.", Line("sure, i'm dressed as a plague doctor. everyone thinks the classic uniform is from the bubonic plague but actually it emerged in the 17th century. sorry, i'm studying history and i tend to info dump haha...",
						                                             "dressed as a plague doctor.\n\nplague doctors uniforms were from the 17th century, after the bubonic plague\n\nstudiying history.")),
						Question("whats up with the pirate guy?", Line("haha... i know him from my course. he's dressed as blackbeard. I think he went overboard on the rum punch...",
						                                               "pirate is dressed as blackbeard.\n\npirate drunk all the rum punch.\nknows pirate from university course.")),
						Question("can you tell me about blackbeard?", Line("sure, he was a famously rich and succesful pirate from this very city. apparently he disliked violence, and preferred to leverage his fearsome reputation.",
						                                                   "blackbeard was rich and succesful.\n\nblackbeard disliked violence.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "headless man",
				x = 194,
				y = 226,
				sprite = sprites.guest5,
				dialogue = {
					Line("..."),
					Questions({
						Question("tell me about your costume.", Line("...",
						                                             "...")),
						Question("hello", Line("...",
						                       "...")),
						Question("what are you doing?", Line("...dude, take a hint! can't talk if i don't have a head!",
						                                     "...")),
					}, "bye then..."),
					Line("..."),
				},
			},
			{
				name = "bristol lion",
				x = 14,
				y = 130,
				sprite = sprites.guest6,
				dialogue = {
					Line("oh, hey"),
					Questions({
						Question("tell me about your costume.", Line("i'm a lion, basically a giant house cat",
						                                             "dressed as a lion.\n\nlions are basically giant house cats.")),
						Question("got any facts about lions?.", Line("there were wild lions in britain as recently as 12000 years ago",
						                                             "12000 years ago there were lions in britain.")),
						Question("enjoying yourself?", Line("actually... the power went out earlier and it was pitch black in here. really threw off my vibe.",
						                                    "the lights went out earlier.\n\ndoesn't like the dark.")),
					}, "bye then."),
					Line("see you!"),
				},
			},
			{
				name = "big cat",
				x = 37,
				y = 110,
				sprite = sprites.guest7,
				dialogue = {
					Line("meow"),
					Questions({
						Question("tell me about your costume.", Line("big black cats like my costume are regularly spotted all over the uk including around bristol.",
						                                             "dressed as a big black cat.\n\nbig black cats are regularly spotted accross the uk.")),
						Question("enjoying yourself?", Line("it's a cool vibe but... honestly I was hoping this would be more like cheesy music and a dancefloor haha",
						                                    "loves cheesy music and dancing.")),
					}, "bye then."),
					Line("see ya!"),
				},
			},
			{
				name = "pig",
				x = 64,
				y = 98,
				sprite = sprites.guest8,
				dialogue = {
					Line("Hello world 8."),
					Questions({
						Question("tell me about your costume.", Line("i mean... its a pig.",
						                                             "dressed as a pig")),
						Question("enjoying yourself?", Line("i was enjoying the buffet but someone ate all the meat.",
						                                    "was enjoying the buffet until someone ate all the meat.")),
						Question("what made you come here?", Line("i was actually dragged along here the guy in the plague doctor outfit, but he's kinda abandoned me",
						                                          "was dragged along here by the plague doctor.")),
					}, "bye then."),
					Line("oh, bye."),
				},
			},
			{
				name = "blackbeard",
				x = 35,
				y = 18,
				sprite = sprites.guest8,
				dialogue = {
					Line("Hello world 8."),
					Questions({
						Question("tell me about your costume.", Line("i feel sick...",
						                                             "feels sick.")),
						Question("are you okay?", Line("...",
						                               "...")),
					}, "bye then."),
					Line("..."),
				},
			},
			{
				name = "parking attendant",
				x = 158,
				y = 28,
				sprite = sprites.guest8,
				dialogue = {
					Line("Hello world 8."),
					Questions({
						Question("tell me about your costume.", Line("i'm the fabled bristol zoo parking attendant, who apparently made millions pretending to work for the zoo.'",
						                                             "dressed as the bristol zoo parking attendant\n\nthe bristol zoo parking attendant made millions.")),
						Question("enjoying yourself?", Line("actually, don't you think its a bit hot in here?",
						                                    "feels too hot.")),
						Question("what made you come here?", Line("honestly, mostly the free food. waiting for my student loan to come in.",
						                                          "short on money.")),
					}, "bye then."),
					Line("see ya"),
				},
			},
			{
				name = "goblin of pen park hole",
				x = 73,
				y = 168,
				sprite = sprites.guest8,
				dialogue = {
					Line("hello there!"),
					Questions({
						Question("tell me about your costume.", Line("i'm the fearsome goblin of pen park hole! i dwell in the cave in pen park, cursing anyone who ventures inside!'",
						                                             "dressed as the goblin of pen park hole\n\nthe goblin guards its cave, cursing anyone who enters.")),
						Question("why are you covered in dirt?", Line("because i live in a cave *wink*.",
						                                              "covered in dirt.")),
						Question("tell me about the venue?", Line("the hatchet is the oldest pub in bristol. legend says that under all the paint, the front door is wrapped in human skin!",
						                                          "the party is in the hatchet\n\nthe hatchet is the oldest pub in bristol\n\ndegend says the door of the hatchet is wrapped in human skin.")),
					}, "bye then."),
					Line("have fun."),
				},
			},
			{
				name = "ghost 1",
				x = 233,
				y = 211,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 1 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
						Question("any ghost facts?", Line("rooms with ghosts in them can become unnaturally cold!")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 2",
				x = 200,
				y = 101,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 2 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 3",
				x = 93,
				y = 23,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 3 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 4",
				x = 41,
				y = 141,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 4 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 5",
				x = 233,
				y = 211,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 5 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 6",
				x = 169,
				y = 164,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 6 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 7",
				x = 84,
				y = 45,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 7 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 8",
				x = 102,
				y = 105,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 8 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 9",
				x = 86,
				y = 198,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 9 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 10",
				x = 74,
				y = 14,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 10 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 11",
				x = 157,
				y = 197,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 11 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 12",
				x = 162,
				y = 156,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 12 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 13",
				x = 230,
				y = 70,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 13 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 14",
				x = 16,
				y = 85,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 14 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
			{
				name = "ghost 15",
				x = 163,
				y = 160,
				sprite = sprites.guest8,
				dialogue = {
					Line("wooOooOo!"),
					Questions({
						Question("tell me about your costume.", Line("i'm ghost number 15 of the 15 ghosts that haunt the llandoger!'",
						                                             "dressed as one of the 15 ghosts that haunts the llandoger.")),
					}, "bye then."),
					Line("see ya."),
				},
			},
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
		add_clue(guest, maybe_clue)
		choose_question()
		print_seen_clues()
	end
end

-- start talking to a `guest` (defaulting to current `interaction`)
function start_talking_to(guest)
	if guest == nil then guest = interaction end
	assert(guest ~= nil)

	player.talking_to = {guest=guest, idx=0}  -- (idx will be inc'd to 1 on next player update)
end

-- get `Line` corresponding to given guest & dialogue index (or `nil` if idx too large)
function get_to_say(guest, idx)
	if idx > #guest.dialogue then return nil end
	local current_stage = guest.dialogue[idx]

	-- TODO #cleanup
	assert(current_stage.class ~= nil)
	if current_stage.class == Line then
		return current_stage
	elseif current_stage.class == Questions then
		local opts = {}
		for _,qn in ipairs(current_stage.normal_questions) do
			add(opts, Option(qn.question, function()
				see_clue(guest, qn.result.maybe_clue)
				say(qn.result.text)
			end))
		end
		return OptionList(opts)
	else
		assert(false == "unexpected class")
	end
	return nil
end

-- say a given line, or the line corresponding to the given index, from a `guest`.
-- return `true` if there's a new line to say, or `false` if index too big (ie. end)
function say_idx(guest, idx)
	local to_say = get_to_say(guest, idx)
	if to_say == nil then
		return false
	end
	-- TODO #cleanup
	if to_say.class == Line then
		see_clue(guest, to_say.maybe_clue)
		say(to_say.text)
	else
		say(to_say)
	end
	return true
end

unmasking = false
accused = nil
function accuse(guest)
	if guest == nil then guest = interaction end
	assert(guest ~= nil)
	say("you unmask "..guest.name.."...")
	music_state = "accused"
	unmasking = true
	accused = guest
end

function update_interaction()
	if unmasking then
		if not saying then
			assert(accused ~= nil)
			if accused.name == main.guilty then
				won = true
			else
				guessed_wrong = true
			end
		end
	else
		interaction = get_interaction()

		if interaction then
			if btnp(4) then
				start_talking_to()
				interaction = nil
			elseif btnp(5) then
				accuse()
				interaction = nil
			else
				prompt = { "❎ talk",  "🅾️ j'accuse!" }
			end
		end
	end
end


function draw_guest(guest)
	draw_sprite(sprites.guest_body, guest.x, guest.y)
	draw_sprite(guest.sprite, guest.x, guest.y - sprites.guest_body.h * 8)
end
