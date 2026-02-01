function init_music()
	music_state = "intro"
end

function update_music()
	if music_state == "intro" and scene == "game" then
		music(1)
		music_state = "bg_music"
	elseif music_state == "found_clue" then
		sfx(7)
		music_state = nil
	elseif music_state == "open_clues" then
		sfx(12)
		music_state = nil
	elseif music_state == "scroll_clues" then
		sfx(13)
		music_state = nil
	elseif music_state ~= "won" and won then
		music(-1)
		music(24)
		music_state = "won"
	elseif music_state ~= "lost" and lost then
		music(-1)
		music(32)
		music_state = "lost"
	end
end
