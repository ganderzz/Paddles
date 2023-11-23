import "entities/player"
import "entities/ball"
import "entities/block"

import "scenes/gameScene"
import "scenes/levelTwoScene"

class("LevelOne").extends(GameScene)

function LevelOne:init()
    LevelOne.super.init()

    self.player = Player()
    self.ball = Ball()
    self.blocks = {Block(340, 60), Block(340, 110), Block(340, 160)}
    self:add()
end

function LevelOne:levelComplete()
    SceneManager:changeScene(LevelTwo)
end
