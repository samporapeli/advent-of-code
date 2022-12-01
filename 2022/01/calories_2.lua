package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local data = ftt.load("example.txt")

--         1st 2nd 3rd
max_sums = {0, 0, 0}
curr_sum = 0

function better_than_index(sum, sums)
  for i = 1, #sums do
    if sum > sums[i] then
      return i
    end
  end
  return nil
end

for i = 1, #data + 1 do
  if data[i] == "" or i > #data then
    local index = better_than_index(curr_sum, max_sums)
    if index then
      -- "make room" by moving old values downwards
      for j = #max_sums, index + 1, -1 do
        max_sums[j] = max_sums[j - 1]
      end
      max_sums[index] = curr_sum
    end
    curr_sum = 0
  else
    curr_sum = curr_sum + tonumber(data[i])
  end
end

local sum = 0
for i = 1, #max_sums do
  sum = sum + max_sums[i]
end
print(sum)
