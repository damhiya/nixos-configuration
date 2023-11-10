{ pkgs, ... }: {
  imports = [ ./programs.nix ./hyprland.nix ./foot.nix ./waybar.nix ];
}
