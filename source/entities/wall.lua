import "CoreLibs/object"
import "CoreLibs/graphics"
import "config"
import "gameObject"
import "utils/collisions"

local gfx <const> = playdate.graphics
local blockHitSound <const> = playdate.sound.fileplayer.new("sounds/hit")

class("Wall").extends(GameObject)

function Wall:init(x, y, width, height)
    width = width or 8
    height = height or 40

    Wall.super.init(self, x, y, width, height)

    self.sprite = gfx.image.new(width, height)
    gfx.pushContext(self.sprite)
    -- Set fill
    gfx.setDitherPattern(0.5, gfx.image.kDitherTypeBayer8x8)
    gfx.fillRect(0, 0, self.width, self.height)
    -- Add a border
    gfx.setColor(gfx.kColorWhite)
    gfx.drawRect(0, 0, self.width, self.height)
    gfx.popContext()

    self:setImage(self.sprite)
    self:setCollideRect(0, 0, self:getSize())
    self:setTag(CollisionGroup.Wall)
    self:moveTo(x, y)
    self:add()
end

function Wall:hit()
    blockHitSound:play(1)
end
