package.path = "../?.lua;" .. package.path
local ftt = require("tools.file_to_table")

local data = ftt.load("data.txt")

local win_points = 6
local draw_points = 3
local lose_points = 0

choice_points = {
  rock = 1,
  paper = 2,
  scissors = 3,
}

function code_to_choice(code)
  if code == "A" then return "rock" end
  if code == "B" then return "paper" end
  if code == "C" then return "scissors" end
  return nil
end

function code_to_outcome(code)
  if code == "X" then return "lose" end
  if code == "Y" then return "draw" end
  if code == "Z" then return "win" end
  return nil
end

function outcome_points(player_choice, opponent_choice)
  local oc = opponent_choice
  local pc = player_choice

  if pc == oc then return draw_points
  elseif pc == "rock" and oc == "scissors" then return win_points
  elseif pc == "paper" and oc == "rock" then return win_points
  elseif pc == "scissors" and oc == "paper" then return win_points
  else return lose_points
  end
end

function choice_by(outcome, opponent_choice)
  local oc = opponent_choice
  if outcome == "draw" then return opponent_choice
  elseif oc == "rock" then
    if outcome == "win" then return "paper" else return "scissors" end
  elseif oc == "paper" then
    if outcome == "win" then return "scissors" else return "rock" end
  elseif oc == "scissors" then
    if outcome == "win" then return "rock" else return "paper" end
  else return nil end
end

local points = 0

for i, line in pairs(data) do
  -- relies on strictly formatted input data
  local opponent_choice = code_to_choice(line:sub(1, 1))
  local planned_outcome = code_to_outcome(line:sub(3, 3))
  local player_choice = choice_by(planned_outcome, opponent_choice)
  local outcome = outcome_points(player_choice, opponent_choice)
  local choice = choice_points[player_choice]

  points = points + outcome + choice
end

print(points)
