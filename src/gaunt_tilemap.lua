local rom_gaunt_tileset = require('src.rom_gaunt_tileset')
local tilemap = require('src.tilemap')

local gaunt_tilemap = tilemap:new{
  texture = rom_gaunt_tileset.textures[4],
  quads = rom_gaunt_tileset.quads,
  charmap = {},
  tiles = {}
}

function gaunt_tilemap:load_string(s)
  tilemap.load_string(self, s)
  for col_i, col in ipairs(self.charmap) do
    for row_i, char in ipairs(col) do
      if char ~= '.' then
        local n = 0
        if self.charmap[col_i][row_i - 1] and self.charmap[col_i][row_i - 1] ~= '.' then n = n + 1 end
        if self.charmap[col_i + 1] and self.charmap[col_i + 1][row_i] ~= '.' then n = n + 2 end
        if self.charmap[col_i][row_i + 1] and self.charmap[col_i][row_i + 1] ~= '.' then n = n + 4 end
        if self.charmap[col_i - 1] and self.charmap[col_i - 1][row_i] ~= '.' then n = n + 8 end
        self.charmap[col_i][row_i] = n
      end
    end
  end
end

-- Constructor.
function gaunt_tilemap:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return gaunt_tilemap
