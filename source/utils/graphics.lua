import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

local font <const> = gfx.font.new('fonts/Inter/Inter')
gfx.setFont(font)

function drawText(text, width, height)
    local textImage = gfx.image.new(width or 300, height or 100)
    gfx.pushContext(textImage)
    gfx.setImageDrawMode(playdate.graphics.kDrawModeInverted)
    gfx.drawText(text, 0, 0)
    gfx.setImageDrawMode(playdate.graphics.kDrawModeCopy)
    gfx.popContext()

    return textImage
end

function drawTextSprite(text, width, height)
    local textImage = drawText(text, width, height)

    local sprite = gfx.sprite.new(textImage)
    sprite:setScale(2)
    sprite:setImage(textImage)

    return sprite
end
