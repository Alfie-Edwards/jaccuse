main = {
	guilty = 1,
	characters = {
		{
			x = 10,
			y = 200,
			sprite = 0,
			dialogue = "Hello my name is a",
		},
		{
			x = 10,
			y = 10,
			sprite = 2,
			dialogue = "Hello my name is b",
		},
		{
			x = 50,
			y = 15,
			sprite = 4,
			dialogue = "Hello my name is c",
		},
		{
			x = 80,
			y = 12,
			sprite = 6,
			dialogue = "Hello my name is d",
		},
		{
			x = 200,
			y = 200,
			sprite = 8,
			dialogue = "Hello my name is e",
		},
		{
			x = 100,
			y = 230,
			sprite = 10,
			dialogue = "Hello my name is f",
		},
		{
			x = 120,
			y = 230,
			sprite = 12,
			dialogue = "Hello my name is g",
		},
		{
			x = 70,
			y = 90,
			sprite = 14,
			dialogue = "Hello my name is h",
		}
	}
}

function init_scenario()
	scenario = main
end

function draw_characters()
	for _, character in ipairs(scenario.characters) do
		spr(character.sprite, character.x, character.y, 2, 4)
	end
end
