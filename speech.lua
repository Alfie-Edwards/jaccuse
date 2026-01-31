Option = class({}, function(self, msg, callback)
	self.msg = msg
	self.callback = callback
end)
OptionList = class({}, function(self, opts)
	self.opts = opts
	self.selected_idx = 1
end)


function init_speech()
	t_para_completed = nil
	saying = nil
	max_line_len = 28
	max_lines = 4
end


function advance()
	saying.para += 1
	saying.char = 1
	if saying.para > #saying.paras then
		saying = nil
	end
end
function update_speech()
	if saying then
		if saying_options() then
			local ol = saying.paras[saying.para]
			x_prompt = "choose"
			if btnp(3) then
				ol.selected_idx = min(ol.selected_idx + 1, #ol.opts)
			elseif btnp(2) then
				ol.selected_idx = max(ol.selected_idx - 1, 1)
			elseif btnp(5) then
				ol.opts[ol.selected_idx].callback()
				advance()
			end
		else
			xo_prompt = "next"
			if saying_para_done() then
				if btnp(4) or btnp(5) or mouse.pressed then
					advance()
				end
			else
				saying.char = saying.char + 1
				if saying.char == #saying.paras then
					t_para_completed = t()
				end
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

		local para = saying.paras[saying.para]
		if type(para) == "string" then
			print(sub(para, 1, saying.char), 8, 97, 2)

			if saying_para_done() and strobe(0.66, t_para_completed) then
				print("♥", 109, 121, 5)
			end
		elseif para.class == OptionList then
			for i,o in ipairs(para.opts) do
				if i == para.selected_idx then
					print("♥ "..o.msg, 8, 97+(i-1)*8, 2)
				else
					print(o.msg, 8, 97+(i-1)*8, 2)
				end
			end
		end
	end
end


-- paras: str | list[str | OptionList]
function say(paras)
	if type(paras) == "string" or paras.class == OptionList then
		paras = {paras}
	end

	for i,v in ipairs(paras) do
		-- printh("saying "..i.." is "..tostring(v))
		if type(v) == "string" then
			paras[i] = wrap(v)
		else
			paras[i] = v
		end
	end

	saying = {
		char = 1,
		para = 1,
		paras = paras,
	}
	xo_prompt = "next"
end

function saying_options()
	-- printh("---")
	-- printh(saying)
	-- printh(type(saying.paras[saying.para]))
	-- printh(saying.paras[saying.para].class == OptionList)
	return saying and type(saying.paras[saying.para]) == "table" and saying.paras[saying.para].class == OptionList
end

function saying_para_done()
	-- printh("---")
	-- for k,v in pairs(saying) do
	-- 	printh(k..": "..tostring(v))
	-- end
	-- for k,v in pairs(saying.paras) do
	-- 	printh("    "..k..": "..tostring(v))
	-- end
	-- printh(saying.paras)
	-- printh(saying_options())
	return (not saying) or saying_options() or saying.char == #saying.paras[saying.para]
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
