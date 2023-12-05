import "entities/player"
import "entities/ball"
import "entities/block"

import "scenes/gameScene"
import "scenes/gameOverScene"

class("LevelThree").extends(GameScene)

function LevelThree:init()
    LevelThree.super.init(self)

    self.player = Player()
    self.ball = Ball()
    self.blocks = {
        Block(380, 30), Block(380, 95), Block(380, 145), Block(380, 210),
        Block(340, 45), Block(340, 95), Block(340, 145), Block(340, 195),
        Block(300, 30), Block(300, 95), Block(300, 145), Block(300, 210),
        Block(260, 45), Block(260, 95), Block(260, 145), Block(260, 195),
        Block(230, 120),
    }
    self:add()
end

function LevelThree:levelComplete()
    SceneManager:changeScene(GameOverScene)
end
