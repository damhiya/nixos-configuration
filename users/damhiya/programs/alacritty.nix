{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = "${pkgs.fish}/bin/fish";
      cursor.style.blinking = "Always";
      font = {
        normal.family = "Iosevka Fixed";
        size = 8.5;
      };
    };
  };
}
