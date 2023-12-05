import "CoreLibs/object"
import "CoreLibs/graphics"
import "config"
import "gameObject"
import "utils/collisions"

local gfx <const> = playdate.graphics

local startingX <const> = 30
local startingY <const> = ScreenCenter.y
local width <const> = 8
local height <const> = 40

class("Player", { x = startingX, y = startingY }).extends(GameObject)

function Player:init()
    Player.super.init(self, startingX, startingY, width, height)

    self.velocity = playdate.geometry.vector2D.new(2, 1.6)

    self.sprite = gfx.image.new(width, height)
    gfx.pushContext(self.sprite)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(0, 0, self.width, self.height, 3)
    gfx.popContext()

    self:setImage(self.sprite)
    self:setCollideRect(0, 0, self:getSize())
    self:setTag(CollisionGroup.Player)
    self:moveTo(startingX, startingY)
    self:add()
end

function Player:update()
    if not IS_GAME_ACTIVE then
        return
    end
    local change, _ = playdate.getCrankChange()

    self.y = self.y - change * self.velocity.dy

    if self.y > ScreenHeight + height then
        self.y = -height
    elseif self.y < -height then
        self.y = ScreenHeight + height
    end

    self:moveTo(self.x, self.y)
end
