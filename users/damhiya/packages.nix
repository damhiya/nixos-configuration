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
    pdfgrep

    # media
    ffmpeg
    krita
    imagemagick
    gcolor2
    mpv
    nomacs
    cmus

    # networking
    microsoft-edge
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
    cool-retro-term
    happy-hacking-gnu
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
