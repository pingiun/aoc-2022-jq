def splitempty:
  reduce .[] as $item (
    [[]];
    if $item == "" then
      . + [[]]
    else
      .[0:-1] + [.[-1] + [$item]]
    end
  );

def chunks($n):
 def _chunks:
   if length <= $n then . else .[0:$n] , (.[$n:]|_chunks) end;
 _chunks;

def chunk:
  map([chunks(4)]) | transpose | map(reverse) | map(map(gsub("^\\s+|\\s+$";"") | select(. != "") | .[1:2]));

def applyMove($from; $to):
  .[$to] += [.[$from][-1]]
  | .[$from][-1] |= empty;

def applyMoves($move):
  $move[0] as $repeat |
  ($move[1] - 1) as $from |
  ($move[2] - 1) as $to |
  .[$to] += .[$from][-($repeat):]
  | .[$from][-($repeat):] |= empty;

[inputs]
  | splitempty
  | .[0] |= [.[0:-1]]
  | .[0] |= (.[0] | chunk)
  | .[1] |= (map(gsub("move "; "") | gsub(" from "; ",") | gsub(" to "; ",") | split(",") | map(tonumber)))
  | .[0] as $crates
  | .[1] as $moves
  | reduce ($moves | .[]) as $move ($crates; applyMoves($move))
  | map(.[-1])
  | join("")
