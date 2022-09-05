# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let commonPackages = import ../../common/commonPackages.nix pkgs;
in {
  imports = [ ./hardware-configuration.nix ];

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
    experimental-features = nix-command flakes
  '';
  nix.settings = {
    sandbox = true;
    substituters = [
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://hydra.iohk.io"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
  };
  nixpkgs.config.allowUnfree = true;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "1";
  boot.loader.systemd-boot.editor = false;
  boot.supportedFilesystems = [ "ntfs" "zfs" ];
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  programs.light.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = [
      # vdpau
      pkgs.libvdpau
      # vaapi
      pkgs.intel-media-driver     # "iHD"
      pkgs.vaapiVdpau             # "vdpau"
      pkgs.nvidia-vaapi-driver    # "nvidia"
    ];
  };

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  hardware.bluetooth.enable = true;

  hardware.opentabletdriver.enable = true;
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  networking = {
    hostId = "8d59776a";
    hostName = "mollusca";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    wireless.enable = false;
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 80 443 ];
    firewall.extraCommands = ''
      iptables -A INPUT -p tcp --tcp-flags SYN,ACK SYN,ACK --sport 443 -j NFQUEUE --queue-num 200 --queue-bypass
      iptables -t raw -I PREROUTING -p tcp --sport 443 --tcp-flags SYN,ACK SYN,ACK -j NFQUEUE --queue-num 200 --queue-bypass
      iptables -t raw -I PREROUTING -p tcp --sport 80 --tcp-flags SYN,ACK SYN,ACK -j NFQUEUE --queue-num 200 --queue-bypass
    '';
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "kime";
    kime.config.icon_color = "White";
  };

  # console.font = "Lat2-Terminus16";
  console.keyMap = "us";

  fonts.fonts = import ../../common/fonts.nix pkgs;
  time.timeZone = "Asia/Seoul";

  environment.defaultPackages = commonPackages.defaultPackages;
  environment.systemPackages = commonPackages.systemPackages ++ (with pkgs; [
    cudaPackages_11_2.cudatoolkit
    nvtop
    glxinfo
    vulkan-tools
    glmark2
    pulsemixer
  ]);

  systemd.services.notsodeep = {
    description = "notsodeep";
    serviceConfig = { ExecStart = "${pkgs.notsodeep}/bin/notsodeep"; };
    wantedBy = [ "multi-user.target" ];
  };

  environment.variables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    EGL_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    GDK_BACKEND = "wayland";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "iHD";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
  programs.dconf.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.configure = import ../../common/neovim.nix pkgs;
  services.openssh.enable = true;
  services.thermald.enable = true;
  services.printing.enable = true;
  services.blueman.enable = true;
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
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" "vboxusers" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.damhiya = import ./home-damhiya.nix;

  system.stateVersion = "22.05";
}

