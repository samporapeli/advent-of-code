#!/usr/bin/env lua

package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")
local data = ftt.load(arg[1])

function string:at(i)
  return self:sub(i,i)
end

-- create snafu number prototype
local snafu = {}
function snafu:new(snafu_str)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  o['string_representation'] = snafu_str
  o['array_representation'] = {}
  for i = #snafu_str, 1, -1 do
    table.insert(o['array_representation'], snafu_str:at(i))
  end
  return o
end
function snafu:to_decimal()
  local dec = 0
  local arr = self["array_representation"]
  for i, val in pairs(arr) do
    local numbered_val = tonumber(val)
    if val == "-" then
      numbered_val = -1
    elseif val == "=" then
      numbered_val = -2
    end
    dec = dec + numbered_val * 5^(i-1)
  end
  return dec
end

function dec2base5(dec)
  local base5 = ""
  -- find out the biggest required exponent
  local exp = 0
  while dec // 5^exp >= 5 do exp = exp + 1 end
  local remaining = dec
  -- start from the biggest exponent
  for i = exp, 0, -1 do
    local factor = math.floor(remaining // (5^i))
    base5 = base5 .. factor
    remaining = remaining - factor * 5^i
  end
  return base5
end

function dec2snafu(dec)
  local base5 = "0"..dec2base5(dec)
  local arr = {}
  arr[#base5] = base5:at(#base5)
  for i = #base5, 1, -1 do
    local char = arr[i]
    if char == "5" then
      arr[i] = "0"
      arr[i - 1] = tostring(tonumber(base5:at(i - 1)) + 1)
    elseif char == "4" then
      arr[i] = "-"
      arr[i - 1] = tostring(tonumber(base5:at(i - 1)) + 1)
    elseif char == "3" then
      arr[i] = "="
      arr[i - 1] = tostring(tonumber(base5:at(i - 1)) + 1)
    else
      arr[i - 1] = base5:at(i - 1)
    end
  end
  local snafu_str = ""
  for i = 1, #arr do
    snafu_str = snafu_str .. arr[i]
  end
  if snafu_str:at(1) == "0" then snafu_str = snafu_str:sub(2,#snafu_str) end
  return snafu_str
end

local sum = 0
for _ ,snafu_str in pairs(data) do
  local snafu_num = snafu:new(snafu_str)
  sum = sum + snafu_num:to_decimal()
end

print(dec2snafu(sum))
