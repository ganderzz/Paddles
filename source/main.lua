-- Paddles

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"

import "scenes/menuScene"
import "scenes/gameScene"

import "sceneManager"

local gfx <const> = playdate.graphics

playdate.display.setRefreshRate(50)

local menuScene = MenuScene
local gameScene = GameScene
SceneManager = SceneManager({
    MENU = menuScene,
    GAME = gameScene,
}, menuScene)
local sound = nil


(function()
    if playdate.isCrankDocked() then
        playdate.ui.crankIndicator:start()
    end

    local image = gfx.image.new(400, 240)
    gfx.pushContext(image)
    gfx.fillRect(0, 0, 400, 240)
    gfx.setImageDrawMode(playdate.graphics.kDrawModeInverted)
    gfx.drawText("Paddles", 20, 10)
    gfx.setImageDrawMode(playdate.graphics.kDrawModeCopy)

    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(6, 10, 8, 40, 3)
    gfx.popContext()

    playdate.setMenuImage(image)

    math.randomseed(playdate.getSecondsSinceEpoch())
end)()

function playdate.update()
    playdate.timer.updateTimers()
    gfx.sprite.update()
end
