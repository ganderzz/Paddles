import "scene"

local gfx <const> = playdate.graphics

local sound <const> = playdate.sound.fileplayer.new("sounds/title")
local clickSound <const> = playdate.sound.fileplayer.new("sounds/click")

class("MenuScene").extends(gfx.sprite)

function MenuScene:init()
    gfx.clear()
    gfx.setBackgroundColor(gfx.kColorBlack)

    sound:setVolume(0)
    sound:play()
    -- Fade in sound
    sound:setVolume(1, 1, 5)

    local bg = gfx.sprite.new(gfx.image.new("images/title.png"))
    bg:setScale(0.25)
    bg:moveTo(ScreenCenter.x, ScreenCenter.y)
    bg:setZIndex(1)
    bg:add()

    local continue = gfx.sprite.new(gfx.image.new("images/continue.png"))
    continue:setScale(0.8)
    continue:moveTo(ScreenCenter.x, ScreenCenter.y * 2 - 20)
    continue:setZIndex(2)
    continue:add()

    self:add()
end

function MenuScene:update()
    if playdate.buttonJustPressed(playdate.kButtonA) then
        clickSound:play(1)
        sound:setVolume(0, 0, 3)
        SceneManager:changeScene("GAME")
    end
end
