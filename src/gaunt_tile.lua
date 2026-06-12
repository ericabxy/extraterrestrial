local rom_gaunt_tileset = require('src.rom_gaunt_tileset')
local tile = require('src.tile')

local wang_tile = tile:new{
  texture = rom_gaunt_tileset.textures[0],
  quad = rom_gaunt_tileset.quads[0],
}

function wang_tile:set_blob(n)
end

-- Constructor.
function wang_tile:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return wang_tile
