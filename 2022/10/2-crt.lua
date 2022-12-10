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
for i, value in pairs(value_at_cycle) do
  local pos = (i - 1) % 40
  if pos == 0 then
    io.write("\n")
  end
  
  if pos <= value + 1 and pos >= value - 1 then
    io.write("#")
  else
    io.write(".")
  end
end

print()
