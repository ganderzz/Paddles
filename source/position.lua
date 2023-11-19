import "CoreLibs/object"

class("Position").extends()

function Position:init(x, y, width, height)
    Position.super.init(self)

    self.pos = { x = x or 0, y = y or 0 }
    self.width = width or 0
    self.height = height or width or 0
end