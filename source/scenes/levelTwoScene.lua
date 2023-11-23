import "entities/player"
import "entities/ball"
import "entities/block"

import "scenes/gameScene"

class("LevelTwo").extends(GameScene)

function LevelTwo:init()
    LevelTwo.super.init()

    self.player = Player()
    self.ball = Ball()
    self.blocks = {Block(340, 60)}
    self:add()
end
