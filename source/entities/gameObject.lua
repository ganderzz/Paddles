import "CoreLibs/object"

local gfx <const> = playdate.graphics

class("GameObject").extends(gfx.sprite)

function GameObject:init(x, y, width, height)
    GameObject.super.init(self)

    self.x = x or 0
    self.y = y or 0
    self.width = width or 0
    self.height = height or width or 0
end
