import "CoreLibs/object"
import "CoreLibs/graphics"
import "config"
import "gameObject"
import "utils/collisions"

class("Ball").extends(GameObject)

local gfx <const> = playdate.graphics
local radius <const> = 6

function Ball:init()
    Ball.super.init(self, ScreenCenter.x, ScreenCenter.y, radius)
    self.speed = 4
    self.velocity = { x = self.speed, y = 0 }

    local circleImage = gfx.image.new(radius * 2, radius * 2)
    gfx.pushContext(circleImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillCircleAtPoint(radius, radius, radius)
    gfx.popContext()

    self:setImage(circleImage)
    self:setCollideRect(0, 0, self:getSize())
    self:setTag(CollisionGroup.Ball)
    self:moveTo(ScreenCenter.x, ScreenCenter.y)
    self:add()
end

function Ball:update()
    if not IS_GAME_ACTIVE then
        return
    end

    if self:collidesYScreen() then
        self.velocity.y = -self.velocity.y
    elseif self:collidesXScreen() then
        self.velocity.x = -self.velocity.x
    end

    self.x = self.x + self.velocity.x
    self.y = self.y + self.velocity.y

    local _, _, collisions, numberOfCollisions = self:moveWithCollisions(self.x, self.y)

    for i=1, numberOfCollisions do
        local collision = collisions[i]

        local coords = collision.touch
        local other = collision.other
        local collisionTag = other:getTag()

        if collisionTag == CollisionGroup.Player then
            local intersection = other.y - coords.y
            local normalizeY = intersection / (other.height / 2)
            local bounceAngle = normalizeY * (math.pi / 10)

            self.velocity.x = math.cos(bounceAngle) * self.speed
            self.velocity.y = math.sin(bounceAngle) * self.speed
        end

        if collisionTag == CollisionGroup.Block then
            other:hit()

            if collision.normal.x ~= 0 then
                self.velocity.x = -self.velocity.x
            end
            if collision.normal.y ~= 0 then
                self.velocity.y = -self.velocity.y
            end
        end
    end
end

function Ball:collidesYScreen()
    return self.y > ScreenHeight - radius or self.y < radius
end

function Ball:collidesXScreen()
    return self.x > ScreenWidth - radius or self.x < radius
end
