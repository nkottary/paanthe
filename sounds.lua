sounds = {}

function sounds.load()
	sounds.crashSound = love.audio.newSource("Sounds/enemy_crash.ogg", "static")
	sounds.explosionSound = love.audio.newSource("Sounds/explosion.ogg", "static")
	sounds.playerDeathSound = love.audio.newSource("Sounds/player_death.ogg", "static")
	sounds.playerShootSound = love.audio.newSource("Sounds/player_shoot.ogg", "static")
	sounds.playingMusic = love.audio.newSource("Sounds/playing_music.ogg")
	sounds.menuMusic = love.audio.newSource("Sounds/menu-music.mp3")
end