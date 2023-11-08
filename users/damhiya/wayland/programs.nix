{ pkgs, ... }: {
  # https://arewewaylandyet.com/
  home.packages = with pkgs; [
    wl-clipboard
    wf-recorder
    wdisplays
    fuzzel
    swaybg
    hyprpaper
  ];
}
