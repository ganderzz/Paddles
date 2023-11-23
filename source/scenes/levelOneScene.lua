import "entities/player"
import "entities/ball"
import "entities/block"

import "scenes/gameScene"
import "scenes/levelTwoScene"

class("LevelOne").extends(GameScene)

function LevelOne:init()
    LevelOne.super.init(self)

    self.player = Player()
    self.ball = Ball()
    self.blocks = {
        Block(340, ScreenCenter.y - 50), 
        Block(340, ScreenCenter.y), 
        Block(340, ScreenCenter.y + 50)
    }
    self:add()
end

function LevelOne:levelComplete()
    SceneManager:changeScene(LevelTwo)
end
