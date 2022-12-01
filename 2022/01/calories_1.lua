package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local data = ftt.load("example.txt")

max_sum = 0
curr_sum = 0
for i = 1, #data + 1 do
  if data[i] == "" or i > #data then
    if curr_sum > max_sum then
      max_sum = curr_sum
    end
    curr_sum = 0
  else
    curr_sum = curr_sum + tonumber(data[i])
  end
end

print(max_sum)
