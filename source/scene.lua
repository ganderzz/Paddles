import "CoreLibs/object"
import "position"

class("Scene").extends()

function Scene:init(objects)
    Scene.super.init(self)

    self.objects = objects or {}
end

function Scene:update()
    for _, item in pairs(self.objects) do
        local collision = self:collidesWith(item)

        result = item:update({ collision })
        if result == false then
            return false
        end
    end

    return true
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