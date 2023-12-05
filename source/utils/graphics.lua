import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

local font <const> = gfx.font.new('fonts/Inter/Inter')
gfx.setFont(font)

function drawText(text, width, height, invert)
    local textImage = gfx.image.new(width or 300, height or 100)
    gfx.pushContext(textImage)
    if not invert then
        gfx.setImageDrawMode(playdate.graphics.kDrawModeInverted)
    end
    gfx.drawText(text, 0, 0)
    if not invert then
        gfx.setImageDrawMode(playdate.graphics.kDrawModeCopy)
    end
    gfx.popContext()

    return textImage
end

function drawTextSprite(text, width, height, invert)
    local textImage = drawText(text, width, height, invert)

    local sprite = gfx.sprite.new(textImage)
    sprite:setScale(2)
    sprite:setImage(textImage)

    return sprite
end
