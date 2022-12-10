#!/usr/bin/env lua

package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local debug = true
local data = ftt.load(arg[1])

local value_at_cycle = {}

local value = 1
for i, inst in pairs(data) do
  local op = inst:sub(1, 4)
  if op == "addx" then
    table.insert(value_at_cycle, value)
    table.insert(value_at_cycle, value)
    value = value + tonumber(inst:sub(5, #inst))
  elseif op == "noop" then
    table.insert(value_at_cycle, value)
  end
end

local sum = 0
for i = 20, 220, 40 do
  sum = sum + value_at_cycle[i] * i
end

print(sum)
