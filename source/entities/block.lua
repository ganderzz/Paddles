import "CoreLibs/object"
import "CoreLibs/graphics"
import "config"
import "gameObject"
import "utils/collisions"

local gfx <const> = playdate.graphics
local blockHitSound <const> = playdate.sound.fileplayer.new("sounds/blockDestroy")

class("Block").extends(GameObject)

function Block:init(x, y, width, height)
    self.id = playdate.string.UUID(4)

    width = width or 8
    height = height or 40

    Block.super.init(self, x, y, width, height)

    self.sprite = gfx.image.new(width, height)
    gfx.pushContext(self.sprite)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 0, self.width, self.height)
    gfx.popContext()

    self:setImage(self.sprite)
    self:setCollideRect(0, 0, self:getSize())
    self:setTag(CollisionGroup.Block)
    self:moveTo(x, y)
    self:add()
end

function Block:hit()
    blockHitSound:play(1)
    GLOBAL_DATA.bricksDestroyed = GLOBAL_DATA.bricksDestroyed + 1
    self:remove()
    SceneManager.currentScene:removeBlock(self.id)
end
