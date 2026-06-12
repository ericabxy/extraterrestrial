local tilemap = require('src.tilemap')
local vance = require('src.vance')
local board0 = require('board0')

local screen = { x = 0, y = 0 }

local tilemap0 = tilemap:new()
tilemap0:load_string(board0)
player0 = vance:new{ x = 5, y = 4 }

function love.update(dt)
  local movespeed = 8
  if love.joystick.isDown(1, 5) then player0:move_up(dt)
  elseif love.joystick.isDown(1, 6) then player0:move_down(dt)
  elseif love.joystick.isDown(1, 7) then player0:move_left(dt)
  elseif love.joystick.isDown(1, 8) then player0:move_right(dt)
  end
end

function love.draw()
  tilemap0:paint(-screen.x, -screen.y)
  player0:paint(-screen.x, -screen.y)
end
