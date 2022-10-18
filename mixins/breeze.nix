{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    breeze-qt5
    breeze-gtk
    breeze-icons
  ];
}
