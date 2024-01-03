import "entities/player"
import "entities/ball"
import "entities/block"
import "entities/wall"

import "scenes/gameScene"
import "scenes/levelThreeScene"

class("LevelTwo").extends(GameScene)

function LevelTwo:init()
    LevelTwo.super.init(self)

    self.player = Player()
    self.ball = Ball()
    self.walls = { Wall(240, 30), Wall(240, 210), }
    self.blocks = {
        Block(380, 30), Block(380, 95), Block(380, 145), Block(380, 210),
        Block(350, 70), Block(350, 120), Block(350, 170),
        Block(320, 90), Block(320, 140),
        Block(290, 120),
    }
    self:add()
end

function LevelTwo:levelComplete()
    SceneManager:changeScene(LevelThree)
end
