PROFILE_PATH=/nix/var/nix/profiles
nums=$( find $PROFILE_PATH -type l \
      | awk "match(\$0, /^${PROFILE_PATH//\//\\\/}\/system-([0-9]*)-link\$/, res) { print res[1] }" \
      | sort \
      )
current=$( readlink "$PROFILE_PATH/system" \
         | awk "match(\$0, /^system-([0-9]*)-link\$/, res) { print res[1] }" \
         )
for num in $nums; do
  link="$PROFILE_PATH/system-$num-link"
  date=$(date -d "@$(stat --printf "%W" "$link")" "+%F %T")
  if [ -e "$link/boot.json" ] ; then
    info=$(jq -r '."org.nixos.bootspec.v1"."label"' <"$link/boot.json")
  else
    # Some old profiles may have no boot.json
    nixosVersion=$(cat "$link/nixos-version")
    kernelVersion=$( readlink "$link/kernel" \
                   | awk "match(\$0, /^.*-linux-([0-9.]*)\/.*/, res) { print res[1] }" \
                   )
    info="NixOS       $nixosVersion (Linux $kernelVersion)"
  fi
  if [ $num -eq $current ] ; then
    cur="*"
  else
    cur=" "
  fi
  echo "$cur $num   $date   $info"
done
