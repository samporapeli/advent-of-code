#!/usr/bin/env lua
-- requires two parameters:
--  1. data filename (data.txt)

local fs_size = 70000000
local update_size = 30000000

package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local debug = true
local data = ftt.load(arg[1])

function string:last()
  return self:sub(#self,#self)
end

function split(str, char)
  local result = {}
  local part = ""
  for i = 1, #str do
    local curr = str:sub(i,i)
    if curr == char then
      table.insert(result, part)
      part = ""
    else
      part = part .. curr
    end
  end
  table.insert(result, part)
  return result
end

function create_filesystem(data)
  local fs = {}
  local path = "/"
  for i, line in pairs(data) do
    local sl = split(line, " ")
    if sl[1] == "$" then
      if sl[2] == "cd" then
        if sl[3] == ".." then
          local j = #path - 1
          while j > 0 do
            path = path:sub(1, j)
            if path:sub(j,j) == "/" then break end
            j = j - 1
          end
        elseif sl[3] == "/" then
          path = "/" 
        else
          path = path .. sl[3] .. "/"
        end
      elseif sl[2] == "ls" then
        -- nothing to do until next line
      end
    else -- it should be ls output row now
      local size = sl[1]
      local filename = sl[2]
      if size == "dir" then
        size = 0
      else
        size = tonumber(size)
      end

      -- create directory entry for current directory, if it doesn't exist
      if not fs[path] then
        fs[path] = {
          size = 0,
          children = {},
        }
      end

      local complete_path = path .. filename
      if size == 0 then complete_path = complete_path .. "/" end

      fs[path]["children"][complete_path] = {
        children = {},
      }

      fs[complete_path] = {
        size = size,
        children = {},
      }
    end
  end
  return fs
end

function dir_smallest_after(size, fs)
  local dirs = {}
  for path, obj in pairs(fs) do
    if obj["size"] >= size and path:last() == "/" then
      table.insert(dirs, obj)
    end
  end
  table.sort(dirs, function(a, b) return a["size"] < b["size"] end)
  return dirs[1]
end

function calculate_sizes(fs)
  -- when we process the directories ordered by their path size,
  -- starting with the longest path, we will always start with the deepest
  -- path of each filesystem tree branch.
  -- This way it's guaranteed that the size of the deeper directories is always calculated
  -- before the higher paths

  -- first, create the list of paths
  local paths = {}
  for path, value in pairs(fs) do
    table.insert(paths, path)
  end
  -- order the paths table by path size
  table.sort(paths, function (a, b) return #a > #b end)

  -- start iterating over the table using the sorted array and calculate sizes starting from the longest paths
  for i, path in pairs(paths) do
    if path:last() == "/" then
      fs[path]["size"] = 0
      for filename, obj in pairs(fs[path]["children"]) do
        print(path .. " child "..filename.." size: "..fs[filename]["size"])
        fs[path]["size"] = fs[path]["size"] + fs[filename]["size"]
      end
    end
  end
  -- print paths and sizes
  if (debug) then
    for i, path in pairs(paths) do
      print(path, fs[path]["size"])
      for filename, obj in pairs(fs[path]["children"]) do
        local size = fs[filename]["size"]
        print("\t", filename, size)
      end
    end
  end
end

local fs = create_filesystem(data)
calculate_sizes(fs)

local available = fs_size - fs["/"]["size"]
local missing = update_size - available
print(dir_smallest_after(missing, fs)["size"])
