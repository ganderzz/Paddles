import "entities/player"
import "entities/ball"
import "entities/block"

import "scenes/gameScene"

class("LevelTwo").extends(GameScene)

function LevelTwo:init()
    LevelTwo.super.init(self)

    self.player = Player()
    self.ball = Ball()
    self.blocks = {
        Block(340, 30), Block(340, 95), Block(340, 145), Block(340, 210),
        Block(310, 70), Block(310, 120), Block(310, 170),
        Block(290, 90), Block(290, 140),
        Block(270, 110),
    }
    self:add()
end

function LevelTwo:levelComplete()
    SceneManager:changeScene()
end
