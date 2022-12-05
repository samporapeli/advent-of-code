#!/usr/bin/env lua

package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")
local print_crates = require("crate_tools").print

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

local stacks = {}
for i, line in pairs(data) do
  if line:sub(1, 4) ~= "move" then
    -- read the start situation
    for j = 1, 9 do
      local index = 2 + (j - 1) * 4
      local crate = line:sub(index, index)
      if not stacks[j] then
        stacks[j] = {}
      end
      if not string.find("0123456789 ", crate) then
        for k = #stacks[j], 1, -1 do
          stacks[j][k + 1] = stacks[j][k]
        end
        stacks[j][1] = crate
      end
    end
  elseif line ~= "" then
    -- read the crane instructions
    local instruction = split(line, " ")
    local n = tonumber(instruction[2])
    local from = tonumber(instruction[4])
    local to = tonumber(instruction[6])
    print_crates(stacks)
    for j = 1, n do
      local moving = table.remove(stacks[from])
      table.insert(stacks[to], moving)
    end
  end
end

print_crates(stacks)

local top = ""
for i, stack in pairs(stacks) do
  local crate = stack[#stack]
  if crate then
    top = top .. crate
  end
end

print(top)
