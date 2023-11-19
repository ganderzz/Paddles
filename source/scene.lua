import "CoreLibs/object"

class("Scene").extends()

function Scene:init(objects)
    Scene.super.init(self)

    self.objects = objects or {}

    self.onChangeScene = nil
    self.onSceneDestroy = nil
end

function Scene:onChangeScene(callback)
    if callback then
        self.onChangeScene = callback
    end
end

function Scene:onSceneDestroy(callback)
    if callback then
        self.onSceneDestroy = callback
    end
end

function Scene:update(sceneManager)
    for _, item in pairs(self.objects) do
        local collision = self:collidesWith(item)

        item:update(sceneManager, collision)
    end
end

function Scene:collidesWith(obj)
    for _, item in pairs(self.objects) do
            if obj ~= item then
                if obj.pos.x < item.pos.x + item.width and
                    obj.pos.x + obj.width > item.pos.x and
                    obj.pos.y < item.pos.y + item.height and
                    obj.pos.y + obj.height > item.pos.y then
                        return item
                end
        end
    end

    return nil
end