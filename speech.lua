function init_speech()
	t_para_completed = nil
	saying = nil
end


function update_speech()
	if saying then
		prompt = "❎/🅾️ next"
		if saying_para_done() then
			if btnp(4) or btnp(5) or mouse.pressed then
				saying.para += 1
				saying.char = 1
				if saying.para > #saying.paras then
					saying = nil
				end
			end
		else
			saying.char = saying.char + 1
			if saying.char == #saying.paras then
				t_para_completed = t()
			end
		end
	end
end


function draw_speech()
	camera(0, 0)
	if saying then
		color(7)
		rectfill(7, 93, 120, 123)
		rectfill(4, 96, 123, 120)
		circfill(7, 96, 3)
		circfill(120, 96, 3)
		circfill(7, 120, 3)
		circfill(120, 120, 3)
		print("◆", 12, 90)

		print(sub(saying.paras[saying.para], 1, saying.char), 8, 97, 2)

		if saying_para_done() and strobe(0.66, t_para_completed) then
			print("♥", 109, 121, 9)
		end
	end
end


function say(paras)
	if type(paras) == "string" then
		paras = {paras}
	end

	for i,v in ipairs(paras) do
		paras[i] = wrap(v, 28, 4)
	end

	saying = {
		char = 1,
		para = 1,
		paras = paras,
	}
	prompt = "❎/🅾️ next"
end


function saying_para_done()
	return (not saying) or saying.char == #saying.paras[saying.para]
end
