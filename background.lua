require 'constants.lua'

background = {}

function background.init()
	background.imageWidth = background.image:getWidth()
	background.x = 0
end

function background.load()
	background.image = love.graphics.newImage('Images/background.png')
end

-- implement parallax background
function background.update(dt)
	-- translate the background to the left and contain its value within the width.
	background.x = (background.x + BACKGROUND_VEL_X * dt) % background.imageWidth
end

function background.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(background.image, -background.x, 0)

	--if the end of the image is within the screen draw the image at the tail of the previous image.
	local tail = -background.x + background.imageWidth
	if tail < WINDOW_WIDTH then
		love.graphics.draw(background.image, tail, 0)
	end
end

-- PARENT FUNCTIONS

function UPDATE_BACKGROUND(dt)
	background.update(dt)
end

function DRAW_BACKGROUND()
	background.draw()
end