require 'fonts'

menu = {}

function menu.load(options)
	menu.options = options

	menu.bgImage = love.graphics.newImage('Images/menu-bg.jpg')
	menu.selectedOption = 1
end

function menu.draw()

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(menu.bgImage, 0, 0)

	love.graphics.setFont(fonts.bigFont)
	love.graphics.setColor(255, 0, 0)
	love.graphics.print("! PAANTHE !", 200, 100)

	love.graphics.setFont(fonts.smallFont)

	for i, option in ipairs(menu.options) do

		if i == menu.selectedOption then
			love.graphics.setColor(255, 255, 0)
		else
			love.graphics.setColor(0, 255, 0)
		end

		love.graphics.print(option, 230, 200 + i * 100)
	end
end

function menu.next()
	menu.selectedOption = menu.selectedOption + 1
	if menu.selectedOption > #menu.options then
		menu.selectedOption = 1
	end
end

function menu.previous()
	menu.selectedOption = menu.selectedOption - 1
	if menu.selectedOption < 1 then
		menu.selectedOption = #menu.options
	end
end

function menu.update(dt)
end

-- PARENT FUNCTIONS
function DRAW_MENU()
	menu.draw()
end

function UPDATE_MENU(dt)
	menu.update(dt)
end
