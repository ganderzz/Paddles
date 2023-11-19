import "CoreLibs/object"
import "CoreLibs/graphics"
import "config"


class("Menu").extends()

local gfx <const> = playdate.graphics
local clickSound = playdate.sound.fileplayer.new("sounds/click")

function Menu:init(sprite)
    Menu.super.init(self)
    self.bg = gfx.image.new("images/title.png")
    self.continue = gfx.image.new("images/continue.png")

    self.bg = self.bg:scaledImage(.28)
    self.continue = self.continue:scaledImage(.8)
end

function Menu:update(sceneManager) 
    self.bg:draw(55, -10)
    self.continue:draw(60, 190)

    if playdate.buttonJustPressed(playdate.kButtonA) then
        clickSound:play(1)
        sceneManager:changeScene("GAME")
    end
end