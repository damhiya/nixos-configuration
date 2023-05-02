# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let commonPackages = import ../../common/commonPackages.nix pkgs;
in {
  imports = [
    ../../modules/nix.nix
    ../../modules/home-manager.nix
    ../../modules/defaultPackages.nix
    ../../modules/sysutils.nix
    ../../modules/pipewire.nix
    ../../modules/bluetooth.nix
    ../../modules/android-file-transfer.nix
    ../../modules/locale.nix
    ../../modules/fonts.nix
    ../../modules/notsodeep.nix
    ../../modules/neovim
    ../../modules/breeze.nix
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

  # graphics
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
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
    cudaPackages.cudatoolkit
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

  services.kmonad = {
    enable = true;
    keyboards.thinkpad-internal = {
      device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
      defcfg = {
        enable = true;
        compose.key = null;
        fallthrough = true;
        allowCommands = false;
      };
      config = ''
        (defsrc
            esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  home end  ins  del
            grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
            caps a    s    d    f    g    h    j    k    l    ;    '         ret
            lsft z    x    c    v    b    n    m    ,    .    /              rsft
                 lctl lmet lalt           spc            ralt sys  rctl pgdn up   pgup
                                                                        left down rght
        )
        (deflayer qwerty
            esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  home end  ins  del
            grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
            lctl a    s    d    f    g    h    j    k    l    ;    '         ret
            lsft z    x    c    v    b    n    m    ,    .    /              rsft
                 lctl lmet lalt           spc            ralt sys  rctl pgdn up   pgup
                                                                        left down rght
        )
      '';
    };
  };

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
    autoRepeatDelay = 165;
    autoRepeatInterval = 50;
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

