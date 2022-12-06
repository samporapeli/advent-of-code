#!/usr/bin/env lua

package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local data = ftt.load("data.txt")

function find_marker(data)
  local len = 4
  local line = data[1]
  local i = 1
  for i = 1, #line - len - 1 do
    local curr = line:sub(i, i + len - 1)
    local chars = {}
    for j = 1, #curr do
      local char = curr:sub(j,j)
      chars[char] = true
    end
    -- calculate the # of keys of the set
    -- (#chars is 0)
    local key_n = 0
    for key, value in pairs(chars) do
      key_n = key_n + 1
    end
    if key_n == len then
      return i + len - 1
    end
  end
end

print(find_marker(data))
