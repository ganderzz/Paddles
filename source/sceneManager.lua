import "CoreLibs/object"

local gfx <const> = playdate.graphics
local timer <const> = playdate.timer

class("SceneManager").extends()

IS_GAME_ACTIVE = false

circles = {}
for i=1, 601, 1 do
    local circle = gfx.image.new(i*2, i*2)
    gfx.pushContext(circle)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillCircleAtPoint(i, i, i)
    gfx.popContext()
    circles[i] = circle
end

function SceneManager:init(initialScene)
    SceneManager.super.init(self)

    self.currentScene = initialScene or nil
    self.transitionSprites = {}
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
    IS_GAME_ACTIVE = false

    self:startTransition(scene, {...})
end

function SceneManager:loadScene(scene, args)
    self:cleanup()
    self.currentScene = scene(table.unpack(args))
end

function SceneManager:cleanup()
    gfx.sprite.removeAll()
    gfx.setDrawOffset(0, 0)

    local allTimers = timer.allTimers()
    for _, timer in ipairs(allTimers) do
        timer:remove()
    end
end

function SceneManager:startTransition(scene, args)
    local transitionTimer = self:fadeInTransition(0, 600)

    transitionTimer.timerEndedCallback = function()
        self:loadScene(scene, args)
        transitionTimer = self:fadeInTransition(600, 0)
        transitionTimer.timerEndedCallback = function()
            self.isTransitioning = false
            self.transitionSprite:remove()

            if self.currentScene["isLoaded"] then
                self.currentScene:isLoaded()
            end
        end
    end
end

function SceneManager:fadeInTransition(startValue, endValue)
    local transitionSprite = self:createTransitionSprite()
    transitionSprite:setImage(self:getCircleImage(startValue))

    local transitionTimer = timer.new(800, startValue, endValue, playdate.easingFunctions.inOutCubic)
    transitionTimer.updateCallback = function(timer)
        transitionSprite:setImage(self:getCircleImage(timer.value))
    end
    return transitionTimer
end

function SceneManager:getCircleImage(index)
    local i = math.floor(index)
    if i <= 0 or i > #circles then
        return nil
    end
    return circles[i]
end

function SceneManager:createTransitionSprite()
    local filledRect = gfx.image.new(800, 480, gfx.kColorBlack)
    local transitionSprite = gfx.sprite.new(filledRect)

    local x = 200
    local y = 120

    if self.currentScene ~= nil and self.currentScene.ball ~= nil then
        x = self.currentScene.ball.x
        y = self.currentScene.ball.y
    end

    transitionSprite:moveTo(x, y)
    transitionSprite:setZIndex(10000)
    transitionSprite:setIgnoresDrawOffset(true)
    transitionSprite:add()
    self.transitionSprite = transitionSprite
    return transitionSprite
end
