-- By Christopher Flores
-- Started on 2/26/2026

--game where animals fall from top player clicks
--before hit the bottom
--game ends when animal hits bottom
function love.load()
    chickenFace = love.graphics.newImage("orb_red.png") -- Change this to my image file name for chickenFace
    backgroundImage = love.graphics.newImage("wizardtower.png") -- Change this to my image file name for backgroundImage
    powerupImage = love.graphics.newImage("orb_blue.png") -- Change this to my image file name for powerupImage
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    startx = {math.random(0, love.graphics.getWidth() - chickenFace:getWidth()),
    math.random(0, love.graphics.getWidth() - chickenFace:getWidth()),
    math.random(0, love.graphics.getWidth() - chickenFace:getWidth()),
    math.random(0, love.graphics.getWidth() - chickenFace:getWidth()),
    math.random(0, love.graphics.getWidth() - chickenFace:getWidth())}

    starty = {0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
    0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
    0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
    0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
    0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2)}

    -- powerup spawns at random x and y, but is not active until player clicks it
    powerupX = math.random(0, love.graphics.getWidth() - powerupImage:getWidth())
    powerUpY = math.random(50, love.graphics.getHeight() - 200)
    powerupActive = true
end
-------------------------------------------------
--MOUSE PRESS
--1 = left, 2 = right, 3 = middle wheel
-------------------------------------------------
function love.mousepressed(x, y, button, istouch)
    if button == 1 then

        --print("left mouse clicked")
        -- Check if the powerup is active and if the mouse click is on the powerup 
        for i, v in ipairs(startx) do
            if powerupActive and
            x >= powerupX and x <= powerupX + powerupImage:getWidth() and
            y >= powerUpY and y <= powerUpY + powerupImage:getHeight() then
                -- Collect all chickens on the screen
                for i, v in ipairs(starty) do
                    starty[i] = math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2) * -1
                end
                powerupActive = false -- Deactivate the powerup after use
            end

            --if the mouse x and y is within the boundary of a chicken picture
            if x >= startx[i] and x <= startx[i] + chickenFace:getWidth() and y >=
            starty[i] and y <= starty[i] + chickenFace:getHeight() then
            --print("in bounds")
            math.randomseed(os.time())
            math.random(); math.random(); math.random()
            --reset its y value (go back to the top)
            starty[i] = math.random(chickenFace:getHeight(), chickenFace:getHeight() *
            2) * -1
            end
        end
    end
end
-------------------------------------------------
--UPDATE
-------------------------------------------------
function love.update(dt)
    for i, v in ipairs(starty) do
        --if chicken hits the bottom of the screen, lua quits (we lose)
        if starty[i] + chickenFace:getHeight() >= love.graphics.getHeight() then
        --print("over the edge")
        love.event.quit()
        end
    --chickens move down
    starty[i] = starty[i] + 80 * dt
    end
end
-------------------------------------------------
--DRAW
-------------------------------------------------
function love.draw()
    love.graphics.draw(backgroundImage, 0, 0)
    --draw each chicken at their respective x and y
    for i, v in ipairs(startx) do
    love.graphics.draw(chickenFace, startx[i], starty[i])
    end

    -- Draw the powerup if it is active
    if powerupActive then
        love.graphics.draw(powerupImage, powerupX, powerUpY, 0, 0.5, 0.5)
    end
end