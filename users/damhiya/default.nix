let
  modules = [
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
  ];
in { pkgs, config, ... }@args: {
  imports = map (m: { home-manager.users.damhiya = import m args; }) modules;

  home-manager.users.damhiya = {
    home.username = "damhiya";
    home.homeDirectory = "/home/damhiya";
    home.stateVersion = "22.05";
  };
}
