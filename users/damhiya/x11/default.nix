{ pkgs, ... }: {
  imports =
    [ ./xmonad ./polybar.nix ./picom.nix ./programs.nix ];
}
