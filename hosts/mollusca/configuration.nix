# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let commonPackages = import ../../common/commonPackages.nix pkgs;
in {
  imports = [
    ../../mixins/nix.nix
    ../../mixins/home-manager.nix
    ../../mixins/defaultPackages.nix
    ../../mixins/sysutils.nix
    ../../mixins/pipewire.nix
    ../../mixins/bluetooth.nix
    ../../mixins/android-file-transfer.nix
    ../../mixins/compilers.nix
    ../../mixins/locale.nix
    ../../mixins/fonts.nix
    ../../mixins/notsodeep.nix
    ../../mixins/neovim
    ../../mixins/breeze.nix
    ./hardware-configuration.nix

    ../../users/damhiya
  ];

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

  hardware.opentabletdriver.enable = true;
  security.rtkit.enable = true;

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

  # console.font = "Lat2-Terminus16";
  console.keyMap = "us";

  environment.systemPackages = with pkgs; [
    cudaPackages_11_2.cudatoolkit
    nvtop
    glxinfo
    vulkan-tools
    glmark2
  ];

  environment.variables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    LIBVA_DRIVER_NAME = "iHD";
    BROWSER = "firefox";
    MOZ_USE_XINPUT2 = "1";
  };
  programs.dconf.enable = true;
  services.openssh.enable = true;
  services.thermald.enable = true;
  services.printing.enable = true;
  services.blueman.enable = true;
  services.fprintd.enable = true;
  services.zfs.autoScrub.enable = true;
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
  services.xserver = {
    enable = true;
    xrandrHeads = [ "eDP-1-1" "DP-2" ];
    dpi = 150;
    libinput.enable = true;
    libinput.touchpad = {
      naturalScrolling = true;
      accelProfile = "flat";
      accelSpeed = "1.0";
    };
    displayManager = {
      lightdm.enable = true;
      setupCommands = ''
        xrandr --output eDP-1-1 --primary
        xrandr --output DP-2 --right-of eDP-1-1
      '';
    };
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
  };

  system.stateVersion = "22.05";
}

