import "scene"
import "entities/player"
import "entities/ball"

GameScene = Scene({Player(), Ball()})

local sound = playdate.sound.fileplayer.new("sounds/game")

GameScene:onChangeScene(function()
    sound:setVolume(0)
    sound:play()
    -- Fade in sound
    sound:setVolume(1, 1, 5)
end)

GameScene:onSceneDestroy(function()
    sound:setVolume(0, 0, 1)
end)