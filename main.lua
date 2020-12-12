
-- push
push = require 'push/push'
Class = require 'class'

require 'Pesawat'
require 'Musuh'

-- spawn / musuh nongol
spawntimer = 1
spawncounter = 0

skor = 0
level = 1

gamestate = 'mulai'

--array atau table
arrayMusuh = {}

--ukuran resolusi layar komputer aslinya
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--ukuran resolusi layar komputer virtual
VIRT_WIDTH = 432
VIRT_HEIGHT = 243
KECEPATAN = 4

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]

function reset()
    gamestate = 'mulai'
    pesawatku = Pesawat()
    arrayMusuh={}
end


function love.load()

    math.randomseed(os.time())
    --musuhku = Musuh()
    reset()

    suara = {
        ['ledak']=love.audio.newSource('aset/ledakan.wav','static'),
        ['bgmusic']=love.audio.newSource('aset/backgroundmusic.ogg','static')
    }

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

    suara['bgmusic']:setLooping(true)
    suara['bgmusic']:play()
end

function love.keypressed(tombol)
    if tombol=='escape' then
        love.event.quit()
    elseif tombol=='enter' or tombol=='return' then
        --gamestate mulai
        if gamestate=='mulai' then
            gamestate='main'
        elseif gamestate=='gameover' then
            gamestate='mulai'
            reset()
        --gamestate gameover
        end
    end


end

--selalu dipangil berulang
function love.update(dt)
    if gamestate=='main' then
        if love.keyboard.isDown('up') then
            pesawatku.y = pesawatku.y - KECEPATAN
        elseif love.keyboard.isDown('down') then
            pesawatku.y = pesawatku.y + KECEPATAN
        elseif love.keyboard.isDown('right') then
            pesawatku.x = pesawatku.x + KECEPATAN
        elseif love.keyboard.isDown('left') then
            pesawatku.x = pesawatku.x - KECEPATAN
        end

        spawncounter = spawncounter + dt
        if spawncounter > spawntimer then
            table.insert(arrayMusuh,Musuh())
            spawncounter = 0
        end

        pesawatku:update(dt)
        for k, musuhku in pairs (arrayMusuh) do
            musuhku:update(dt)
            musuhku:tabrakan(pesawatku)
        end

        if skor < 10 then   
            level = 1
        elseif (skor >10) and (skor < 20)
        then
            level = 2
        end
    end
end


--[[
    Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    push:apply('start')
    love.graphics.clear(240,240,240,255)
-- tampilkan teks
    if gamestate=='mulai' then
        layarpembukaan()
    elseif gamestate=='main' then
        tampilkantext()
        pesawatku:render()
        for k, musuhku in pairs (arrayMusuh) do
            musuhku:render()
        end
    elseif gamestate=='gameover' then
        layargameover()
    end
    push:apply('end')
end

 
function tampilkantext()
    love.graphics.setColor(0,230,0,255)
    love.graphics.print('Skor : ' .. tostring(skor), 20, 10) 
    love.graphics.print('Level : ' .. tostring(level), VIRT_WIDTH-60, 10) 
    love.graphics.print('Nama: Saya ', 20, VIRT_HEIGHT - 50 )
    love.graphics.print('NIM: 19280122 ', VIRT_WIDTH-100, VIRT_HEIGHT - 50 )

    love.graphics.setColor(240,240,240,255)

end

function layarpembukaan()
    love.graphics.setColor(0,230,0,255)
    love.graphics.print('Game Belajar', VIRT_WIDTH/2 - 50, 40) 
    love.graphics.print('Tekan ENTER untuk mulai... ' , VIRT_WIDTH/2 - 80, VIRT_HEIGHT/2 + 10)

    love.graphics.setColor(240,240,240,255)

end

function layargameover()
    love.graphics.setColor(0,230,0,255)
    love.graphics.print('Game OVER', VIRT_WIDTH/2 - 50, 40) 
    love.graphics.print('Tekan ENTER untuk mulai... ' , VIRT_WIDTH/2 - 80, VIRT_HEIGHT/2 + 10)
    love.graphics.setColor(240,240,240,255)
end

