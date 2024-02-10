#!@shell@
export PATH="@jq@/bin:@gawk@/bin:@findutils@/bin:@coreutils@/bin"
PROFILE_DIR=/nix/var/nix/profiles

get_list() {
  find $PROFILE_DIR -type l \
  | awk "match(\$0, /^${PROFILE_DIR//\//\\\/}\/system-([0-9]*)-link\$/, res) { print res[1] }" \
  | sort
}

get_current() {
  readlink "$PROFILE_DIR/system" \
  | awk 'match($0, /^system-([0-9]*)-link$/, res) { print res[1] }'
}

# list
list() {
  if [ $# -ne 0 ] ; then
    echo "nixos-profile ls : wrong argument"
    exit
  fi
  nums=$(get_list)
  current=$(get_current)
  for num in $nums; do
    link="$PROFILE_DIR/system-$num-link"
    date=$(date -d "@$(stat --printf "%W" "$link")" "+%F %T")
    if [ -e "$link/boot.json" ] ; then
      info=$(jq -r '."org.nixos.bootspec.v1"."label"' <"$link/boot.json")
    else
      # Some old profiles may have no boot.json
      nixosVersion=$(cat "$link/nixos-version")
      kernelVersion=$( readlink "$link/kernel" \
                     | awk 'match($0, /^.*-linux-([0-9.]*)\/.*/, res) { print res[1] }' \
                     )
      info="NixOS       $nixosVersion (Linux $kernelVersion)"
    fi
    cfg=$("$link/sw/bin/nixos-version" --configuration-revision)
    if [ "$num" = "$current" ] ; then
      cur="*"
    else
      cur=" "
    fi
    echo "$cur $num   $date   $info configRev=$cfg"
  done
}

# remove
remove_single() {
  num=$1
  current=$(get_current)
  if [ "$num" = "$current" ] ; then
    echo "You should not remove current profile $current"
    exit
  elif [ ! -e "$PROFILE_DIR/system-$num-link" ] ; then
    echo "No such profile exists : $num"
    exit
  fi
  echo "remove $num"
  rm "$PROFILE_DIR/system-$num-link"
}

remove_range() {
  min=$1
  max=$2
  nums=$(get_list)
  current=$(get_current)
  if [ "$min" -le "$current" ] && [ "$current" -le "$max" ] ; then
    echo "You should not remove current profile $current : $current is included in the range [$min-$max]"
    exit
  fi
  for num in $nums ; do
    if [ "$min" -le "$num" ] && [ "$num" -le "$max" ] ; then
      echo "remove $num"
      rm "$PROFILE_DIR/system-$num-link"
    fi
  done
}

remove() {
  if [ $# -ne 1 ] ; then
    echo "nixos-profile rm : wrong argument"
    exit
  fi
  if (echo "$1" | awk -v r=1 '/^[0-9]+$/{r=0} END{exit r}'); then
    remove_single "$1"
  elif range=$(echo "$1" | awk -v r=1 'match($0, /^\[([0-9]+)-([0-9]+)\]$/, res) {r=0; print res[1], res[2]} END{exit r}'); then
    read -r min max <<< "$range"
    remove_range "$min" "$max"
  else
    echo "rm: no parse"
  fi
}

# main
if [ $# = 0 ] ; then
  echo "Usage: nixos-profile ls"
  echo "Usage: nixos-profile rm num"
  echo "Usage: nixos-profile rm [min-max]"
elif [ "$1" = "ls" ] ; then
  list "${@:2}"
elif [ "$1" = "rm" ] ; then
  remove "${@:2}"
else
  echo "no parse"
fi
