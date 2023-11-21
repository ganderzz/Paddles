import "CoreLibs/object"

local gfx <const> = playdate.graphics

class("SceneManager").extends()

function SceneManager:init(scenes, initialScene)
    SceneManager.super.init(self)

    self.scenes = scenes or {}
    self.currentScene = initialScene or nil
    self.isTransitioning = false

    if self.currentScene then
        self.currentScene()
    end
end

function SceneManager:changeScene(id, ...)
    if self.isTransitioning then
        return
    end

    self.isTransitioning = true

    self:cleanup()
    self.currentScene = self.scenes[id]()
    self.isTransitioning = false
end

function SceneManager:cleanup()
    gfx.sprite.removeAll()
    gfx.setDrawOffset(0, 0)

    local allTimers = playdate.timer.allTimers()
    for _, timer in ipairs(allTimers) do
        timer:remove()
    end
end
