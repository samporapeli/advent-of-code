#!/usr/bin/env lua

package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local data = ftt.load("data.txt")

function split(str, char)
  local result = {}
  local part = ""
  for i = 1, #str do
    local curr = str:sub(i,i)
    if curr == char then
      result[#result + 1] = part
      part = ""
    else
      part = part .. curr
    end
  end
  result[#result + 1] = part
  return result
end

local overlap = 0
for i, line in pairs(data) do
  -- form a table of integer values:
  -- ranges = {
  --  1: {
  --    1_start: integer,
  --    1_end: integer,
  --  },
  --  2: {...},
  -- }
  local ranges = split(line, ",")
  -- break the loop if values aren't ok (here it's the last line)
  if not (ranges[1] and ranges[2]) then break end
  for j, range in pairs(ranges) do
    range = split(range, "-")
    for k, value in pairs(range) do
      ranges[j] = range
      ranges[j][k] = tonumber(value)
    end
  end

  -- we now have the integer values in `ranges`
  -- for this task, we have two ranges in one line, a and b
  local a = ranges[1]
  local b = ranges[2]

  -- do a and b overlap?
  if 
    (b[1] >= a[1] and b[1] <= a[2])
      or
    (a[1] >= b[1] and a[1] <= b[2])
  then
    overlap = overlap + 1
  elseif a[1] >= b[1] and a[2] <= b[2] then
    overlap = overlap + 1
  end
end

print(overlap)
