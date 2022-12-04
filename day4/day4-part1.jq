def rangesize:
  .[0] - .[1] | fabs;

def checkpairs:
  .[0] as $fst | .[1] as $snd
  | ($fst | rangesize) as $fstsize | ($snd | rangesize) as $sndsize
  | if $fstsize >= $sndsize then
    $fst[0] <= $snd[0] and $fst[1] >= $snd[1]
  else
    $snd[0] <= $fst[0] and $snd[1] >= $fst[1]
  end;

[inputs]
  | map(
    split(",")
      | map(
        split("-")
        | map(tonumber)
      )
    )
  | map(checkpairs)
  | map(select(.))
  | length

