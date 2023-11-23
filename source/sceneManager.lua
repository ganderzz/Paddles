import "CoreLibs/object"

local gfx <const> = playdate.graphics
local timer <const> = playdate.timer

class("SceneManager").extends()

function SceneManager:init(initialScene)
    SceneManager.super.init(self)

    self.currentScene = initialScene or nil
    self.isTransitioning = false

    if self.currentScene then
        self.currentScene()
    end
end

function SceneManager:changeScene(scene, ...)
    if self.isTransitioning then
        return
    end

    self.isTransitioning = true

    self:startTransition(scene)
    self.isTransitioning = false
end

function SceneManager:loadScene(scene)
    self:cleanup()
    self.currentScene = scene()
end

function SceneManager:cleanup()
    gfx.sprite.removeAll()
    gfx.setDrawOffset(0, 0)

    local allTimers = timer.allTimers()
    for _, timer in ipairs(allTimers) do
        timer:remove()
    end
end

function SceneManager:startTransition(scene)
    local transitionTimer = self:wipeTransition(0, 400)

    transitionTimer.timerEndedCallback = function()
        self:loadScene(scene)
        transitionTimer = self:wipeTransition(400, 0)
        transitionTimer.timerEndedCallback = function()
            self.transitioning = false
            self.transitionSprite:remove()

            if self.currentScene["isLoaded"] then
                self.currentScene:isLoaded()
            end
        end
    end
end

function SceneManager:wipeTransition(startValue, endValue)
    local transitionSprite = self:createTransitionSprite()
    transitionSprite:setClipRect(0, 0, startValue, 240)

    local transitionTimer = timer.new(1000, startValue, endValue, playdate.easingFunctions.inOutCubic)
    transitionTimer.updateCallback = function(timer)
        transitionSprite:setClipRect(0, 0, timer.value, 240)
    end
    return transitionTimer
end

function SceneManager:createTransitionSprite()
    local filledRect = gfx.image.new(400, 240, gfx.kColorWhite)
    local transitionSprite = gfx.sprite.new(filledRect)
    transitionSprite:moveTo(200, 120)
    transitionSprite:setZIndex(10000)
    transitionSprite:setIgnoresDrawOffset(true)
    transitionSprite:add()
    self.transitionSprite = transitionSprite
    return transitionSprite
end
