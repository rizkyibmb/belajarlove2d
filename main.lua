
-- push
push = require 'push/push'
Class = require 'class'

require 'Pesawat'
require 'Musuh'

--ukuran resolusi layar komputer aslinya
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--ukuran resolusi layar komputer virtual
VIRT_WIDTH = 432
VIRT_HEIGHT = 243
KECEPATAN = 10

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()

    pesawatku = Pesawat()
    musuhku = Musuh()

    push:setupScreen(VIRT_WIDTH,VIRT_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,    
        resizable = true,  
        vsync = true
    })

    -- love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    --     fullscreen = false,
    --     resizable = false,
    --     vsync = true
    -- })
end

function love.keypressed(tombol)
    if tombol=='escape' then
        love.event.quit()
    end

end

function love.update(dt)
    if love.keyboard.isDown('up') then
        pesawatku.y = pesawatku.y - KECEPATAN
    elseif love.keyboard.isDown('down') then
        pesawatku.y = pesawatku.y + KECEPATAN
    elseif love.keyboard.isDown('right') then
        pesawatku.x = pesawatku.x + KECEPATAN
    elseif love.keyboard.isDown('left') then
        pesawatku.x = pesawatku.x - KECEPATAN
    end

    pesawatku:update(dt)

end


--[[
    Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    push:apply('start')
    love.graphics.clear(240,240,240,255)
-- tampilkan teks
    tampilkantext()
    pesawatku:render()
    musuhku:render()
    push:apply('end')

end


function tampilkantext()
    love.graphics.setColor(0,230,0,255)
    love.graphics.print('Skor :', 20, 10) 
    love.graphics.print('Level :', VIRT_WIDTH-60, 10) 
    love.graphics.print('Nama: Saya ', 20, VIRT_HEIGHT - 50 )
    love.graphics.print('NIM: 19280122 ', VIRT_WIDTH-100, VIRT_HEIGHT - 50 )

    love.graphics.setColor(240,240,240,255)

end
