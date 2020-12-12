KECEPATANMUSUH = 20

--objek musuh
Musuh = Class{}

--gambar 
function Musuh:init()
--properties objek pesawat
    self.image=love.graphics.newImage('aset/musuh.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRT_WIDTH - self.width
    self.y = math.random (20,VIRT_HEIGHT - 20)
    -- dx = delta x, atau selisih x
    self.dx = 1
end

function Musuh:update(dt)
    if self.x < 0 then
        self.x = 0
        -- hilang
    end
    
    self.dx = self.dx + dt * math.random(0,KECEPATANMUSUH)
    self.x = self.x - self.dx

    
end

function Musuh:render()
    if self.x > 0 then
        love.graphics.draw(self.image,self.x , self.y )
    end
end
