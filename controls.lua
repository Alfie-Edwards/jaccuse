function draw_controls()
	local space_size = lnpx(" ")
	if type(prompt) == "table" then
		local l_str = prompt[1]
		local r_str = prompt[2]
		local padding = 120 - lnpx(l_str) - lnpx(r_str)
		local combined_str = l_str..str_rep(" ", flr(padding / space_size))..r_str
		color(0)
		print_centered(combined_str, 4, 1)
		color(7)
		print_centered(combined_str, 3, 1)
	elseif type(prompt) == "string" then
		color(0)
		print(prompt, 3, 4)
		color(7)
		print(prompt, 3, 3)
	end
	prompt = nil
end
