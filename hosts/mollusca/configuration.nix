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
    ../../modules/power.nix
    ../../modules/pipewire.nix
    ../../modules/bluetooth.nix
    ../../modules/android-file-transfer.nix
    ../../modules/locale.nix
    ../../modules/fonts.nix
    ../../modules/networking.nix
    ../../modules/neovim
    ../../modules/breeze.nix
    ./hardware-configuration.nix

    ../../users/damhiya
  ];

  nixpkgs.config.allowUnfree = true;

  boot = {
    loader.systemd-boot = {
      enable = true;
      editor = false;
    };
    supportedFilesystems = [ "ntfs" "zfs" ];
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [
      # https://github.com/NVIDIA/open-gpu-kernel-modules/issues/256
      "ibt=off"
      # Prevent hanging while rebooting
      "reboot=acpi"
    ];
  };

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
  };

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
  programs.gnupg.agent = {
    enable = true;
  };
  services.openssh.enable = true;
  services.printing.enable = true;
  services.fprintd.enable = true;
  services.zfs.autoScrub.enable = true;

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
                 lctl lalt lmet           spc            ralt sys  rctl pgdn up   pgup
                                                                        left down rght
        )
      '';
    };
  };

  # Use `systemctl restart display-manager.service` after system switch to take effect of new config
  # See log at /var/log/X.0.log
  services.xserver = {
    enable = true;
    xrandrHeads = [ "eDP-1-1" "DP-2" ];
    dpi = 150;
    # General libinput config
    libinput = {
      enable = true;
      mouse = {
        naturalScrolling = false;
        accelProfile = "flat";
        accelSpeed = "1.0";
      };
      touchpad = {
        naturalScrolling = true;
        accelProfile = "flat";
        accelSpeed = "1.0";
      };
    };
    # Per-device input config
    # man 4 libinput
    # https://unix.stackexchange.com/questions/58117/determine-xinput-device-manufacturer-and-model
    # This has no effect due to low priority
    # # inputClassSections = [ ... ];
    extraConfig = ''
      Section "InputClass"
        Identifier   "Logitech-G302"
        MatchVendor  "Logitech"
        MatchProduct "Gaming Mouse G302"
        Driver       "libinput"
        Option       "ScrollMethod" "button"
        Option       "ScrollButton" "2"
      EndSection

      Section        "InputClass"
        Identifier   "Kensington-SlimBlade-Pro-Trackball"
        MatchVendor  "Kensington"
        MatchProduct "SlimBlade Pro Trackball"
        Driver       "libinput"
        Option       "ScrollMethod" "button"
        Option       "ScrollButton" "8"
        Option       "ScrollButtonLock" "true"
        Option       "ScrollPixelDistance" "50"
      EndSection
    '';
    autoRepeatDelay = 165;
    autoRepeatInterval = 50;
    displayManager = {
      lightdm.enable = true;
      setupCommands = ''
        xrandr --output eDP-1-1 --primary
        xrandr --output DP-2 --right-of eDP-1-1
      '';
    };
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hsPkgs: with hsPkgs; [ PyF ];
    };
    # View current xorg configuration at /etc/X11/xorg.conf
    exportConfiguration = true;
  };

  system.stateVersion = "22.05";
}

