local file_to_table = {}

function file_to_table.load(filename)
  local lines = {}
  local handle = assert(io.open(filename, "r"))
  repeat
    value = handle:read("*line")
    if value then table.insert(lines, value) end
  until not value
  handle:close()
  return lines
end

return file_to_table
