-- (no subclassing)
function class(prototype, constructor)
	if constructor ~= nil then
		prototype.new = constructor
	end
	local mt = getmetatable(prototype)
	if mt == nil then
		mt = setmetatable(prototype, {})
	else
		assert(mt.__call == nil)
	end
	mt.__call = function(cls, ...)
		local instance = setmetatable({}, {__index = cls})
		instance.class = cls
		if cls.new ~= nil then
			cls.new(instance, ...)
		end
		return instance
	end
	return setmetatable(prototype, mt)
end


function index_of(list, value)
	for i,v in ipairs(list) do
		if v == value then
			return i
		end
	end
	return nil
end


function funnysqdist(x1, y1, x2, y2)
	-- max int is 32767 so have to scale down all the numbers...
	local dx = (x2 - x1) / 64
	local dy = (y2 - y1) / 64
	return dx * dx + dy * dy
end


function lnpx(text) -- length of text in pixels
	return print(text, 0, 999999)
end


function str_rep(str, n)
	local result = ""
	for _ = 0, n do
		result = result..str
	end
	return result
end


function wrap(text, max_line_len, max_lines)
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
	assert(max_lines == nil or #lines <= max_lines)
	return result
end


function any_input()
    return btnp(4) or btnp(5) or mouse.pressed
end
