import "CoreLibs/object"
import "CoreLibs/graphics"
import "config"
import "position"


class("Player").extends(Position)

local gfx <const> = playdate.graphics
local startingX <const> = 12
local startingY <const> = ScreenCenter.y
local width <const> = 8
local height <const> = 40

function Player:init(sprite)
    Player.super.init(self, startingX, startingY, width, height)
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
    gfx.fillRoundRect(self.pos.x, self.pos.y, width, height, 3)
end