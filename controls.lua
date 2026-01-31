function draw_controls()
	local space_size = lnpx(" ")
	if xo_prompt ~= nil then
		color(0)
		print("❎/🅾️ "..xo_prompt, 3, 4)
		color(7)
		print("❎/🅾️ "..xo_prompt, 3, 3)
	elseif x_prompt ~= nil and o_prompt ~= nil then
		local x_str = "❎ "..x_prompt
		local o_str = "🅾️ "..o_prompt
		local padding = 120 - lnpx(x_str) - lnpx(o_str)
		local combined_str = x_str..str_rep(" ", flr(padding / space_size))..o_str
		color(0)
		print_centered(combined_str, 4, 1)
		color(7)
		print_centered(combined_str, 3, 1)
	elseif x_prompt ~= nil then
		color(0)
		print("❎ "..x_prompt, 3, 4)
		color(7)
		print("❎ "..x_prompt, 3, 3)
	elseif o_prompt ~= nil then
		color(0)
		print("🅾️ "..o_prompt, 3, 4)
		color(7)
		print("🅾️ "..o_prompt, 3, 3)
	end
	xo_prompt = nil
	x_prompt = nil
	o_prompt = nil
end
