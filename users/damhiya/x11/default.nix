{ pkgs, ... }: {
  imports =
    [ ./xmonad.nix ./termite.nix ./polybar.nix ./picom.nix ./programs.nix ];
}
