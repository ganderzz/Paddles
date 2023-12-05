import "CoreLibs/timer"

import "utils/graphics"
import "scenes/gameOverScene"

local gfx <const> = playdate.graphics
local timer <const> = playdate.timer

local sound <const> = playdate.sound.fileplayer.new("sounds/game")
local timerTickSound <const> = playdate.sound.fileplayer.new("sounds/timerTick")
local timerEndSound <const> = playdate.sound.fileplayer.new("sounds/timerEnd")


class("GameScene").extends(gfx.sprite)

function GameScene:init()
    gfx.clear()
    gfx.setBackgroundColor(gfx.kColorBlack)
    self.hitpoints = 3

    self:drawHud()
end

function GameScene:drawHud()
    local bg = gfx.image.new(100, 30)
    gfx.pushContext(bg)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 30, 500, 1)
    gfx.popContext()
    local spriteLine = gfx.sprite.new(bg)
    spriteLine:moveTo(0, 30)
    spriteLine:add()

    self.text = drawTextSprite("HP: " .. self.hitpoints, 300, 100)
    self.text:setScale(0.6)
    self.text:moveTo(100, 30)
    self.text:add()
end

function GameScene:update()
    local blocksRemaining = #self.blocks
    if blocksRemaining == 0 then
        IS_GAME_ACTIVE = false
        self:levelComplete()
    end
end

function GameScene:playerHit()
    self.hitpoints = self.hitpoints - 1

    self.text:remove()
    self:drawHud()

    if self.hitpoints <= 0 then
        IS_GAME_ACTIVE = false
        self:gameOver()
    end
end

function GameScene:removeBlock(id)
    for i = 1, #self.blocks do
        if self.blocks[i].id == id then
            table.remove(self.blocks, i)
            break
        end
    end
end

function GameScene:gameOver()
    sound:setVolume(0, 0, 1)
    SceneManager:startTransition(GameOverScene)
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
        self.countDownText = drawTextSprite("" .. value, 200, 100)
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
