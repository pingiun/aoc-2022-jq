def halves:
  [
    .[: . | length / 2 ],
    .[. | length / 2 : ]
  ];

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
    [];
    if $map[($item | numToString)] then
      . + [$item | numToString]
    else
      .
    end
  ) | .[0];

def priority:
  if isLower then
    . - 96
  else
    (. - 64) + 26
  end;

[inputs] | map(halves) | map(.[1] as $secondstr | .[0] | stringToMap | getOverlap($secondstr)) | map(stringToNum | priority) | add
