{ pkgs, ... }:
{
  # https://arewewaylandyet.com/
  home.packages = with pkgs; [
    wl-clipboard
    wf-recorder
    fuzzel
    hyprpaper
    hyprpicker
    script-hyprcwd
    grim
    slurp
    libinput
  ];
}
