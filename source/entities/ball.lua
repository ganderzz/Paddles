import "CoreLibs/object"
import "CoreLibs/graphics"
import "config"
import "gameObject"

class("Ball").extends(GameObject)

local gfx <const> = playdate.graphics
local radius <const> = 6

function Ball:init(directionX, directionY)
    Ball.super.init(self, ScreenCenter.x, ScreenCenter.y, radius)
    self.speed = { x = directionX or 3, y = directionY or 2 }

    local circleImage = gfx.image.new(radius * 2, radius * 2)
    gfx.pushContext(circleImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillCircleAtPoint(radius, radius, radius)
    gfx.popContext()

    self:setImage(circleImage)
    self:setCollideRect(0, 0, self:getSize())
    self:moveTo(ScreenCenter.x, ScreenCenter.y)
    self:add()
end

function Ball:update()
    local collisions = self:overlappingSprites()
    if #collisions > 0 then
        self.speed.x = -self.speed.x
    end

    if self:collidesYScreen() then
        self.speed.y = -self.speed.y
    elseif self:collidesXScreen() then
        self.speed.x = -self.speed.x
    end

    self.x = self.x + self.speed.x
    self.y = self.y + self.speed.y

    self:moveTo(self.x, self.y)
end

function Ball:collidesYScreen()
    return self.y > ScreenHeight - radius or self.y < radius
end

function Ball:collidesXScreen()
    return self.x > ScreenWidth - radius or self.x < radius
end
