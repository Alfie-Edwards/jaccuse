function init_music()
	bg_music_started = false
end

function update_music()
	if not bg_music_started and scene == "game" then
		music(0)
		bg_music_started = true
	end
end
