require 'constants'
require 'player'
require 'bullet'
require 'enemy'
require 'gameObject'
require 'inGameUI'
require 'background'
require 'explosion'
require 'fonts'
require 'sounds'
require 'menu'

function love.load()

	player.load()
	enemy.load()
	background.load()
	explosion.load()
	fonts.load()
	sounds.load()
	menu.load({'Start game', 'Highscores', 'quit'})

	gameState = 'menu'
	initMenu()
end

function initMenu()
	sounds.menuMusic:play()
end

function startGame()
	player.init()
	enemy.init()
	inGameUI.init()
	background.init()
	gameState = 'playing'
	sounds.playingMusic:play()
end

function doMenuAction()
	if menu.selectedOption == 1 then
		sounds.menuMusic:stop()
		startGame()
	elseif menu.selectedOption == 2 then
		love.event.quit()
	end
end

function handleMenuStates(key)
	if key == 'up' then
		menu.previous()
	elseif key == 'down' then
		menu.next()
	elseif key == 'return' then
		doMenuAction()
	end
end

function handlePauseState(key)
	if key == 'p' then
		gameState = 'playing'
	end
end

function handlePlayingState(key)
	if key == K_SHOOT then
		player.shoot()
		sounds.playerShootSound:play()
	elseif key == 'p' then
		gameState = 'paused'
	end
end

function handleOverState(key)
	if key == 'return' then
		initMenu()
		gameState = 'menu'
	end
end

-- shoot key code.
function love.keypressed(key)

	if gameState == 'menu' then
		handleMenuStates(key)
	elseif gameState == 'paused' then
		handlePauseState(key)
	elseif gameState == 'playing' then
		handlePlayingState(key)
	elseif gameState == 'over' then
		handleOverState(key)
	end
end

-- handle collisions
function bulletAndEnemyCollision()

	local bounce_x, bounce_y

	for i, v_bullet in ipairs(bullet) do
		for j, v_enemy in ipairs(enemy.enemyList) do

			bounce_x, bounce_y = gameObject.getCollisionVector(v_bullet.x, v_bullet.y, BULLET_WIDTH, BULLET_HEIGHT,
			 v_enemy.x, v_enemy.y, ENEMY_WIDTH, ENEMY_HEIGHT) 

			if bounce_x ~= 0 then

				bullet.remove(i)
				enemy.remove(j)

				explosion.spawn(v_enemy.x + ENEMY_WIDTH / 2, v_enemy.y + ENEMY_HEIGHT / 2)

				inGameUI.score = inGameUI.score + 1

				--play the explosion sound.
				sounds.explosionSound:play()
			end
		end
	end
end

function playerAndEnemyCollision()

	local bounce_x, bounce_y

	for i, v in ipairs(enemy.enemyList) do

		bounce_x, bounce_y = gameObject.getCollisionVector(v.x, v.y, ENEMY_WIDTH, ENEMY_HEIGHT, 
		 player.x, player.y, PLAYER_WIDTH, PLAYER_HEIGHT) 

		if bounce_x ~= 0 then

			player.health = player.health - 0.1

			bounce_x, bounce_y = bounce_x / BOUNCE_ATTENUATION, bounce_y / BOUNCE_ATTENUATION

			--bounce the enemy and player away
			gameObject.bounce(v, -bounce_x, -bounce_y)
			gameObject.bounce(player, bounce_x, bounce_y)

			--play the scrash sound
			sounds.crashSound:play()
		end
	end
end

--call parent functions.
function love.update(dt)

	if gameState == 'menu' then
		UPDATE_MENU(dt)
	end

	if gameState == 'playing' then

		UPDATE_ENEMY(dt)
		UPDATE_BULLET(dt)
		UPDATE_PLAYER(dt)
		-- call collision handlers
    	bulletAndEnemyCollision()
    	playerAndEnemyCollision()

		if not player.isAlive() then
    		gameState = 'over'
    		explosion.spawn(player.x + PLAYER_WIDTH/2, player.y + PLAYER_HEIGHT/2)

    		--stop in-game music
    		sounds.playingMusic:stop()

    		--play death sound.
    		sounds.playerDeathSound:play()
    	end
    end
	
    if gameState == 'playing' or gameState == 'over' then
		UPDATE_BACKGROUND(dt)
	    UPDATE_EXPLOSION(dt)
	end
end

function love.draw()
	if gameState == 'menu' then
		DRAW_MENU()
	else
		DRAW_BACKGROUND()
		DRAW_INGAMEUI()
	    DRAW_EXPLOSION() 

	    if gameState ~= 'over' then

			DRAW_PLAYER()

		end

		DRAW_BULLET()
		DRAW_ENEMY()
	end
end