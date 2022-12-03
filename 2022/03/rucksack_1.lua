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

for i, line in pairs(data) do
  local a = line:sub(0, #line/2)
  local b = line:sub(#line/2 + 1, #line)
  local error_item = nil
  for i = 1, #a do
    local char = a:sub(i,i)
    for j = 1, #b do
      if char == b:sub(j,j) then
        error_item = char
      end
    end
  end
  if error_item then
    sum_of_priorities = sum_of_priorities + priority(error_item)
  end
end

print(sum_of_priorities)
