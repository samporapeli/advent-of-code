#!/usr/bin/env lua

local debug = false

local monkeys = {}

Monkey = {}
function Monkey:new(m)
  m = m or {}
  m.items_inspected = {}
  setmetatable(m, self)
  self.__index = self
  return m
end

function Monkey:operate()
  for i=1, #self.items do
    local wl = self.items[1]
    if debug then print("\tMonkey inspects an item with a worry level of "..wl..".") end
    if self.op_op == "+" then
      wl = wl + self.op_value
    elseif self.op_op == "*" then
      wl = wl * self.op_value
    else
      wl = wl * wl
    end
    if debug then print("\t\tIncreased worry level: "..wl..".") end
    table.insert(self.items_inspected, self.items[1])
    wl = math.floor(wl/3)
    self.items[1] = wl
    
    self:throw()
  end
end

function Monkey:test()
  if self.items[1] % self.test_by == 0 then
    return self.test_then
  else
    return self.test_else
  end
end

function Monkey:throw()
  local to = self:test()
  table.insert(monkeys[to].items, table.remove(self.items, 1))
end

if not debug then
  monkeys[0] = Monkey:new({ items = { 50, 70, 54, 83, 52, 78 },        op_value = 3,  op_op = "*", test_by = 11, test_then = 2, test_else = 7})
  monkeys[1] = Monkey:new({ items = { 71, 52, 58, 60, 71 },                           op_op = nil, test_by = 7,  test_then = 0, test_else = 2})
  monkeys[2] = Monkey:new({ items = { 66, 56, 56, 94, 60, 86, 73 },    op_value = 1,  op_op = "+", test_by = 3,  test_then = 7, test_else = 5})
  monkeys[3] = Monkey:new({ items = { 83, 99 },                        op_value = 8,  op_op = "+", test_by = 5,  test_then = 6, test_else = 4})
  monkeys[4] = Monkey:new({ items = { 98, 98, 79 },                    op_value = 3,  op_op = "+", test_by = 17, test_then = 1, test_else = 0})
  monkeys[5] = Monkey:new({ items = { 76 },                            op_value = 4,  op_op = "+", test_by = 13, test_then = 6, test_else = 3})
  monkeys[6] = Monkey:new({ items = { 52, 51, 84, 54 },                op_value = 17, op_op = "*", test_by = 19, test_then = 4, test_else = 1})
  monkeys[7] = Monkey:new({ items = { 82, 86, 91, 79, 94, 92, 59, 94 },op_value = 7,  op_op = "+", test_by = 2,  test_then = 5, test_else = 3})
else
  monkeys[0] = Monkey:new({ items = { 79, 98 }, op_op = "*", op_value = 19, test_by = 23, test_then = 2, test_else = 3})
  monkeys[1] = Monkey:new({ items = { 54, 65, 75, 74 }, op_value = 6, op_op = "+", test_by = 19,  test_then = 2, test_else = 0})
  monkeys[2] = Monkey:new({ items = { 79, 60, 97 }, op_value = nil, op_op = nil, test_by = 13,  test_then = 1, test_else = 3})
  monkeys[3] = Monkey:new({ items = { 74 }, op_value = 3, op_op = "+", test_by = 17,  test_then = 0, test_else = 1})
end

local rounds = 20
for _ = 1, rounds do
  for i = 0, #monkeys do
    local monkey = monkeys[i]
    if debug then print("Monkey "..i..":") end
    for _, item in pairs(monkey.items) do
      monkey:operate()
    end
  end
end

local inspections = {}
if debug then print() end
for i, monkey in pairs(monkeys) do
  table.insert(inspections, #monkey.items_inspected)
  print("Monkey "..i.." inspected items "..#monkey.items_inspected.." times.")
end

table.sort(inspections, function(a, b) return a > b end)
print(inspections[1] * inspections[2])
