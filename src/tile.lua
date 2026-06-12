local rom_gaunt_tileset = require('src.rom_gaunt_tileset')

local UNIT = 32

local tile = {
  texture = rom_gaunt_tileset.textures[0],
  quad = rom_gaunt_tileset.quads[0],
  x = 0,
  y = 0
}

function tile:paint(ox, oy)
  ox, oy = ox or 0, oy or 0
  love.graphics.draw(self.texture, self.quad, math.floor(ox + (self.x * UNIT)), math.floor(oy + (self.y * UNIT)))
end

function tile:set_wang(left, top, right, bottom)
  local n = 0
  if top then n = n + 1 end
  if right then n = n + 2 end
  if bottom then n = n + 4 end
  if left then n = n + 8 end
  self.quad = rom_gaunt_tileset.quads[n]
end

-- Constructor.
function tile:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return tile
