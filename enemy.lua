require 'constants.lua'
require 'gameObject.lua'

enemy = {}

function enemy.init()
	enemy.elapsedSpawnTime = 0
	enemy.numberOfEnemies = 0
	enemy.enemyList = {}
end

function enemy.load()
	enemy.image = love.graphics.newImage('Images/scarab.png')
end

-- generate new enemies every ENEMY_SPAWN_TIME seconds
function enemy.generate(dt)
	if enemy.numberOfEnemies < MAX_NUMBER_OF_ENEMIES then
		enemy.elapsedSpawnTime = enemy.elapsedSpawnTime + dt
		if enemy.elapsedSpawnTime > ENEMY_SPAWN_TIME then
			enemy.elapsedSpawnTime = 0
			enemy.numberOfEnemies = enemy.numberOfEnemies + 1

			--spawn an enemy at random y position on the right of the screen.
			enemy.spawn(WINDOW_WIDTH - ENEMY_WIDTH, math.random(0, WINDOW_HEIGHT - ENEMY_HEIGHT)) 
		end
	end
end


function enemy.remove(i)
	table.remove(enemy.enemyList, i)
	enemy.numberOfEnemies = enemy.numberOfEnemies - 1
end

function enemy.spawn(x, y)
	table.insert(enemy.enemyList, {x = x, y = y, vel_x = 0, vel_y = 0, health = 2})
end

function enemy.draw()
	love.graphics.setColor(255, 255, 255)
	for i, v in ipairs(enemy.enemyList) do
		--calculate angle to player.
		local p = player.y - v.y
		local b = player.x - v.x
		local angle = math.atan(p / b)

		if b > 0 then
			angle = angle + math.pi
		end

		local trans_x = v.x + ENEMY_WIDTH/2
		local trans_y = v.y + ENEMY_HEIGHT/2

		love.graphics.push()
		love.graphics.translate(trans_x, trans_y)
		love.graphics.rotate(angle)
		love.graphics.translate(-trans_x, -trans_y)
		love.graphics.draw(enemy.image, v.x, v.y)
		love.graphics.pop()
	end
end

function enemy.physics(dt)
	for i, v in ipairs(enemy.enemyList) do
		v.x = v.x + v.vel_x * dt
		v.y = v.y + v.vel_y * dt

		-- apply friction on enemy.
		v.vel_x = v.vel_x * FRICTION
		v.vel_y = v.vel_y * FRICTION

		gameObject.contain(v, ENEMY_WIDTH, ENEMY_HEIGHT)
	end
end

-- simple AI that moves enemy to the player.
function enemy.AI(dt)
	for i, v in ipairs(enemy.enemyList) do
		-- if player is to the left of enemy
		if player.x + PLAYER_WIDTH / 2 < v.x + ENEMY_WIDTH / 2 then
			if (- v.vel_x) < ENEMY_SPEED_LIMIT then
				v.vel_x = v.vel_x - ENEMY_ACCEL_X * dt
			end
		end
		if player.x + PLAYER_WIDTH / 2 > v.x + ENEMY_WIDTH / 2 then
			if v.vel_x < ENEMY_SPEED_LIMIT then
				v.vel_x = v.vel_x + ENEMY_ACCEL_X * dt
			end
		end
		if player.y + PLAYER_HEIGHT / 2 < v.y + ENEMY_HEIGHT / 2 then
			if (- v.vel_y) < ENEMY_SPEED_LIMIT then
				v.vel_y = v.vel_y - ENEMY_ACCEL_Y * dt
			end
		end
		if player.y + PLAYER_HEIGHT / 2 > v.y + ENEMY_HEIGHT / 2 then
			if v.vel_y < ENEMY_SPEED_LIMIT then
				v.vel_y = v.vel_y + ENEMY_ACCEL_Y * dt
			end
		end
	end
end

--PARENT FUNCTIONS
function DRAW_ENEMY()
	enemy.draw()
end
function UPDATE_ENEMY(dt)
	enemy.generate(dt)
	enemy.AI(dt)
	enemy.physics(dt)
end
