let modules = [ ./git.nix ];
in {
  imports = map (m: { home-manager.users.damhiya = m; }) modules;

  home-manager.users.damhiya = {
    home.username = "damhiya";
    home.homeDirectory = "/home/damhiya";
    home.stateVersion = "22.05";
  };
}
