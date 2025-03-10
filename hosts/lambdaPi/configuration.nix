{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../modules/nix.nix
    ../../modules/home-manager.nix
    ../../modules/defaultPackages.nix
    ../../modules/sysutils.nix
    ../../modules/bluetooth.nix
    ../../modules/locale.nix
    ../../modules/fonts.nix
    ../../modules/networking.nix
    ../../modules/neovim
    ./hardware-configuration.nix

    ../../users/damhiya
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "1";
  boot.loader.systemd-boot.editor = false;
  boot.kernelParams = [ "reboot=acpi" ];
  boot.supportedFilesystems = [ "ntfs" ];

  hardware.acpilight.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = [
      # vdpau
      pkgs.libvdpau
      # vaapi
      pkgs.intel-media-driver # "iHD"
      pkgs.vaapiVdpau # "vdpau"
      pkgs.nvidia-vaapi-driver # "nvidia"
    ];
  };

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  hardware.opentabletdriver.enable = true;
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  networking = {
    hostName = "lambdaPi";
  };

  console.keyMap = "us";

  environment.systemPackages = with pkgs; [
    cudaPackages_11_2.cudatoolkit
    nvtopPackages.full
    glxinfo
    vulkan-tools
    glmark2
    pulsemixer
  ];

  environment.variables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    EGL_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    GDK_BACKEND = "wayland";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "iHD";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    # WLR_NO_HARDWARE_CURSORS = "1";
  };
  programs.dconf.enable = true;
  services.openssh.enable = true;
  services.thermald.enable = true;
  services.printing.enable = true;
  xdg.mime.defaultApplications = {
    # firefox
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/chrome" = "firefox.desktop";
    "text/html" = "firefox.desktop";
    "application/x-extension-htm" = "firefox.desktop";
    "application/x-extension-html" = "firefox.desktop";
    "application/x-extension-shtml" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";
    "application/x-extension-xhtml" = "firefox.desktop";
    "application/x-extension-xht" = "firefox.desktop";

    "application/pdf" = "okularApplication_pdf.desktop";
    "image/bnd.djvu" = "okularApplication_djvu.desktop";
    "image/png" = "org.nomacs.ImageLounge.desktop";
    "image/bmp" = "org.nomacs.ImageLounge.desktop";
    "image/jpeg" = "org.nomacs.ImageLounge.desktop";
    "image/gif" = "org.nomacs.ImageLounge.desktop";
    "image/tiff" = "org.nomacs.ImageLounge.desktop";
  };

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  users.users.damhiya = {
    isNormalUser = true;
    home = "/home/damhiya";
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "docker"
      "vboxusers"
    ];
  };

  system.stateVersion = "22.05";
}
