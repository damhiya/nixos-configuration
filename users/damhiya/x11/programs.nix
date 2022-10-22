{ pkgs, ... }: {
  programs.feh.enable = true;
  programs.rofi.enable = true;
  home.packages = with pkgs; [ xclip xcwd arandr ];
}
