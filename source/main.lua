-- Paddles

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"

import "scenes/menuScene"
import "scenes/gameScene"

import "sceneManager"
import "scene"

local gfx <const> = playdate.graphics

playdate.display.setRefreshRate(50)

local menuScene = MenuScene
local sceneManager = SceneManager({ 
    MENU = menuScene, 
    GAME = GameScene
}, menuScene)
local sound = nil


(function()
    if playdate.isCrankDocked() then
        playdate.ui.crankIndicator:start()
    end

    math.randomseed(playdate.getSecondsSinceEpoch())
    -- Game setup
    gfx.setBackgroundColor(gfx.kColorBlack)
end)()

function playdate.update()
    gfx.clear()

    sceneManager:update()

    if playdate.isCrankDocked() then
        playdate.ui.crankIndicator:update()
    end

    gfx.sprite.update()
    playdate.timer.updateTimers()
end