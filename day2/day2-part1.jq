def shapeScore:
  explode | .[0] - 87;
def outcomeScore:
  if (.[0] | explode | .[0] - 65) == (.[1] | explode | .[0] - 88) then
    3
  elif .[0] == "A" and .[1] == "Y" then # Rock, Paper
    6 # Paper wins
  elif .[0] == "A" and .[1] == "Z" then # Rock, Scissors
    0
  elif .[0] == "B" and .[1] == "X" then # Paper, Rock
    0
  elif .[0] == "B" and .[1] == "Z" then # Paper, Scissors
    6
  elif .[0] == "C" and .[1] == "X" then # Scissors, Rock
    6
  elif .[0] == "C" and .[1] == "Y" then # Scissors, Paper
    0
  else
    error("Invalid rock/paper/scissors")
  end;
def score:
  [outcomeScore, (.[1] | shapeScore)] | add;

[inputs] | map(split(" ")) | map(score) | add
