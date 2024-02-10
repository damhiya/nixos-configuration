#!@shell@
export PATH="@jq@/bin:@hyprland@/bin:@coreutils@/bin"

read wpid class < <(echo $(hyprctl activewindow -j | jq -r ".pid, .class"))
case "$class" in
  foot|neovide)
    pid=$(pgrep --newest --parent "${wpid}")
    readlink "/proc/${pid}/cwd"
    ;;
  *)
    exit -1
esac
