{ pkgs, ... }:
{
  programs.feh.enable = true;
  programs.rofi.enable = true;
  home.packages = with pkgs; [
    xorg.xwininfo
    autorandr
    xclip
    xcwd
    arandr
  ];
}
