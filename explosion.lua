require 'constants'
require 'AnAL'

explosion = {}

function explosion.load()
	 -- Load the animation source.
   explosion.image  = love.graphics.newImage("Images/explosion.png")
end

function explosion.spawn(x, y)
	local a = newAnimation(explosion.image, EXPLOSION_SPRITE_WIDTH, EXPLOSION_SPRITE_HEIGHT, EXPLOSION_SPRITE_RATE, 0)
	
	table.insert(explosion, {x = x, y = y, timeElapsed = 0,
		anim = a})
end

function explosion.draw()
	love.graphics.setColor(255, 255, 255)
	for i, v in ipairs(explosion) do
		v.anim:draw(v.x, v.y)
	end
end

function explosion.update(dt)
	for i, v in ipairs(explosion) do
		v.anim:update(dt)
		v.timeElapsed = v.timeElapsed + dt
	end
end

-- remove explosins that have finished.
function explosion.remove()
	for i, v in ipairs(explosion) do
		if v.timeElapsed > EXPLOSION_TIME then
			table.remove(explosion, i)
		end
	end
end

--PARENT FUNCTIONS
function DRAW_EXPLOSION()
	explosion.draw()
end

function UPDATE_EXPLOSION(dt)
	explosion.remove()
	explosion.update(dt)
end

