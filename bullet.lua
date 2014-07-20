require 'constants.lua'

bullet = {}

function bullet.spawn(x, y, dir)
	table.insert(bullet, {x = x, y = y, dir = dir})
end

function bullet.draw()
	love.graphics.setColor(255, 255, 0)
	for i, v in ipairs(bullet) do
		love.graphics.rectangle('fill', v.x, v.y, BULLET_WIDTH, BULLET_HEIGHT)
	end
end

function bullet.move(dt)
	for i, v in ipairs(bullet) do
		if gameObject.isOutsideScreen(v) then
			table.remove(bullet, i)
		elseif v.dir == 'right' then
			v.x = v.x + BULLET_SPEED * dt
		end
	end
end

function bullet.remove(i)
	table.remove(bullet, i)
end

--PARENT FUNCTIONS
function DRAW_BULLET()
	bullet.draw()
end
function UPDATE_BULLET(dt)
	bullet.move(dt)
end
