{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # hardware maanagement
    efibootmgr
    pciutils
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
    neofetch

    # nix
    nixfmt
    cachix

    # others
    killall
    file
    tree
    tmux
    shellcheck
  ];
}
