{ pkgs, ... }: {
  programs.vscode.enable = true;
  programs.firefox.enable = true;
  programs.chromium.enable = true;
  programs.mpv.enable = true;

  home.packages = with pkgs; [
    # CLI utilities
    rlwrap
    silver-searcher
    bat
    delta
    duf
    file

    # development
    julia
    nixfmt
    shellcheck
    loc
    neovide

    # document
    okular
    zathura
    libreoffice
    pdfpc
    # zotero
    calibre
    pdfgrep

    # media
    ffmpeg
    krita
    imagemagick
    gcolor2
    nomacs
    # cmus

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
    helvum
    bitwarden
    cool-retro-term
    happy-hacking-gnu
    pavucontrol
    dolphin
    filelight
    waifu2x-converter-cpp
    tetrio-desktop
    osu-lazer
    steam
    spotify
  ];
}
