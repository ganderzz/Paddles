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

    math.randomseed(playdate.getSecondsSinceEpoch())
end)()

function playdate.update()
    playdate.timer.updateTimers()
    gfx.sprite.update()
end
