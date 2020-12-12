KECEPATANMUSUH = 5

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
    self.dx = math.random(level, level*3)
    self.mati = false
end

function Musuh:update(dt)
    if self.x < 0 then --musuh mencapai dinding kiri 
        self.x = 0
        if self.mati==false then
            skor = skor + 1
            self.mati = true
        end
    end
    self.dx = self.dx + dt * math.random(0,KECEPATANMUSUH)
    self.x = self.x - self.dx
end

function Musuh:tabrakan(lawan)
    if lawan.mati==false then
        if self.x < (lawan.x + lawan.width) then -- milik si musuh
            if (self.y < (lawan.y+lawan.height)) and ((self.y+self.height)>lawan.y) then
                --tabrakan
                self.mati = true
                lawan.mati= true
                return true
            end
        end
    end
end

function Musuh:render()
    if self.x > 0 then
        if self.mati==false then
            love.graphics.draw(self.image,self.x , self.y )
        end
    end
end
