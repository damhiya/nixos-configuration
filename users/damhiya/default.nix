{ pkgs, config, ... }@args: {
  users.users.damhiya = {
    isNormalUser = true;
    home = "/home/damhiya";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" "vboxusers" ];
    shell = pkgs.fish;
  };

  home-manager.users.damhiya = {
    imports = [
      ./shell.nix
      ./git.nix
      ./emacs.nix
      ./direnv.nix
      ./ghc.nix
      ./packages.nix
      ./programs.nix
      ./kime.nix
      ./x11
    ];

    home.username = "damhiya";
    home.homeDirectory = "/home/damhiya";
    home.stateVersion = "22.05";
  };
}
