-- load functions
function love.load()

    -- Background color
    love.graphics.setBackgroundColor(0.3, 0.1, 0.9)

    -- Empty tables for bullet
    bullets = {}
    bulletSpeed = 300

    -- player table with position and size
    player = {x = 250, y = 150, width = 15, height = 15}

    -- create a monster
    monster = {x = 500, y = 500, width = 15, height = 15}

    -- Set the random seed
    math.randomseed(os.time())
end

-- update functions
function love.update(dt)

    -- Looping through bullets object
    for i,v in ipairs(bullets) do
        -- Move the bullets
        v.y = v.y + (v.dy * dt)
        v.x = v.x + (v.dx * dt)

        -- Remove the bullet if it goes off the screen
        if v.y < 0 then
            table.remove(bullets, i)
        end

        -- Check for collision with the monster
        if v.x >= monster.x and v.x <= (monster.x + monster.width) and
              v.y >= monster.y and v.y <= (monster.y + monster.height) then
                -- If there is a hit, remove the bullet and move the monster to a new random position
                table.remove(bullets, i)
                monster.x = math.random(0, love.graphics.getWidth() - monster.width)
                monster.y = math.random(0, love.graphics.getHeight() - monster.height)
          end
        end 

    -- player movement
    -- D is right, postitive
    if love.keyboard.isDown("d") then
        player.x = player.x + 50 * dt
    end
    -- A is left, negative
    if love.keyboard.isDown("a") then
        player.x = player.x - 50 * dt
    end
    -- W is up, negative
    if love.keyboard.isDown("w") then
        player.y = player.y - 50 * dt
    end
    -- S is down, positive
    if love.keyboard.isDown("s") then
        player.y = player.y + 50 * dt
    end
end

-- draw functions
function love.draw()
    -- set color to white
    love.graphics.setColor(1, 1, 1) -- Set color to white
    -- Draw the player as a rectangle
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

    -- set color to red
    love.graphics.setColor(1, 0, 0) -- Set color to red
    -- draw the bullets as circles
    -- use for loop because there will be multiple bullets, and we want to draw each one
    for i,v in ipairs(bullets) do
        love.graphics.circle("fill", v.x, v.y, 3)
    end

    -- Set color of monster to green
    love.graphics.setColor(0, 1, 0) -- Set color to green
    -- Draw the monster as a rectangle
    love.graphics.rectangle("fill", monster.x, monster.y, monster.width, monster.height)
end

-- Moused pressed function to shoot bullets towards the mouse position when the left mouse button is clicked
function love.mousepressed(x, y, button)
    if button == 1 then -- Left mouse button
    
        -- Calculate the starting position of the bullet (the center of the player)
        local startX = player.x + player.width / 2
        local startY = player.y + player.height / 2

        -- Get the mouse position
        local mouseX = x
        local mouseY = y

        -- Calculate the angle
        local angle = math.atan2(mouseY - startY, mouseX - startX)

        local bulletDx = bulletSpeed * math.cos(angle)
        local bulletDy = bulletSpeed * math.sin(angle)

        -- Creating a new bullet and adding it to the bullets table
        table.insert(bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy})
    end
end