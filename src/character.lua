local _ = require('src.const_libretro')

local ANIMSPEED = 8
local MOVESPEED = 6
local MINIMUM = .1
local DOWN = {
  love.graphics.newQuad(0, 0, 32, 32, 128, 128),
  love.graphics.newQuad(32, 0, 32, 32, 128, 128),
  love.graphics.newQuad(64, 0, 32, 32, 128, 128),
  love.graphics.newQuad(96, 0, 32, 32, 128, 128),
}
local RIGHT = {
  love.graphics.newQuad(0, 32, 32, 32, 128, 128),
  love.graphics.newQuad(32, 32, 32, 32, 128, 128),
  love.graphics.newQuad(64, 32, 32, 32, 128, 128),
  love.graphics.newQuad(96, 32, 32, 32, 128, 128),
}
local UP = {
  love.graphics.newQuad(0, 64, 32, 32, 128, 128),
  love.graphics.newQuad(32, 64, 32, 32, 128, 128),
  love.graphics.newQuad(64, 64, 32, 32, 128, 128),
  love.graphics.newQuad(96, 64, 32, 32, 128, 128),
}
local LEFT = {
  love.graphics.newQuad(0, 96, 32, 32, 128, 128),
  love.graphics.newQuad(32, 96, 32, 32, 128, 128),
  love.graphics.newQuad(64, 96, 32, 32, 128, 128),
  love.graphics.newQuad(96, 96, 32, 32, 128, 128),
}

-- Class table.
local character = {
  animation_frame = 0,
  controller_number = 0,
  texture = love.graphics.newImage('share/character.png'),
  quad = love.graphics.newQuad(0, 0, 32, 32, 128, 128),
  unitwidth = 32,
  unitheight = 32,
  quads = DOWN,
  left = false,
  up = false,
  dx = 0,
  dy = 0,
  x = 0,
  y = 0,
}

function character:control(dt)
  if self.controller_number < 1 or self.controller_number > 8 then return end
  local speed = 5
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_UP) then
    self.dy = -speed
  elseif love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_DOWN) then
    self.dy = speed
  else
    self.dy = 0
  end
  if love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_LEFT) then
    self.dx = -speed
  elseif love.joystick.isDown(self.controller_number, RETRO_DEVICE_ID_JOYPAD_RIGHT) then
    self.dx = speed
  else
    self.dx = 0
  end
end

function character:move(dt, map)
  local dx = self.x + self.dx * dt
  local dy = self.y + self.dy * dt
  -- Pickup gems and other items.
  if map:get_char(dx, dy) == 'o' then map:set_char(dx, dy, '.') end
  if map:get_char(dx, dy + 1) == 'o' then map:set_char(dx, dy + 1, '.') end
  if map:get_char(dx + 1, dy) == 'o' then map:set_char(dx + 1, dy, '.') end
  if map:get_char(dx + 1, dy + 1) == 'o' then map:set_char(dx + 1, dy + 1, '.') end
  -- Check for and resolve tile collisions.
  if self.dx <= 0 then
    if map:get_char(dx, self.y) ~= '.' or map:get_char(dx, self.y + .9) ~= '.' then
      dx = math.ceil(dx)
      self.dx = 0
    end
  else
    if map:get_char(dx + 1, self.y) ~= '.' or map:get_char(dx + 1, self.y + .9) ~= '.' then
      dx = math.floor(dx)
      self.dx = 0
    end
  end
  if self.dy <= 0 then
    if map:get_char(dx, dy) ~= '.' or map:get_char(dx + .9, dy) ~= '.' then
      dy = math.ceil(dy)
      self.dy = 0
    end
  else
    if map:get_char(dx, dy + 1) ~= '.' or map:get_char(dx + .9, dy + 1) ~= '.' then
      dy = math.floor(dy)
      self.dy = 0
    end
  end
  self.x = dx
  self.y = dy
end

function character:draw(xoffset, yoffset)
  xoffset, yoffset = xoffset or 0, yoffset or 0
  local x = math.floor(xoffset + ( self.x * self.unitwidth ))
  local y = math.floor(yoffset + ( self.y * self.unitheight ))
  love.graphics.draw(self.texture, self.quad, x, y)
end

-- Constructor.
function character:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return character
