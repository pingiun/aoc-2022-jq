def cd($dir):
  if $dir == "/" then
    []
  elif $dir == ".." then
    .[0:-1]
  else
    . + [$dir]
  end;

def path:
  "/" + join("/");

def exec($item):
  if $item | startswith("$ cd") then
    .cwd |= cd($item | ltrimstr("$ cd "))
  elif $item | test("\\d") then
    .cwd as $cwd | .files += {($cwd + [$item | split(" ")[1]] | path): $item | split(" ")[0] | tonumber}
  else
    .
  end;

def dirprefixes:
  def prefixes:
    if . == [] then
      ["/"]
    else
      [path] + (.[0:-1] | prefixes)
    end;
  . | split("/") | .[1:-1] | prefixes;

[inputs] | reduce (.[]) as $item ({"cwd": [], "files": {}}; . | exec($item)) | .files as $files
  | $files | to_entries | map(.key | dirprefixes) | flatten | reduce .[] as $item ({}; .[$item] = true) | keys
  | reduce (.[]) as $dir ({}; .[$dir] = ($files | to_entries | map(select(.key | startswith($dir))) | map(.value) | add))
  | to_entries | sort_by(.value) as $dirs
  | $dirs | last | (30000000 - (70000000 - .value)) as $needed
  | $dirs | map(select(.value >= $needed)) | first | .value
