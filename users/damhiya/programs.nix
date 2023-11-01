{ pkgs, ... }: {
  programs.vscode.enable = true;
  programs.firefox.enable = true;
  programs.chromium.enable = true;
  programs.mpv.enable = true;

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
    bitwarden
    cool-retro-term
    happy-hacking-gnu
    pavucontrol
    dolphin
    obsidian
    rlwrap
    silver-searcher
    bat
    delta
    duf
    filelight
    waifu2x-converter-cpp
    osu-lazer
    steam
  ];
}
