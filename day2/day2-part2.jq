def outcomeScore:
  if .[0] == "A" and .[1] == "X" then # Rock, Lose
    3 + 0
  elif .[0] == "A" and .[1] == "Y" then # Rock, Draw
    1 + 3
  elif .[0] == "A" and .[1] == "Z" then # Rock, Win
    2 + 6
  elif .[0] == "B" and .[1] == "X" then # Paper, Lose
    1 + 0
  elif .[0] == "B" and .[1] == "Y" then # Paper, Draw
    2 + 3
  elif .[0] == "B" and .[1] == "Z" then # Paper, Win
    3 + 6
  elif .[0] == "C" and .[1] == "X" then # Scissors, Lose
    2 + 0
  elif .[0] == "C" and .[1] == "Y" then # Scissors, Draw
    3 + 3
  elif .[0] == "C" and .[1] == "Z" then # Scissors, Win
    1 + 6
  else
    -1
  end;

[inputs] | map(split(" ")) | map(outcomeScore) | add
