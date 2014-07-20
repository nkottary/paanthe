require 'fonts'

inGameUI = {}

function inGameUI.init()
	inGameUI.score = 0
end

function inGameUI.draw()

	love.graphics.setFont(fonts.smallFont)
	love.graphics.setColor(0, 125, 75)
	love.graphics.print("Score: "..inGameUI.score, 10, 10)

	if gameState ~= 'over' then

		love.graphics.print("Health: ", 10, 40)
		-- calculate length of health bar.
		local len = 200 * player.health / 100
		love.graphics.rectangle('fill', 120, 55, len, 20)
		love.graphics.rectangle('line', 120, 55, 200, 20)
	end

	if gameState == 'over' then

		--red color and bigger font for game over message.
		love.graphics.setColor(255, 0, 0)
		love.graphics.setFont(fonts.bigFont)
		love.graphics.print("GAME OVER!!", 200, 240)

	elseif gameState == 'paused' then

		love.graphics.setColor(0, 0, 255)
		love.graphics.setFont(fonts.bigFont)
		love.graphics.print("Paused", 300, 240)

	end
end	

function DRAW_INGAMEUI()
	inGameUI.draw()
end