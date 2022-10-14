{ pkgs, config, ... }@args: {
  home-manager.users.damhiya = {
    imports = [
      ./bash.nix
      ./git.nix
      ./emacs.nix
      ./termite.nix
      ./direnv.nix
      ./ghc.nix
      ./packages.nix
      ./programs.nix
      ./kime.nix
      ./xmonad.nix
      ./polybar.nix
    ];

    home.username = "damhiya";
    home.homeDirectory = "/home/damhiya";
    home.stateVersion = "22.05";
  };
}
