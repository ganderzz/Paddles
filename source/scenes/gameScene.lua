import "CoreLibs/timer"

import "entities/player"
import "entities/ball"

import "utils/graphics"

local gfx <const> = playdate.graphics
local timer <const> = playdate.timer

local sound <const> = playdate.sound.fileplayer.new("sounds/game")
local timerTickSound <const> = playdate.sound.fileplayer.new("sounds/timerTick")
local timerEndSound <const> = playdate.sound.fileplayer.new("sounds/timerEnd")


class("GameScene").extends(gfx.sprite)

IS_GAME_ACTIVE = false

function GameScene:init()
    gfx.clear()
    gfx.setBackgroundColor(gfx.kColorBlack)

    self.player = Player()
    self.ball = Ball()
    self:add()
end

function GameScene:isLoaded()
    self.countDownTimer = timer.performAfterDelay(0, function()
        self:handleCountDown(3)
    end)
end

function GameScene:handleCountDown(value)
    if self.countDownText then
        self.countDownText:remove()
    end

    if value >= 1 then
        self.countDownText = drawText("" .. value, 200)
        self.countDownText:setZIndex(500)
        self.countDownText:moveTo(ScreenCenter.x + 182, ScreenCenter.y + 20)
        self.countDownText:add()
        timerTickSound:play(1)

        timer.performAfterDelay(1000, function()
            self:handleCountDown(value - 1)
        end)
    else
        IS_GAME_ACTIVE = true
        timerEndSound:play(1)
        sound:setVolume(0)
        sound:play()
        -- Fade in sound
        sound:setVolume(1, 1, 0.5)
    end
end

function GameScene:remove()
    sound:setVolume(0, 0, 1)
end
