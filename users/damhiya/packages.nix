{ pkgs, ... }: {
  home.packages = with pkgs; [
    # ocaml & coq
    coq

    # lean
    elan

    # development
    twelf
    chez
    julia-bin
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
    xclip
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
    obsidian
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
