pkgs: {
  defaultPackages = with pkgs; [ perl rsync strace killall htop curl wget ];

  systemPackages = with pkgs; [
    # devel
    llvm_14
    clang_14
    lldb_14

    gcc12
    gfortran12
    gdb
    binutils

    git
    gnumake
    ninja
    cmake
    nixfmt
    shellcheck
    cachix

    # utils
    zip
    unzipNLS
    zstd
    lz4
    p7zip

    file
    tree
    pciutils
    lm_sensors
    smartmontools
    notsodeep
    android-file-transfer
    neofetch

    tmux
    xclip
  ];

  userPackages = let hsPkgs = pkgs: with pkgs; [ split ieee754 vector async ];
  in with pkgs; [
    # haskell & agda
    (ghc.withPackages hsPkgs)
    cabal-install
    hpack
    cabal2nix
    agda
    haskellPackages.fix-whitespace

    # ocaml & coq
    coq

    # lean
    elan

    # development
    twelf
    chez
    julia_17-bin
    nasm
    smlnj
    mercury
    teyjus
    rustup
    loc
    gnuplot
    neovide
    # mkl

    # document
    texlive.combined.scheme-full
    python3Packages.pygments
    pandoc
    okular
    zathura
    libreoffice
    pdfpc
    mendeley

    # media
    ffmpeg
    krita
    imagemagick
    gcolor2
    mpv
    nomacs

    # networking
    youtube-dl
    tor-browser-bundle-bin
    zulip
    discord
    slack
    zoom-us
    tdesktop
    qbittorrent

    # DE
    wl-clipboard
    wf-recorder
    wdisplays
    fuzzel
    swaybg
    polybar
    breeze-qt5
    breeze-icons
    dolphin
    arandr

    # others
    bat
    delta
    duf
    ranger
    joshuto
    filelight
    waifu2x-converter-cpp
    osu-lazer
    # singularity
    # steam
  ];
}
