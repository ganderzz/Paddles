import "scene"
import "entities/menu"

MenuScene = Scene({Menu()})

local sound = playdate.sound.fileplayer.new("sounds/title")

MenuScene:onChangeScene(function()
    sound:setVolume(0)
    sound:play()
    -- Fade in sound
    sound:setVolume(1, 1, 2)
end)

MenuScene:onSceneDestroy(function()
    sound:setVolume(0, 0, 1)
end)