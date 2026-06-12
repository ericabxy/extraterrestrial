local UNIT = 16

local sprite = {
  texture = nil,
  quad = nil,
  x = 0,
  y = 0,
}

function sprite:paint(ox, oy)
  ox, oy = ox or 0, oy or 0
  love.graphics.draw(self.texture, self.quad, math.floor(ox + (self.x * UNIT)), math.floor(oy + (self.y * UNIT)))
end

-- Constructor.
function sprite:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return sprite
