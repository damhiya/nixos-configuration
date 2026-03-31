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
    julia-bin
    nixfmt
    shellcheck
    tokei
    neovide
    zed-editor
    claude-code

    # document
    kdePackages.okular
    zathura
    libreoffice
    calibre
    pdfgrep

    # media
    ffmpeg
    obs-studio
    krita
    imagemagick
    gcolor3
    nomacs
    yt-dlp

    # networking
    tor-browser
    zulip
    discord
    slack
    mattermost-desktop
    element-desktop
    session-desktop
    zoom-us
    telegram-desktop
    qbittorrent

    # others
    bitwarden-desktop
    happy-hacking-gnu
    kdePackages.dolphin
    kdePackages.filelight
    osu-lazer
    steam
    spotify
  ];
}
