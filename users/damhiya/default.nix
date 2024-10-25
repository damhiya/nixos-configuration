{ pkgs, config, ... }@args: {
  users.users.damhiya = {
    isNormalUser = true;
    home = "/home/damhiya";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "input" "uinput" "docker" "vboxusers" ];
  };

  home-manager.users.damhiya = {
    imports = [
      ./shell.nix
      ./programs
      ./x11
      ./mimeApps.nix
      ./theme.nix
    ];

    home.username = "damhiya";
    home.homeDirectory = "/home/damhiya";
    home.sessionVariables = {
      WINIT_X11_SCALE_FACTOR = "2.0";
    };
    home.stateVersion = "22.05";
  };
}
