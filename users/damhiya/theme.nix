{ pkgs, config, ... }:
{
  home.pointerCursor = {
    package = pkgs.kdePackages.breeze;
    name = "breeze_cursors";
    size = 32;
    x11.enable = true;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    font = {
      name = "Noto Sans";
      size = 10;
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    theme = {
      package = pkgs.kdePackages.breeze-gtk;
      name = "breeze";
    };
    iconTheme = {
      package = pkgs.kdePackages.breeze-gtk;
      name = "breeze";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style = {
      package = pkgs.kdePackages.breeze;
      name = "breeze";
    };
  };

  home.packages = with pkgs; [
    kdePackages.breeze-icons
  ];
}
