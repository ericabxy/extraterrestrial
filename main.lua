local vance = require('src.vance')
local stage0 = require('src.stage0')

local screen = { x = 0, y = 0 }

local tilemap = stage0:new()
player1 = vance:new{ controller_number = 1, x = 5, y = 4 }

function love.update(dt)
  player1:control(dt)
  player1:move(dt, tilemap)
  screen.x = (player1.x - 4.5) * 32
  screen.y = (player1.y - 3.5) * 32
  if screen.x < 0 then screen.x = 0 elseif screen.x > 20 then screen.x = 20 end
  if screen.y < 0 then screen.y = 0 elseif screen.y > 20 then screen.y = 20 end
end

function love.draw()
  tilemap:draw(-screen.x, -screen.y)
  player1:draw(-screen.x, -screen.y)
end
