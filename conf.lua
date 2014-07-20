require 'constants.lua'

function love.conf(window)
	window.title = "Tutorial Game"
	window.screen.width = WINDOW_WIDTH
	window.screen.height = WINDOW_HEIGHT
	window.console = true
end