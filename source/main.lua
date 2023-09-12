-- Name this file `main.lua`. Your game can use multiple source files if you wish
-- (use the `import "myFilename"` command), but the simplest games can be written
-- with just `main.lua`.

-- You'll want to import these in just about every project you'll work on.

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"

import "player"
import "ball"

local gfx <const> = playdate.graphics

playdate.display.setRefreshRate(50)

local playerSprite = nil
local ball = nil
-- https://www.beepbox.co/#9n31sbk2l00e0bt2-a7g0fj07r0i0o432T0v1u00f0q3z10obc3523d4aw2h0E1b2T1v1u56f0qwx10p711d03A5F5B9Q0001PfaedE4b762663777T3v1u03f0qg00d02SU005040woo22190E20617T2v0u15f10w4qw02d03w0E0b8i4z8x4j000h4h4h4h40014h4h4h4g004h4h4h4h000p22sFFYsCvIDwQR_lxf2VSprTg-Of2S3SSC6CzY8WIEDOOfoFbXieKg8X2eDyOY5dN_K1jq_aCzOMCUfX4IhN5dBWgaq_UnQ6vgfhhE4t17geCDXjhYNsPfOn4-Ye1jky0m2jajCcOwd9EOOeAzF3pDaHb8-bVI0
local sound = nil


(function()
    if playdate.isCrankDocked() then
        playdate.ui.crankIndicator:start()
    end
    -- Game setup
    sound = playdate.sound.fileplayer.new()
    sound:load("sounds/main")
    gfx.setBackgroundColor(gfx.kColorBlack)

    playerSprite = Player()
    ball = Ball()
    sound:play()
end)()


function playdate.update()
    gfx.clear()
    if playdate.isCrankDocked() then
        playdate.ui.crankIndicator:update()
    end

    playerSprite:update()
    ball:update()

    gfx.sprite.update()
    playdate.timer.updateTimers()
end