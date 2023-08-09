{ pkgs, ... }: {
  home.packages = with pkgs; [
    # development
    julia
    loc
    neovide

    # document
    texlive.combined.scheme-full
    python3Packages.pygments
    okular
    zathura
    libreoffice
    pdfpc
    zotero
    calibre
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
