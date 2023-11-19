import "CoreLibs/object"
import "CoreLibs/graphics"
import "config"
import "position"

class("Ball").extends(Position)

local gfx <const> = playdate.graphics
local radius <const> = 6

function Ball:init(sprite)
    Ball.super.init(self, ScreenCenter.x, ScreenCenter.y, radius)
    self.speed = { x = 3, y = 2 } -- { x = math.random(-3, 3), y = math.random(1, 3) }
end

function Ball:update(sceneManager, collision) 
    if collision then
        self.speed.x = -self.speed.x
    end

    if self:collidesYScreen() then
        self.speed.y = -self.speed.y
    elseif self:collidesXScreen() then
        self.speed.x = -self.speed.x
    end

    self.pos.x = self.pos.x + self.speed.x
    self.pos.y = self.pos.y + self.speed.y

    gfx.setColor(gfx.kColorWhite)
    gfx.fillCircleAtPoint(self.pos.x, self.pos.y, self.width)
end

function Ball:collidesYScreen()
    return self.pos.y > ScreenHeight - radius or self.pos.y < radius
end

function Ball:collidesXScreen()
    return self.pos.x > ScreenWidth - radius or self.pos.x < radius
end