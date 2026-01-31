function init_speech()
	t_para_completed = nil
	saying = nil
	max_line_len = 28
	max_lines = 4
end


function update_speech()
	if saying then
		if saying_para_done() then
			if any_input() then
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
		color(0)
		rectfill(7, 93, 120, 123)
		rectfill(4, 96, 123, 120)
		circfill(7, 96, 3)
		circfill(120, 96, 3)
		circfill(7, 120, 3)
		circfill(120, 120, 3)
		print("◆", 12, 90)

		print(sub(saying.paras[saying.para], 1, saying.char), 8, 97, 2)

		if saying_para_done() and strobe(0.66, t_para_completed) then
			print("♥", 109, 121, 5)
		end
	end
end


function say(paras)
	if type(paras) == "string" then
		paras = {paras}
	end

	for i,v in ipairs(paras) do
		paras[i] = wrap(v)
	end

	saying = {
		char = 1,
		para = 1,
		paras = paras,
	}
end


function saying_para_done()
	return (not saying) or saying.char == #saying.paras[saying.para]
end


function wrap(text)
	local lines = {}
	for _, para in ipairs(split(text, "\n")) do
		add(lines, "")
		for _, word in ipairs(split(para, " ", false)) do
			if (#lines[#lines] + #word + 1) > max_line_len then
				if #word > max_line_len then
					local i = max_line_len - #lines[#lines]
					lines[#lines] = lines[#lines]..sub(word, 1, i).." "
					i += 1
					while i <= #word do
						add(lines, sub(word, i, i + max_line_len - 1))
						i += max_line_len
					end
				else
					add(lines, word.." ")
				end
			else
				lines[#lines] = lines[#lines]..word.." "
			end
		end
	end
	local result = ""
	for i, line in ipairs(lines) do
		if i > 1 then
			result = result.."\n"
		end
		result = result..line
	end
	assert(#lines <= max_lines)
	return result
end
