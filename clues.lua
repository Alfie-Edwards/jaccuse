function init_clues()
	clues_open = false
	clue_scroll = 0
	clues = {}
	num_lines_on_screen = 16
end


function add_clue(guest, clue_str)
	music_state = "found_clue"
	if clues[guest] == nil then
		clues[guest] = wrap(clue_str, 26)
	else
		clue_str = wrap(clue_str, 26)
		clues[guest] = clues[guest].."\n\n"..clue_str
	end
end


function all_clues_str()
	local result = "         - clues -"
	local sprite_offsets = {}
	local line = 0
	for guest, clue_str in pairs(clues) do
		result = result.."\n\n\n\n\n"..clue_str
		sprite_offsets[line + 4] = guest.sprite
		line += (#split(clue_str, "\n") + 4)
	end
	return result, sprite_offsets
end

function update_clues()
	if clues_open then
		if btnp(2) then
			clue_scroll = max(0, clue_scroll - 1)
			music_state = "scroll_clues"
		elseif btnp(3) then
			local num_clue_lines = #(split(all_clues_str(), "\n")) 
			clue_scroll = min(max(0, num_clue_lines - num_lines_on_screen), clue_scroll + 1)
			music_state = "scroll_clues"
		end
		if btnp(5) then
			clues_open = false
		elseif #(split(all_clues_str(), "\n")) > num_lines_on_screen then
			prompt = { "⬆️/⬇️ scroll", "🅾️ exit" }
		else
			prompt = "🅾️ exit"
		end
	elseif not interaction and not saying and next(clues) ~= nil then
		if btnp(4) then
			music_state = "open_clues"
			clues_open = true
		else
			prompt = "❎ view clues"
		end
	end
end


function draw_clues()
	if clues_open then
		local all_clues, sprite_index = all_clues_str()
		local clue_lines = split(all_clues, "\n")
		local bottom_line = min(clue_scroll + num_lines_on_screen, #clue_lines - 1)
		local clipped_clue_str = ""
		for i = clue_scroll, bottom_line do
			clipped_clue_str = clipped_clue_str.."\n"..clue_lines[i+1]
		end

		color(6)
		rectfill(3, 14, 124, 122)

		-- Draw dashed top of paper if can be scrolled up
		if clue_scroll > 0 then
			poke(0x550b, 0x3f)
			fillp(0xbC93.8)
			rectfill(3, 12, 124, 13)
			fillp()
			poke(0x550b, 0x00)
			if strobe(0.66) then
				color(9)
				print("★", 62, 10)
				color(7)
			end
		else
			rectfill(3, 12, 124, 13)
		end

		-- Draw dashed bottom of paper if can be scrolled up
		if clue_scroll < max(0, #clue_lines - num_lines_on_screen) then
			poke(0x550b, 0x3f)
			fillp(0xbC93.8)
			rectfill(3, 123, 124, 124)
			fillp()
			poke(0x550b, 0x00)
			if strobe(0.66) then
				color(9)
				print("♥", 62, 121)
				color(7)
			end
		else
			rectfill(3, 123, 124, 124)
		end

		color(0)
		print(clipped_clue_str, 10, 12)

		for offset, sprite in pairs(sprite_index) do
			if offset >= (clue_scroll + 3) and offset <= bottom_line then
				draw_sprite(sprite, 16, 20 + 6 * (offset - clue_scroll))
			end
		end
	end
end

