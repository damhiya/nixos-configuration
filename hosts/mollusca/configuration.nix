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
    ../../modules/power.nix
    # I have a problem with audio on my machine which uses Realtek ALC3306 codec.
    # AlsaMixer reports that the chip is 'Realtek ALC287' which is not true.
    ../../modules/pipewire.nix
    ../../modules/bluetooth.nix
    ../../modules/locale.nix
    ../../modules/fonts.nix
    ../../modules/networking.nix
    ../../modules/neovim
    ../../modules/xmonad.nix
    ../../modules/xinput.nix
    ./hardware-configuration.nix

    ../../users/damhiya
  ];

  # allow unfree
  nixpkgs.config.allowUnfree = true;

  # boot
  boot = {
    loader.systemd-boot = {
      enable = true;
      editor = false;
    };
    supportedFilesystems = [
      "ntfs"
      "zfs"
    ];
    kernelPackages = pkgs.linuxPackages;
    kernelParams = [
      # https://github.com/NVIDIA/open-gpu-kernel-modules/issues/256
      "ibt=off"
      # Prevent hanging while rebooting
      "reboot=acpi"
      # https://wiki.hyprland.org/Nvidia/
      # "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  };

  # networking
  networking = {
    hostId = "8d59776a";
    hostName = "mollusca";
  };

  # graphics
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = true;
    # https://nixos.wiki/wiki/Nvidia
    # https://github.com/NixOS/nixpkgs/issues/73494
    # https://github.com/hyprwm/Hyprland/issues/2950
    # https://github.com/hyprwm/Hyprland/issues/6345
    # https://github.com/NVIDIA/open-gpu-kernel-modules/issues/472
    # https://github.com/NVIDIA/open-gpu-kernel-modules/issues/662
    # powerManagement.enable = true;
    # powerManagement.finegrained = true;
    # prime = {
    #   sync.enable = true;
    #   intelBusId = "PCI:0:2:0";
    #   nvidiaBusId = "PCI:1:0:0";
    # };
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [
      # vdpau
      pkgs.libvdpau
      # vaapi
      pkgs.intel-media-driver # "iHD"
      # pkgs.vaapiVdpau             # "vdpau"
      # pkgs.nvidia-vaapi-driver    # "nvidia"
    ];
  };
  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
    nvtopPackages.full
    glxinfo
    vulkan-tools
    glmark2
  ];

  hardware.opentabletdriver.enable = true;
  # rtkit is recommended for pipewire. See https://nixos.wiki/wiki/PipeWire
  security.rtkit.enable = true;

  console.keyMap = "us";

  environment.variables = {
    # https://wiki.archlinux.org/title/HiDPI#Qt_5
    QT_AUTO_SCREEN_SCALE_FACTOR = "0";
    QT_ENABLE_HIGHDPI_SCALING = "0";
    QT_SCALE_FACTOR = "1.8";

    LIBVA_DRIVER_NAME = ""; # use nvdec rather than vaapi
    BROWSER = "firefox";
    MOZ_USE_XINPUT2 = "1";
  };

  programs.light.enable = true;
  programs.dconf.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
  services.openssh.enable = true;
  services.printing.enable = true;
  services.fprintd.enable = true;
  services.zfs.autoScrub.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  services.kmonad = {
    enable = true;
    keyboards = {
      thinkpad-internal = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        defcfg = {
          enable = true;
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
      hhkb = {
        device = "/dev/input/by-id/usb-PFU_Limited_HHKB-Classic-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };
        config = ''
          (defsrc
              esc  1    2    3    4    5    6    7    8    9    0    -    =    \    grv
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    bspc
              lctl a    s    d    f    g    h    j    k    l    ;    '         ret
              lsft z    x    c    v    b    n    m    ,    .    /              rsft
                        lalt lmet           spc            rmet ralt
          )
          (deflayer qwerty
              esc  1    2    3    4    5    6    7    8    9    0    -    =    \    grv
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    bspc
              lctl a    s    d    f    g    h    j    k    l    ;    '         ret
              lsft z    x    c    v    b    n    m    ,    .    /              rsft
                        lalt lmet           spc            rmet ralt
          )
        '';
      };
    };
  };

  system.stateVersion = "22.05";
}
