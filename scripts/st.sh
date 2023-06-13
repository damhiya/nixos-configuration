if [ $# = 0 ] ; then
  echo "st: no argument"
elif [ $# -ge 2 ] ; then
  echo "st: too many arguments"
elif [ ! -L "$1" ] ; then
  echo "st: $1 is not a link"
else
  cp --remove-destination "$(readlink "$1")" "$1"
  chmod +w "$1"
fi
