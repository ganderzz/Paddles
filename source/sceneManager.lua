import "CoreLibs/object"

class("SceneManager").extends()

function SceneManager:init(scenes, initialScene)
    SceneManager.super.init(self)

    self.scenes = scenes or {}
    self.currentScene = initialScene or nil

    if self.currentScene then
        -- If we have an initialScene we want to call 
        -- it's "onSceneCreation" method.
        self.currentScene:onChangeScene()
    end
end

function SceneManager:changeScene(id)
    if not self.scenes[id] then
        print("There is no scene with the id `" .. id .. "`.")
        return
    end

    self.currentScene:onSceneDestroy()
    self.currentScene = self.scenes[id]
    self.currentScene:onChangeScene()
end

function SceneManager:update()
    if self.currentScene then
        local result = self.currentScene:update(self)
    else
        print("There is no `currentScene` provided to the SceneManager.")
    end
end