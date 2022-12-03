#!/usr/bin/env lua

package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local data = ftt.load("data.txt")

function priority(char)
  local ord = string.byte(char)
  -- lowercase
  if ord >= 97 then
      return ord - 96
  -- UPPERCASE
  else
    return ord - 38
  end
end

local sum_of_priorities = 0

local group_size = 3
for l = 1, #data, group_size do
  local lines = {}
  for i = 1, group_size do
    lines[i] = data[l + i - 1]
  end
  local badge = nil
  -- the solution is is simply to take "intersections" of each line,
  -- one by one like lines[0].intersection(lines[1]).intersection(lines[2])...
  --
  -- use values as keys
  local badge_candidates = {}
  -- first, copy the items of the first rucksack to badge_candidates
  -- (do not include duplicate items "for performance", as `badge_candidates`
  -- is practically a set)
  local first_line = lines[1]
  for i = 1, #first_line do
    badge_candidates[first_line:sub(i,i)] = true
  end
  -- next, update badge_candidates by "removing" any values that aren't present
  -- on the next lines, line by line
  for i = 2, #lines do
    local line = lines[i]
    for key, value in pairs(badge_candidates) do
      if value and not line:find(key) then
        badge_candidates[key] = false
      end
    end
  end
  -- now the `badge_candidates` should include (only) the badge
  for key, value in pairs(badge_candidates) do
    if value then
      badge = key
    end
  end
  if badge then
    sum_of_priorities = sum_of_priorities + priority(badge)
  end
end
  
print(sum_of_priorities)
