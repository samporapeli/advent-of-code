#!/usr/bin/env lua

package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local debug = true
local data = ftt.load(arg[1])

function tree_at(ri, ci)
  return data[ri]:sub(ci,ci)
end

function tree_is_visible_from(dir, ri, ci)
  local dr
  local dc
  if dir == "top" then
    dr = -1
    dc = 0
  elseif dir == "bottom" then
    dr = 1
    dc = 0
  elseif dir == "left" then
    dr = 0
    dc = -1
  else -- dir == "right"
    dr = 0
    dc = 1
  end
  local r = ri
  local c = ci

  local tree = tree_at(r, c)
  -- stay inside the square     yes it's a square for sure
  while r > 1 and c > 1 and r < #data and c < #data do
    r = r + dr
    c = c + dc
    if tree_at(r, c) >= tree then
      return false
    end
  end
  return true
end

local visible_trees = {}

-- ri = row_index
-- ci = column_index
for ri = 2, #data - 1 do
  local row = data[ri]
  for ci = 2, #row - 1 do
    local t = tree_at(ri, ci) 
    for i, direction in pairs({ "top", "bottom", "left", "right" }) do
      if tree_is_visible_from(direction, ri, ci) then
        table.insert(visible_trees, { ci, ri })
        break
      end
    end
  end
end

print(#visible_trees + (#data - 1)*4)
