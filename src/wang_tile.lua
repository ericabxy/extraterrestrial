local tile = require('src.tile')

local wang_tile = tile:new{
}

function tile:paint(ox, oy)
  ox, oy = ox or 0, oy or 0
  love.graphics.draw(self.texture, self.quad, math.floor(ox + self.x), math.floor(oy + self.y))
end

-- Constructor.
function tile:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return tile
