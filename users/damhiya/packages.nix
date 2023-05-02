{ pkgs, ... }: {
  home.packages = with pkgs; [
    # development
    julia
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
    silver-searcher
    bat
    delta
    duf
    filelight
    waifu2x-converter-cpp
    osu-lazer
  ];
}
