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
    neofetch
    inxi

    # nix
    nixfmt
    cachix

    # others
    killall
    file
    tree
    tmux
    shellcheck
    (pkgs.writeShellScriptBin "st" (builtins.readFile ../scripts/st.sh))
  ];
}
