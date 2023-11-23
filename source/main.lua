-- Paddles

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"

import "scenes/menuScene"

import "sceneManager"

local gfx <const> = playdate.graphics

playdate.display.setRefreshRate(50)

SceneManager = SceneManager(MenuScene)

GLOBAL_DATA = {
    bricksDestroyed = 0,
}

local function saveGameData()
    playdate.saveData(GLOBAL_DATA)
end

function playdate.gameWillTerminate()
    saveGameData()
end

-- Automatically save game data when the device goes
-- to low-power sleep mode because of a low battery
function playdate.gameWillSleep()
    saveGameData()
end

function playdate.gameWillPause()
    local image = gfx.image.new(400, 240)
    gfx.pushContext(image)
    gfx.fillRect(0, 0, 400, 240)

    drawText("Paddles", 400, 240):draw(24, 10)
    local destroyedText = drawText("Bricks destroyed: " .. GLOBAL_DATA.bricksDestroyed)
    destroyedText = destroyedText:scaledImage(0.7)
    destroyedText:draw(6, 60)

    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(6, 10, 8, 40, 3)
    gfx.popContext()

    playdate.setMenuImage(image)
end

(function()
    if playdate.isCrankDocked() then
        playdate.ui.crankIndicator:start()
    end

    local data = playdate.datastore.read()
    if data then
        GLOBAL_DATA = data
    end

    math.randomseed(playdate.getSecondsSinceEpoch())
end)()

function playdate.update()
    playdate.timer.updateTimers()
    gfx.sprite.update()
end
