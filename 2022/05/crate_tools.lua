local crate_tools = {}

function crate_tools.to_string(crates)
  local lines = {}
  local line = ""
  -- bottom line
  for k, v in pairs(crates) do
    line = line .. " " .. k .. " "
  end
  table.insert(lines, line)
  --
  -- crate lines
  --
  -- find the biggest stack
  local biggest = 0
  for k, v in pairs(crates) do
    if #v > biggest then biggest = #v end
  end
  -- create the crate lines
  for i = 1, biggest do
    line = ""
    for k, v in pairs(crates) do
      local crate = v[i]
      if crate then
        line = line .. "[" .. crate .. "]"
      else
        line = line .. "   "
      end
    end
    table.insert(lines, line)
  end
  local res = ""
  for i, line in pairs(lines) do
    res = line .. "\n" .. res
  end
  return res
end

function crate_tools.print(crates)
  print(crate_tools.to_string(crates))
end

return crate_tools
