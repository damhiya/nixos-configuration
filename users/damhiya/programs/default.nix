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
    firefox = {
      enable = true;
      configPath = ".mozilla/firefox";
      # TODO: Use configPath = "${config.xdg.configHome}/mozilla/firefox"
    };
    chromium.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    # CLI utilities
    ripgrep
    fzf
    bat
    delta
    duf
    file
    fastfetch
    btop
    jq

    # development
    julia-bin
    nixfmt
    shellcheck
    tokei
    neovide
    zed-editor
    claude-code
    codex

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
