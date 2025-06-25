{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./ghc.nix
    ./direnv.nix
    ./readline.nix
    ./alacritty.nix
    ./emacs
    ./kime
  ];

  programs = {
    vscode.enable = true;
    firefox.enable = true;
    chromium.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    # CLI utilities
    silver-searcher
    bat
    delta
    duf
    file
    fastfetch
    btop

    # development
    julia
    nixfmt-rfc-style
    shellcheck
    tokei
    neovide
    zed-editor

    # document
    kdePackages.okular
    zathura
    libreoffice
    # pdfpc
    # zotero
    calibre
    pdfgrep

    # media
    ffmpeg
    obs-studio
    krita
    imagemagick
    gcolor3
    nomacs
    # cmus

    # networking
    yt-dlp
    tor-browser-bundle-bin
    zulip
    discord
    slack
    mattermost-desktop
    element-desktop
    session-desktop
    zoom-us
    tdesktop
    qbittorrent

    # others
    helvum
    bitwarden
    cool-retro-term
    happy-hacking-gnu
    pavucontrol
    kdePackages.dolphin
    kdePackages.filelight
    waifu2x-converter-cpp
    tetrio-desktop
    osu-lazer
    steam
    spotify
  ];
}
