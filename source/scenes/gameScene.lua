import "CoreLibs/timer"

import "entities/player"
import "entities/ball"

local gfx <const> = playdate.graphics
local timer <const> = playdate.timer

local sound <const> = playdate.sound.fileplayer.new("sounds/game")
local font = gfx.font.new('fonts/Inter/Inter')

class("GameScene").extends(gfx.sprite)

IS_GAME_ACTIVE = false

function GameScene:init()
    gfx.clear()
    gfx.setBackgroundColor(gfx.kColorBlack)

    sound:setVolume(0)
    sound:play()
    -- Fade in sound
    sound:setVolume(1, 1, 5)

    self.count = 3

    gfx.setFont(font)
    local textImage = gfx.image.new(300, 100)
    gfx.pushContext(textImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.setImageDrawMode(playdate.graphics.kDrawModeInverted)
    gfx.drawText("" .. self.count, 0, 0)
    gfx.setImageDrawMode(playdate.graphics.kDrawModeCopy)
    gfx.popContext()

    local sprite = gfx.sprite.new(textImage)
    sprite:setImage(textImage)
    sprite:setZIndex(500)
    sprite:moveTo(ScreenCenter.x + 150, ScreenCenter.y)
    sprite:add()

    self.countDownTimer = timer.new(3000, 3, 0, playdate.easingFunctions.linear)
    self.countDownTimer.updateCallback = function(timer)
        self:handleCountDown(timer.value)
    end

    self.player = Player()
    self.ball = Ball()
    self:add()
end

function GameScene:handleCountDown(value)
    self.count = self.count - 1
    print(value)
    if self.count >= 1 then
        --timer.new(3000, function() self:handleCountDown() end)
    else
        IS_GAME_ACTIVE = true
    end
end

-- GameScene:onSceneDestroy(function()
--     sound:setVolume(0, 0, 1)
-- end)
