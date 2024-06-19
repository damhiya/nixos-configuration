{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # hardware management
    efibootmgr
    pciutils
    usbutils
    gptfdisk

    # compressors
    zip
    unzipNLS
    zstd
    lz4
    p7zip

    # monitoring tools
    lm_sensors
    smartmontools
    htop
    inxi

    # nix
    cachix

    # others
    android-file-transfer
    killall
    tree
    tmux
    scripts.st
    scripts.nixos-profile
  ];
}
