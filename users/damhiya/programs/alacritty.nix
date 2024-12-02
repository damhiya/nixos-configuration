{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      shell = "${pkgs.fish}/bin/fish";
      cursor.style.blinking = "Always";
      font = {
        normal.family = "Iosevka Fixed";
        size = 8.5;
      };
    };
  };
}
