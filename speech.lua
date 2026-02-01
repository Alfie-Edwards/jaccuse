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
			prompt = { "⬆️/⬇️ choose", "❎ submit" }
			if btnp(3) then
				ol.selected_idx = min(ol.selected_idx + 1, #ol.opts)
			elseif btnp(2) then
				ol.selected_idx = max(ol.selected_idx - 1, 1)
			elseif btnp(4) then
				ol.opts[ol.selected_idx].callback()
			end
		else
			prompt = "❎/🅾️ next"
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
		color(7)
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
				print("♥", 109, 121, 9)
			end
		elseif para.class == OptionList then
			for i,o in ipairs(para.opts) do
				local prefix = "  "
				if i == para.selected_idx then
					prefix = "▶ "
				end
				print(prefix..o.msg, 8, 97+(i-1)*8, 2)
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
		if type(v) == "string" then
			paras[i] = wrap(v, 28, 4)
		else
			paras[i] = v
		end
	end

	saying = {
		char = 1,
		para = 1,
		paras = paras,
	}
	prompt = "❎/🅾️ next"
end

function saying_options()
	return saying and type(saying.paras[saying.para]) == "table" and saying.paras[saying.para].class == OptionList
end

function saying_para_done()
	return (not saying) or saying_options() or saying.char == #saying.paras[saying.para]
end
