require 'constants.lua'

gameObject = {}

function gameObject.isOutsideScreen(v)
	return v.x < 0 or v.x > WINDOW_WIDTH or v.y < 0 or v.y > WINDOW_HEIGHT
end

-- contain the enemy inside the screen, bounce off the screen boundaries.
function gameObject.contain(v, width, height)
	if v.y + height > WINDOW_HEIGHT then
		v.y = WINDOW_HEIGHT - height
		v.vel_y = -v.vel_y
	end
	if v.x + width > WINDOW_WIDTH then
		v.x = WINDOW_WIDTH - width
		v.vel_x = -v.vel_x
	end
	if v.y < 0 then
		v.y = 0
		v.vel_y = -v.vel_y
	end
	if v.x < 0 then
		v.x = 0
		v.vel_x = -v.vel_x
	end
end

-- does an object collide with another?
function gameObject.getCollisionVector(x1, y1, width1, height1, x2, y2, width2, height2)

	local vel_x, vel_y

	vel_x, vel_y = 0, 0

	if x1 + width1 > x2 and y1 + height1 > y2 and x1 < x2 + width2 and y1 < y2 + height2 then

		if y1 < y2 then
			vel_y = y1 + height1 - y2
		else 
			vel_y = y1 - y2 - height2
		end

		if x1 < x2 then
			vel_x = x1 + width1 - x2
		else 
			vel_x = x1 - x2 - width2
		end
	end

	return vel_x, vel_y
end

function gameObject.bounce(v, bounce_x, bounce_y)
	v.vel_x = v.vel_x + bounce_x
	v.vel_y = v.vel_y + bounce_y
end