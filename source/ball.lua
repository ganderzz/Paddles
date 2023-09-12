import "CoreLibs/object"
import "CoreLibs/graphics"
import "config"

class("Ball").extends()

local gfx <const> = playdate.graphics
local radius <const> = 6

function Ball:init(sprite)
    Ball.super.init(self)

    self.pos = { x = ScreenCenter.x, y = ScreenCenter.y }
    self.speed = { x = 2, y = 1 }
end

function Ball:update() 
    self.pos.x = self.pos.x + self.speed.x
    self.pos.y = self.pos.y + self.speed.y

    if self.pos.y > ScreenHeight - radius or self.pos.y < radius then
        self.speed.y = -self.speed.y
    elseif self.pos.x > ScreenWidth - radius or self.pos.x < radius then
        self.speed.x = -self.speed.x
    end

    gfx.setColor(gfx.kColorWhite)
    gfx.fillCircleAtPoint(self.pos.x, self.pos.y, radius)
end