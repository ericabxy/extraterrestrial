return {
  cyanbricks = love.graphics.newImage('share/gaunt_wall_4.png'),
  floor2 = love.graphics.newImage('share/gaunt_floor_2.png'),
  textures = {
    [0] = love.graphics.newImage('share/gaunt_wall_0.png'),
  },
  quads = {
    [0] = love.graphics.newQuad(0, 0, 32, 32, 128, 128),
    [1] = love.graphics.newQuad(0, 32, 32, 32, 128, 128),
    [2] = love.graphics.newQuad(32, 0, 32, 32, 128, 128),
    [3] = love.graphics.newQuad(64, 64, 32, 32, 128, 128),
    [4] = love.graphics.newQuad(64, 0, 32, 32, 128, 128),
    [5] = love.graphics.newQuad(64, 32, 32, 32, 128, 128),
    [6] = love.graphics.newQuad(96, 32, 32, 32, 128, 128),
    [7] = love.graphics.newQuad(64, 96, 32, 32, 128, 128),
    [8] = love.graphics.newQuad(96, 0, 32, 32, 128, 128),
    [9] = love.graphics.newQuad(32, 64, 32, 32, 128, 128),
    [10] = love.graphics.newQuad(32, 32, 32, 32, 128, 128),
    [11] = love.graphics.newQuad(32, 96, 32, 32, 128, 128),
    [12] = love.graphics.newQuad(0, 64, 32, 32, 128, 128),
    [13] = love.graphics.newQuad(0, 96, 32, 32, 128, 128),
    [14] = love.graphics.newQuad(96, 64, 32, 32, 128, 128),
    [15] = love.graphics.newQuad(96, 96, 32, 32, 128, 128)
  }
}
