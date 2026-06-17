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
    ../../modules/tailscale.nix
    ../../modules/zapret.nix
    ../../modules/neovim
    ./hardware-configuration.nix
    ./kmonad.nix

    ../../users/damhiya
  ];

  # hostPlatform
  nixpkgs.hostPlatform = "x86_64-linux";

  # boot
  boot = {
    loader.systemd-boot = {
      enable = true;
      editor = false;
    };
    supportedFilesystems = [
      "ntfs"
      "zfs"
      "nfs"
    ];
    zfs.forceImportRoot = false;
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
    nvtopPackages.full
    mesa-demos
    vulkan-tools
    glmark2
  ];

  hardware.opentabletdriver.enable = true;
  # rtkit is recommended for pipewire. See https://nixos.wiki/wiki/PipeWire
  security.rtkit.enable = true;

  console.keyMap = "us";

  programs.dconf.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;
  services.fprintd.enable = true;
  services.zfs.autoScrub.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  system.stateVersion = "22.05";
}
