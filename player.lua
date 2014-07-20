require 'constants'
require 'gameObject'
--require 'AnAl'

player = {}

function player.init()
	-- player dimensions.
	player.x = PLAYER_START_X
	player.y = PLAYER_START_Y

	-- player velocity variables.
	player.vel_x = 0.0
	player.vel_y = 0.0

	player.health = 100
end

function player.load()
	player.image  = love.graphics.newImage("Images/plane.png")
	--player.anim = newAnimation(player.image, PLAYER_SPRITE_WIDTH, PLAYER_SPRITE_HEIGHT, PLAYER_SPRITE_RATE, 0)
end

function player.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(player.image, player.x, player.y)
	--player.anim:draw(player.x, player.y)
end

function player.physics(dt)
	-- get new player position from velocities.
	player.x = player.x + player.vel_x * dt
	player.y = player.y + player.vel_y * dt

	-- apply friction on player.
	player.vel_x = player.vel_x * FRICTION
	player.vel_y = player.vel_y * FRICTION
end

function player.move(dt)
	-- accelerate the player based on direction.
	if love.keyboard.isDown(K_RIGHT) and player.vel_x < PLAYER_SPEED_LIMIT then
		player.vel_x = player.vel_x + PLAYER_ACCEL_X * dt
	end
	if love.keyboard.isDown(K_LEFT) and (- player.vel_x) < PLAYER_SPEED_LIMIT then
		player.vel_x = player.vel_x - PLAYER_ACCEL_X * dt
	end
	if love.keyboard.isDown(K_UP) and (- player.vel_y) < PLAYER_SPEED_LIMIT then
		player.vel_y = player.vel_y - PLAYER_ACCEL_Y * dt
	end
	if love.keyboard.isDown(K_DOWN) and player.vel_x < PLAYER_SPEED_LIMIT then
		player.vel_y = player.vel_y + PLAYER_ACCEL_Y * dt
	end
end 

-- shoot functionalty for the player
function player.shoot()
	bullet.spawn(player.x + PLAYER_WIDTH, player.y + PLAYER_HEIGHT / 2, 'right')
end

function player.isAlive()
	return player.health > 0
end

-- PARENT FUNCTIONS
function DRAW_PLAYER()
	player.draw()
end

function UPDATE_PLAYER(dt)
	player.physics(dt)
	player.move(dt)
	gameObject.contain(player, PLAYER_WIDTH, PLAYER_HEIGHT)
	--player.anim:update(dt)
end