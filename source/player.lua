import "CoreLibs/object"
import "CoreLibs/graphics"
import "config"

class("Player").extends()

local gfx <const> = playdate.graphics
local width <const> = 8
local height <const> = 40

function Player:init(sprite)
    Player.super.init(self)

    self.pos = { x = 12, y = ScreenCenter.y }
    self.speed = { x = 2, y = 1.6 }
end

function Player:update() 
    local change, _ = playdate.getCrankChange()
    
    self.pos.y = self.pos.y - ((change * self.speed.y))

    if self.pos.y > ScreenHeight + height then
        self.pos.y = -height
    elseif self.pos.y < -height then
        self.pos.y = ScreenHeight + height
    end

    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(self.pos.x, self.pos.y, width, height)
end