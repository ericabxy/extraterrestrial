local rom_gaunt_tileset = require('src.rom_gaunt_tileset')
local tile = require('src.tile')

local dungeon = {
  charmap = {},
  tiles = {}
}

function dungeon:get_char(x, y)
  x, y = math.floor(x) + 1, math.floor(y) + 1
  if self.charmap[x] and self.charmap[x][y] then return self.charmap[x][y] end
end

function dungeon:set_char(x, y, c)
  x, y = math.floor(x) + 1, math.floor(y) + 1
  if self.charmap[x] and self.charmap[x][y] then self.charmap[x][y] = c end
end

function dungeon:load_string(s)
  self.charmap = {}
  self.tiles = {}
  local width = #(s:match("[^\n]+"))
  for x = 1, width, 1 do self.charmap[x] = {} end  
  local row_i, col_i = 1, 1
  for row in s:gmatch("[^\n]+") do
    assert(#row == width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
    col_i = 1
    for character in row:gmatch(".") do
      self.charmap[col_i][row_i] = character
      if character == '#' then
        local t = tile:new{
          texture = rom_gaunt_tileset.cyanbricks,
          x = ( col_i - 1 ),
          y = ( row_i - 1 )
        }
        table.insert(self.tiles, t)
      end
      col_i = col_i + 1
    end
    row_i = row_i + 1
  end
  self:set_tiles()
end

function dungeon:draw(xoffset, yoffset)
  xoffset, yoffset = xoffset or {}, yoffset or {}
  for i, t in ipairs(self.tiles) do t:paint(xoffset, yoffset) end
end

function dungeon:set_tiles()
  self.tiles = {}
  for col_i, col in ipairs(self.charmap) do
    for row_i, char in ipairs(col) do
      if char == '.' then
        local t = tile:new{
          texture = rom_gaunt_tileset.floor2,
          x = ( col_i - 1 ),
          y = ( row_i - 1 )
        }
        table.insert(self.tiles, t)
      elseif char == '#' then
        local n = 0
        local t = tile:new{
          texture = rom_gaunt_tileset.cyanbricks,
          x = ( col_i - 1 ),
          y = ( row_i - 1 )
        }
        if self.charmap[col_i][row_i - 1] and self.charmap[col_i][row_i - 1] == '#' then n = n + 1 end
        if self.charmap[col_i + 1] and self.charmap[col_i + 1][row_i] == '#' then n = n + 2 end
        if self.charmap[col_i][row_i + 1] and self.charmap[col_i][row_i + 1] == '#' then n = n + 4 end
        if self.charmap[col_i - 1] and self.charmap[col_i - 1][row_i] == '#' then n = n + 8 end
        t.quad = rom_gaunt_tileset.quads[n]
        table.insert(self.tiles, t)
      end
    end
  end
end

-- Constructor.
function dungeon:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return dungeon
