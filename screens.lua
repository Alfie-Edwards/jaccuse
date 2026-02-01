function init_screens()
	scene = "menu"
	intro_strings = {
		"what's up spooktube!",
		" i'm headed to the\ncryptid masquarade\n  at the hatchet",
		"     rumor has it\nsome real life monsters\n    will be there!",
		"good thing i'll be\n   on the scene\nto sniff them out!",
	}

	intro_string = nil
end

function update_screens()
	if scene == "menu" then
		if any_input() then
			scene = "intro"
			cor = cocreate(intro_scene)
		end
	end

	if scene == "intro" then
		if cor and costatus(cor) ~= 'dead' and btnp(4) then
			coresume(cor)
		end
	end
end

function intro_scene()
	for _, string in pairs(intro_strings) do
		intro_string = string
		yield()
	end

	scene = "game"
end

won = false
guessed_wrong = false
out_of_questions = false
function draw_screens()
	if scene == "menu" then
		draw_start_screen()
		return 1
	end

	if scene == "intro" then
		draw_intro_screen()
		return 1
	end

	if not scene == "game" then
		return 1
	end

	if won then
		draw_win_screen()
		return 1
	end
	if guessed_wrong then
		draw_wrong_screen()
		return 1
	end
	if out_of_questions then
		draw_oot_screen()
		return 1
	end
end

-- function won()
-- 	-- TODO: Assign accused variable elsewhere
-- 	return (
-- 		scenario ~= nil and
-- 		accused ~= nil and
-- 		accused.name == scenario.guilty and
-- 		scene == "game"
-- 	)
-- end

function lost()
	return guessed_wrong or out_of_questions
-- 	-- TODO: Assign accused variable elsewhere
-- 	return (
-- 		scenario ~= nil and
-- 		accused ~= nil and
-- 		accused.name ~= scenario.guilty and
-- 		scene == "game"
-- 	)
end

function draw_start_screen()
	cls(8)

	color(2)
	print_centered("j'accuse!", 60)
	color(7)
	print_centered("j'accuse!", 59)

	color(2)
	if strobe(0.66) then
		print_centered("PRESS ANY BUTTON...", 100)
	end
end

function draw_intro_screen()
	if intro_string == nil then
		return
	end

	cls(0)

	color(12)
	print_centered(intro_string, 51)
	color(7)
	print_centered(intro_string, 50)
end

function draw_win_screen()
	cls(0)

	color(10)
	print_centered("you found the monster!!!", 50)
	print_centered("this is gonna go crazy", 65)
	print_centered("on spooktube!", 72)
end

function draw_wrong_screen()
	cls(0)

	color(8)
	print_centered("you guessed wrong!", 50)

	color(7)
	print_centered("you got kicked out", 70)
	print_centered("for being rude...", 78)
	color(12)
	print_centered("then the moster ate the guests!", 86)
end
function draw_oot_screen()
	cls(0)

	color(8)
	print_centered("you asked too many questions!", 50)

	color(7)
	print_centered("the clock struck midnight...", 70)
	color(12)
	print_centered("then the moster ate you!", 78)
end
