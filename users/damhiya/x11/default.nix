{ pkgs, ... }: {
  imports =
    [ ./xmonad ./termite.nix ./polybar.nix ./picom.nix ./programs.nix ];
}
