{ pkgs, config, ... }@args:
{
  users.users.damhiya = {
    isNormalUser = true;
    home = "/home/damhiya";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
      "uinput"
      "docker"
      "vboxusers"
    ];
  };

  home-manager.users.damhiya = {
    imports = [
      ./shell.nix
      ./programs
      ./wayland
      ./mimeApps.nix
      ./theme.nix
    ];

    home.username = "damhiya";
    home.homeDirectory = "/home/damhiya";
    home.sessionVariables = {
      WINIT_X11_SCALE_FACTOR = "2.0";

      # https://wiki.archlinux.org/title/HiDPI#Qt_5
      QT_AUTO_SCREEN_SCALE_FACTOR = "0";
      QT_ENABLE_HIGHDPI_SCALING = "0";
      QT_SCALE_FACTOR = "1";

      LIBVA_DRIVER_NAME = ""; # use nvdec rather than vaapi
      BROWSER = "firefox";
      MOZ_USE_XINPUT2 = "1";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
    };
    home.stateVersion = "22.05";
  };
}
