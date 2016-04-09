anim8 = require 'anim8'

function love.load(arg)

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    -- loads the two backgrounds and the player
    backgroundimg = love.graphics.newImage('assets/background.jpg')

    local playerFrameX = 250
    local playerFrameY = 120
    local playerImage = love.graphics.newImage('assets/idle.png')
    local g = anim8.newGrid(playerFrameX, playerFrameY, playerImage:getWidth(), playerImage:getHeight())
    animation = anim8.newAnimation(g(1,'1-60', 1, '60-1'), (1 / 25))

    bunnyImg = love.graphics.newImage('assets/bunny.png')

    offsetX = playerFrameX / 2
    offsetY = playerFrameY / 2

    player = {
        x = offsetX,
        y = 504,
        image = playerImage,
        heading = 0,
        velX = 1,
        velY = 1,
        acceleration = 20,
    }

    startingX = player.x
    startingY = player.y

    --set the count
    --set the count
    mousepos = 0
    jump = false
    firstloop = true
    launchvel = 0
    mousex = 1
    mousey = 1
    angledeg = 0

end

--draws the objects we loaded above and prints the info I want
function love.draw(dt)
    love.graphics.draw(backgroundimg)
    love.graphics.draw(bunnyImg, 900, 500)
    animation:draw(player.image, player.x, player.y, 0, 1, 1, offsetX, offsetY)

    love.graphics.print("X Mouse Position: " .. xmousepos, 200, 20)
    love.graphics.print("Y Mouse Position: " .. ymousepos, 200, 40)
    love.graphics.print("End x Pos: " .. mousex, 200, 60)
    love.graphics.print("End y Pos: " .. mousey, 200, 80)
    love.graphics.print("Velocity: " .. velocity, 200, 100)
    love.graphics.print("Angle: " .. angle, 200, 120)
    love.graphics.print("Xposition: " .. player.x, 350, 20)
    love.graphics.print("Yposition: " .. player.y, 350, 40)
    love.graphics.print("Heading  : " .. player.heading, 350, 60)

    love.graphics.print("LaunchVel:  " .. launchvel, 650, 20)
    love.graphics.print("Yvel:       " .. player.velY, 650, 50)
    love.graphics.print("xvel:       " .. player.velX, 650, 70)
    love.graphics.print("degangle:       " .. degangle, 650, 90)

    if jump then
        love.graphics.print("Jumping", 50, 210)
    end

    love.graphics.line(startingX, startingY, mousex, mousey)
end

-- Updating
function love.update(dt)
    animation:update(dt)
	-- I always start with an easy way to exit the game
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

    xmousepos = love.mouse.getX()
    ymousepos = love.mouse.getY()

    velocity = (math.dist(offsetX,offsetY,mousex,mousey))
    angle = (math.angle(offsetX,offsetY,mousex,mousey))

    degangle = math.deg(angle)

    if jump then
      player.img = love.graphics.newImage('assets/flying.png')

      -- radsin = math.sin(angle)
      -- degsin = math.deg(radsin)
      --
      -- radcos = math.cos(angle)
      -- degcos = math.deg(radcos)

      if firstloop then
        player.velY = 3*(startingY - mousey)
        player.velX = 2*(mousex - startingX)
        firstloop = false
      else
        player.velY = player.velY + (-1500 * dt)

      -- player.velX = (radsin * player.acceleration * dt)
    	-- player.velY = (radcos * -player.acceleration * dt)

      -- player.velX = (player.velX * player.acceleration * dt)
    	-- player.velY = (player.velY * -player.acceleration * dt)
      moveFox(dt)
   end

    end
end

function moveFox(dt)
    player.x = player.x + player.velX * dt
    player.y = (player.y - player.velY * dt)

end

--gets the position of mouse release
function love.mousereleased(x, y, button)
   if button == 1 then
      mousex = x
      mousey = y
      jump = true
      animation:pause()
   end
end

function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

function math.dist(x1,y1, x2,y2)
        return ((x2-x1)^2+(y2-y1)^2)^0.5
end
