package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local data = ftt.load("data.txt")

local win_points = 6
local draw_points = 3
local lose_points = 0

local choice_points = {
  rock = 1,
  paper = 2,
  scissors = 3,
}

function code_to_choice(code)
  if code == "A" or code == "X" then return "rock" end
  if code == "B" or code == "Y" then return "paper" end
  if code == "C" or code == "Z" then return "scissors" end
  return nil
end

function outcome_points(player_choice, opponent_choice)
  local pc = player_choice
  local oc = opponent_choice

  if pc == oc then return draw_points
  elseif pc == "rock" and oc == "scissors" then return win_points
  elseif pc == "paper" and oc == "rock" then return win_points
  elseif pc == "scissors" and oc == "paper" then return win_points
  else return lose_points
  end
end

local points = 0

for i, line in pairs(data) do
  -- relies on strictly formatted input data
  local opponent_choice = code_to_choice(line:sub(1, 1))
  local player_choice = code_to_choice(line:sub(3, 3))
  local outcome = outcome_points(player_choice, opponent_choice)
  local choice = choice_points[player_choice]

  points = points + outcome + choice
end

print(points)
