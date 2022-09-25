let
  modules = [
    ./bash.nix
    ./git.nix
    ./emacs.nix
    ./foot.nix
    ./direnv.nix
    ./ghc.nix
    ./packages.nix
    ./programs.nix
  ];
in {
  imports = map (m:
    { pkgs, ... }: {
      home-manager.users.damhiya = import m { inherit pkgs; };
    }) modules;

  home-manager.users.damhiya = {
    home.username = "damhiya";
    home.homeDirectory = "/home/damhiya";
    home.stateVersion = "22.05";
  };
}
