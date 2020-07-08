--[[Runs when game first starts up
    Below sets window size
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

--called after update to draw on screen

function love.draw()
    love.graphics.printf(
        'Hello Pong Game!', --Text to be displayed
        0,                  --STARTING X It is gna be centered in aligned; so set to 0
        WINDOW_HEIGHT/2-6,   --STARTING Y font default size is 12 high so -6 to be centered
        WINDOW_WIDTH,       --width of the text
        'center'            --hpw we want it aligned    
    )
end
