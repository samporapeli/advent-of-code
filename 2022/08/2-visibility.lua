#!/usr/bin/env lua

package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local debug = true
local data = ftt.load(arg[1])

function tree_at(ri, ci)
  return data[ri]:sub(ci,ci)
end

function viewing_distance(dir, ri, ci)
  local dr = dir[1]
  local dc = dir[2]

  local r = ri
  local c = ci

  local dist = 0
  local tree = tree_at(r, c)
  -- stay inside the square     yes it's a square for sure
  while r > 1 and c > 1 and r < #data and c < #data do
    r = r + dr
    c = c + dc
    dist = dist + 1
    if tree_at(r, c) >= tree then
      return dist
    end
  end
  return dist
end

local max_scenic_score = 0

-- ri = row_index
-- ci = column_index
for ri = 2, #data - 1 do
  local row = data[ri]
  for ci = 2, #row - 1 do
    local t = tree_at(ri, ci) 
    local scenic_score = 1
    for i, dir in pairs({ {0, 1}, {0, -1}, {1, 0}, {-1, 0} }) do
      scenic_score = scenic_score * viewing_distance(dir, ri, ci)
    end
    if scenic_score > max_scenic_score then max_scenic_score = scenic_score end
  end
end

print(max_scenic_score)
