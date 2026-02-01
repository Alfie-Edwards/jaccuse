function init_screens()
	scene = "menu"
	intro_strings = {
		"the party's all in masks...",
		"but one is a real monster!",
		"find it before it eats everyone!",
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
	if lost() then
		draw_lose_screen()
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
	print_centered(intro_string, 60)
end

function draw_win_screen()
	cls(9)

	color(7)
	print_centered("you win!!!", 60)
end

function draw_lose_screen()
	cls(0)

	color(8)
	print_centered("you lost!!!", 60)
end
