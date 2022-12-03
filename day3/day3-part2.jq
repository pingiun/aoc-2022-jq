def numToString:
  [.] | implode;

def stringToNum:
  explode | .[0];

def isLower:
  . > 96 and . < 123;

def stringToMap:
  reduce (. | explode | .[]) as $item ({}; . + {($item | numToString): true});

def getOverlap($str):
  . as $map |
  reduce ($str | explode | .[]) as $item (
    {};
    if $map[($item | numToString)] then
      . + {($item | numToString): true}
    else
      .
    end
  );

def priority:
  if isLower then
    . - 96
  else
    (. - 64) + 26
  end;

def chunks($n):
 def _chunks:
   if length <= $n then . else .[0:$n] , (.[$n:]|_chunks) end;
 _chunks;

[inputs]
  | [chunks(3)]
  | map(
    .[1] as $second
    | .[2] as $third
    | .[0]
    | stringToMap
    | getOverlap($second)
    | getOverlap($third)
    | to_entries
    | .[0].key
  )
  | map(stringToNum | priority)
  | add
