--Runs when game first starts up

push = require 'push' --getting lib from LOVE 

--Below sets window size
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--Virtual dimensions are the dimensions at what the graphics are rendered
--ie lower virtual dimensions make the graphics zoomed in
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --Declare new font using pixelFont and declaring size
    smallFont = love.graphics.newFont('pixelFont.ttf', 10)

    --Set the active font to smallFont object
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

--Called whenever a key is pressed
function love.keypressed(key)
    --keys can be accessed by string name ie: escape
    if key == 'escape' then
        love.event.quit() --terminated application
    end
end

--called after update to draw on screen

function love.draw()

    push:apply('start')

    --Clear screen with this colour
    love.graphics.clear(0/255, 139/255, 139/255, 1)

    love.graphics.printf(
        'Hello Pong Game!', --Text to be displayed
        0,                  --STARTING X It is gna be centered in aligned; so set to 0
        20,   --STARTING Y font default size is 12 high so -6 to be centered
        VIRTUAL_WIDTH,       --width of the text
        'center'            --hpw we want it aligned    
    )

    --Below renders the paddles
    --Left paddle
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    --Right paddle
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT-50, 5, 20)

    --Ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2-2, VIRTUAL_HEIGHT/2-2,4,4)

    push:apply('end')
end