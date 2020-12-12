

--objek musuh
Musuh = Class{}

--gambar 
function Musuh:init()
--properties objek pesawat
    self.image=love.graphics.newImage('aset/musuh.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRT_WIDTH / 2 + 100
    self.y = VIRT_HEIGHT/2

end

function Musuh:update(dt)
    if self.y < 0 then
        self.y = 0
    end
    if self.x < 0 then
        self.x = 0
    end
    if (self.x + self.width) >= VIRT_WIDTH then
        self.x = VIRT_WIDTH - self.width
    end
    if (self.y+self.height) >= VIRT_HEIGHT then
        self.y= VIRT_HEIGHT - self.height
    end
    
end

function Musuh:render()
    love.graphics.draw(self.image,self.x , self.y )
end
