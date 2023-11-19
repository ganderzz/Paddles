import "CoreLibs/object"
import "CoreLibs/graphics"
import "config"


class("Menu").extends()

local gfx <const> = playdate.graphics
local sound = playdate.sound.fileplayer.new("sounds/title")
local clickSound = playdate.sound.fileplayer.new("sounds/click")

function Menu:init(sprite)
    Menu.super.init(self)
    sound:setVolume(0)
    self.bg = gfx.image.new("images/title.png")
    self.continue = gfx.image.new("images/continue.png")
    sound:play()

    -- Fade in sound
    sound:setVolume(1, 1, 2)

    self.bg = self.bg:scaledImage(.28)
    self.continue = self.continue:scaledImage(.8)
end

function Menu:update(collision) 
    self.bg:draw(55, -10)
    self.continue:draw(60, 190)

    if playdate.buttonJustPressed(playdate.kButtonA) then
        clickSound:play(1)
        return false
    end

    return true
end