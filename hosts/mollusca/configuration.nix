{ config, pkgs, lib, ... }: {
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
    ../../modules/breeze.nix
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
    supportedFilesystems = [ "ntfs" "zfs" ];
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [
      # https://github.com/NVIDIA/open-gpu-kernel-modules/issues/256
      "ibt=off"
      # Prevent hanging while rebooting
      "reboot=acpi"
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
  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
    nvtop
    glxinfo
    vulkan-tools
    glmark2
  ];

  hardware.opentabletdriver.enable = true;
  # rtkit is recommended for pipewire. See https://nixos.wiki/wiki/PipeWire
  security.rtkit.enable = true;

  console.keyMap = "us";

  environment.variables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    LIBVA_DRIVER_NAME = "iHD";
    BROWSER = "firefox";
    MOZ_USE_XINPUT2 = "1";
  };

  programs.light.enable = true;
  programs.dconf.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "tty";
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
    dpi = 150;
    displayManager.lightdm.enable = true;
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

