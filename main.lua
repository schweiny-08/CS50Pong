--Runs when game first starts up

push = require 'push' --getting lib from LOVE 

--Below sets window size
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

PADDLE_SPEED = 200

--Virtual dimensions are the dimensions at what the graphics are rendered
--ie lower virtual dimensions make the graphics zoomed in
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    --Declare new font using pixelFont and declaring size
    smallFont = love.graphics.newFont('pixelFont.ttf', 10)

    --New font for score
    scoreFont = love.graphics.newFont('pixelFont.ttf', 30)

    --Set the active font to smallFont object
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    --Initialize player scores
    playerScore1 = 0
    playerScore2 = 0

    --paddle positions on y axis
    paddle1 = 30
    paddle2 = VIRTUAL_HEIGHT-50

    --Ball position
    ballX = VIRTUAL_WIDTH/2-2
    ballY = VIRTUAL_HEIGHT/2-2

    ballDeltaX = math.random(2) == 1 and 100 and -100
    ballDeltaY = math.random(-50, 50) 

    --Used to transition between different parts of the game eg: menu, actual game, etc
    gameState = 'start'
end

function love.update(dt)
    --Player 1
    if love.keyboard.isDown('w')then
        paddle1 = math.max(0, paddle1 + -PADDLE_SPEED*dt)
    elseif love.keyboard.isDown('s')then
        paddle1 = math.min(VIRTUAL_HEIGHT-20, paddle1 + PADDLE_SPEED*dt)
    end

    --Player 2
    if love.keyboard.isDown('up')then
        paddle2 = math.max(0, paddle2 + -PADDLE_SPEED*dt)
    elseif love.keyboard.isDown('down')then
        paddle2 = math.min(VIRTUAL_HEIGHT-20, paddle2 + PADDLE_SPEED*dt)
    end

    --Update ball by delta x and y ONLY IF GAMESTATE IS PLAY
    --Scale velocity by Delta Time so movement is framerate-independent
    if gameState == 'play'then
        ballX = ballX + ballDeltaX * dt
        ballY = ballY + ballDeltaY * dt
    end
end

--Called whenever a key is pressed
function love.keypressed(key)
    --keys can be accessed by string name ie: escape
    if key == 'escape' then
        love.event.quit() --terminated application
    elseif key = 'enter' or key == 'return'then
        if gameState == 'start'then
            gameState = 'play'
        else
            gameState = 'start'

            --Below resets game back to start
            ballX = VIRTUAL_WIDTH/2-2
            ballY = VIRTUAL_HEIGHT/2-2

            ballDeltaX = math.random(2) == 1 and 100 and -100
            ballDeltaY = math.random(-50, 50) * 1.5
        end
    end
end

--called after update to draw on screen

function love.draw()

    push:apply('start')

    --Clear screen with this colour
    love.graphics.clear(0/255, 139/255, 139/255, 1)

    love.graphics.setFont(smallFont)
    love.graphics.printf(
        'Hello Pong Game!', --Text to be displayed
        0,                  --STARTING X It is gna be centered in aligned; so set to 0
        20,   --STARTING Y font default size is 12 high so -6 to be centered
        VIRTUAL_WIDTH,       --width of the text
        'center'            --hpw we want it aligned    
    )

    --Draw player scores
    love.graphics.setFont(scoreFont)

    love.graphics.print(tostring(playerScore1), VIRTUAL_WIDTH/2-50, VIRTUAL_HEIGHT/3)
    
    love.graphics.print(tostring(playerScore2), VIRTUAL_WIDTH/2+30, VIRTUAL_HEIGHT/3)

    --Below renders the paddles
    --Left paddle
    love.graphics.rectangle('fill', 10, paddle1, 5, 20)

    --Right paddle
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, paddle2, 5, 20)

    --Ball
    love.graphics.rectangle('fill', ballX, ballY,4,4)

    push:apply('end')
end