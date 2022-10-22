{ pkgs, ... }: {
  imports = [ ./xmonad.nix ./termite.nix ./polybar.nix ./programs.nix ];
}
