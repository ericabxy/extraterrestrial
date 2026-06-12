local sprite = require('src.sprite')

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

local vance = sprite:new{
  animation_frame = 0,
  texture = love.graphics.newImage('share/Vance.png'),
  quad = love.graphics.newQuad(0, 0, 32, 32, 128, 128),
  quads = DOWN,
  left = false,
  up = false,
  x = 0,
  y = 0,
}

function vance:move_up(dt)
  self.up = true
  if self.x % 1 == 0 then
    self.y = self.y - dt * MOVESPEED
    self.quads = UP
  elseif self.x % 1 < dt * MOVESPEED then
    self.x = math.floor(self.x)
    self.y = self.y - dt * MOVESPEED
    self.quads = UP
  elseif self.left then
    self.x = self.x - dt * MOVESPEED
  else
    self.x = self.x + dt * MOVESPEED
  end
  self.animation_frame = (self.animation_frame + dt * ANIMSPEED) % 4
  self.quad = self.quads[math.floor(self.animation_frame) + 1]
end

function vance:move_down(dt)
  self.up = false
  if self.x % 1 == 0 then
    self.y = self.y + dt * MOVESPEED
    self.quads = DOWN
  elseif self.x % 1 < dt * MOVESPEED then
    self.x = math.floor(self.x)
    self.y = self.y + dt * MOVESPEED
    self.quads = DOWN
  elseif self.left then
    self.x = self.x - dt * MOVESPEED
  else
    self.x = self.x + dt * MOVESPEED
  end
  self.animation_frame = (self.animation_frame + dt * ANIMSPEED) % 4
  self.quad = self.quads[math.floor(self.animation_frame) + 1]
end

function vance:move_left(dt)
  self.left = true
  if self.y % 1 == 0 then
    self.x = self.x - dt * MOVESPEED
    self.quads = LEFT
  elseif self.y % 1 < dt * MOVESPEED then
    self.y = math.floor(self.y)
    self.x = self.x - dt * MOVESPEED
    self.quads = LEFT
  elseif self.up then
    self.y = self.y - dt * MOVESPEED
  else
    self.y = self.y + dt * MOVESPEED
  end
  self.animation_frame = (self.animation_frame + dt * ANIMSPEED) % 4
  self.quad = self.quads[math.floor(self.animation_frame) + 1]
end

function vance:move_right(dt)
  self.left = false
  if self.y % 1 == 0 then
    self.x = self.x + dt * MOVESPEED
    self.quads = RIGHT
  elseif self.y % 1 < dt * MOVESPEED then
    self.y = math.floor(self.y)
    self.x = self.x + dt * MOVESPEED
    self.quads = RIGHT
  elseif self.up then
    self.y = self.y - dt * MOVESPEED
  else
    self.y = self.y + dt * MOVESPEED
  end
  self.animation_frame = (self.animation_frame + dt * ANIMSPEED) % 4
  self.quad = self.quads[math.floor(self.animation_frame) + 1]
end

-- Constructor.
function vance:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return vance
