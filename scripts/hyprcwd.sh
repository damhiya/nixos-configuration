wpid=$(hyprctl activewindow -j | jq ".pid")
pid=$(pgrep --newest --parent "${wpid}")
readlink "/proc/${pid}/cwd" || echo "$HOME"
