[inputs]
  | reduce .[] as $item (
    [[]];
    if $item == "" then
      . + [[]]
    else
      .[0:-1] + [.[-1] + [$item | tonumber]]
    end
  )
  | map(add)
  | sort
  | reverse
  | .[:3]
  | add
