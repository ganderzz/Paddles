import "entities/player"
import "entities/ball"
import "entities/block"
import "entities/wall"

import "scenes/gameScene"
import "scenes/gameOverScene"

class("LevelThree").extends(GameScene)

function LevelThree:init()
    LevelThree.super.init(self)

    self.player = Player()
    self.ball = Ball()
    self.walls = {
        Wall(340, 30),
        Wall(340, 210),
        Wall(270, 120),
    }
    self.blocks = {
        Block(380, 30), Block(380, 95), Block(380, 145), Block(380, 210),
        Block(300, 45), Block(300, 95), Block(300, 145), Block(300, 195),
    }
    self:add()
end

function LevelThree:levelComplete()
    SceneManager:changeScene(GameOverScene)
end
