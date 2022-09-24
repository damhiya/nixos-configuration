let modules = [ ./bash.nix ./git.nix ./emacs.nix ./foot.nix ./direnv.nix ];
in {
  imports =
    map (m: args: { home-manager.users.damhiya = import m args; }) modules;

  home-manager.users.damhiya = {
    home.username = "damhiya";
    home.homeDirectory = "/home/damhiya";
    home.stateVersion = "22.05";
  };
}
