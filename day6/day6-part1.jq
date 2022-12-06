def windows($n):
  def _windows:
    if length <= $n then . else .[0:$n] , (.[1:]|_windows) end;
  _windows;

def enumerate:
  def _enumerate($n):
    if length >= 1 then [$n, .[0]], (.[1:] | _enumerate($n + 1)) else empty end;
  _enumerate(0);

def numToString:
  [.] | implode;

def stringToMap:
  reduce (. | explode | .[]) as $item ({}; . + {($item | numToString): true});

inputs | [windows(4)] | [enumerate] | map(.[1] |= stringToMap) | map(.[1] |= length) | map(select(.[1] == 4)) | first | first + 4
