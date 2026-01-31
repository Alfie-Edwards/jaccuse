function init_clues()
	clues_open = false
	clue_scroll = 0
	all_clues_str = ""
	num_lines_on_screen = 16
end


function add_clue(clue_str)
	if all_clues_str == "" then
		all_clues_str = wrap(clue_str, 26)
	else
		clue_str = wrap(clue_str, 26)
		all_clues_str = all_clues_str.."\n\n"..clue_str
	end

end


function update_clues()
	if clues_open then
		if btnp(2) then
			clue_scroll = max(0, clue_scroll - 1)
		elseif btnp(3) then
			local num_clue_lines = #(split(all_clues_str, "\n")) 
			clue_scroll = min(max(0, num_clue_lines - num_lines_on_screen), clue_scroll + 1)
		end
		if btnp(5) then
			clues_open = false
		elseif #(split(all_clues_str, "\n")) > num_lines_on_screen then
			prompt = { "⬆️/⬇️ scroll", "🅾️ exit" }
		else
			prompt = "🅾️ exit"
		end
	elseif not interaction and not saying and all_clues_str ~= "" then
		if btnp(4) then
			clues_open = true
		else
			prompt = "❎ view clues"
		end
	end
end


function draw_clues()
	if clues_open then
		local clue_lines = split(all_clues_str, "\n")
		local bottom_line = min(clue_scroll + num_lines_on_screen, #clue_lines - 1)
		local clipped_clue_str = ""
		for i = clue_scroll, bottom_line do
			clipped_clue_str = clipped_clue_str.."\n"..clue_lines[i+1]
		end
		color(7)

		-- Draw dashed top of paper if can be scrolled up
		if clue_scroll > 0 then
			poke(0x550b, 0x3f)
			fillp(0xbC93.8)
		end
		rectfill(3, 12, 124, 13)
		fillp()
		poke(0x550b, 0x00)

		-- Draw dashed bottom of paper if can be scrolled up
		if clue_scroll < max(0, #clue_lines - num_lines_on_screen) then
			poke(0x550b, 0x3f)
			fillp(0xbC93.8)
		end
		rectfill(3, 123, 124, 124)
		fillp()
		poke(0x550b, 0x00)

		rectfill(3, 14, 124, 122)
		color(0)
		print(clipped_clue_str, 10, 12)
	end
end

