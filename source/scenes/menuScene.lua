import "scenes/levelOneScene"

local gfx <const> = playdate.graphics

local sound <const> = playdate.sound.fileplayer.new("sounds/title")
local clickSound <const> = playdate.sound.fileplayer.new("sounds/click")

class("MenuScene").extends(gfx.sprite)

function MenuScene:init()
    gfx.clear()
    gfx.setBackgroundColor(gfx.kColorBlack)

    if playdate.isCrankDocked() then
        playdate.ui.crankIndicator:start()
    end

    sound:setVolume(0)
    sound:play()
    -- Fade in sound
    sound:setVolume(1, 1, 3)

    local bg = gfx.sprite.new(gfx.image.new("images/title.png"))
    bg:setScale(0.25)
    bg:moveTo(ScreenCenter.x, ScreenCenter.y)
    bg:setZIndex(1)
    bg:add()

    -- Setup continue button
    self.continueButton = gfx.sprite.new(gfx.image.new("images/continue.png"))
    self.continueButton:setScale(0.8)
    self.continueButton:moveTo(ScreenCenter.x, ScreenCenter.y * 2 - 20)
    self.continueButton:setZIndex(2)
    self.continueButton:add()

    self.timer = playdate.timer.new(3000, 0.79, 0.75, playdate.easingFunctions.inOutQuad)
    self.timer.repeats = true
    self.timer.reverses = true
    self.timer.updateCallback = function(timer)
        self.continueButton:setScale(timer.value)
    end

    self:add()
end

function MenuScene:update()
    if playdate.buttonJustPressed(playdate.kButtonA) then
        clickSound:play(1)
        sound:setVolume(0, 0, 0.5)
        SceneManager:changeScene(LevelOne)
    end
end
