{ pkgs, ... }: {
  home.packages = with pkgs; [
    # ocaml & coq
    coq_8_16

    # lean
    elan

    # development
    twelf
    ocamlPackages.elpi
    chez
    julia-bin
    nasm
    smlnj
    teyjus
    rustup
    loc
    gnuplot
    neovide

    # document
    texlive.combined.scheme-full
    python3Packages.pygments
    pandoc
    okular
    zathura
    libreoffice
    pdfpc
    mendeley
    zotero

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
    element-desktop
    zoom-us
    tdesktop
    qbittorrent

    # others
    pavucontrol
    dolphin
    obsidian
    bat
    delta
    duf
    ranger
    joshuto
    filelight
    waifu2x-converter-cpp
    osu-lazer
  ];
}
