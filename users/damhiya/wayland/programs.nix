{ pkgs, ... }: {
  home.packages = with pkgs; [
    wl-clipboard
    wf-recorder
    wdisplays
    fuzzel
    swaybg
  ];
}
