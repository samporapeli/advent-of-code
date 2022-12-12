#!/usr/bin/env lua

package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local data = ftt.load(arg[1])

local directions = {
  U = { 0, 1 },
  D = { 0,-1 },
  R = { 1, 0 },
  L = {-1, 0 },
}

function touching(ax, ay, bx, by)
  return math.abs(ax - bx) <= 1 and math.abs(ay - by) <= 1
end

local visited = {}
local tx = 0
local ty = 0
local hx = 0
local hy = 0

for i, line in pairs(data) do
  local dir = line:sub(1,1)
  local amount = tonumber(line:sub(3, #line))

  for j = 1, amount do
    local dx = directions[dir][1]
    local dy = directions[dir][2]

    hx = hx + dx
    hy = hy + dy
    
    if not touching(hx, hy, tx, ty) then
      tx = hx - dx
      ty = hy - dy
    end

    visited[tx..","..ty] = true
  end
end

local sum = 0
for place, _ in pairs(visited) do
  sum = sum + 1
end

print(sum)
