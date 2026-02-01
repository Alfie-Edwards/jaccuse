function init_music()
	music_state = "intro"
end

function update_music()
	if music_state == "intro" and scene == "game" then
		music(0)
		music_state = "bg_music"
	elseif music_state ~= "won" and won() then
		music(-1)
		music(24)
		music_state = "won"
	elseif music_state ~= "lost" and lost() then
		music(-1)
		music(32)
		music_state = "lost"
	end
end
