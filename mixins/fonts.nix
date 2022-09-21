{ pkgs, ... }: {
  fonts.fonts = with pkgs; [
    stix-two
    julia-mono
    iosevka-bin
    sarasa-gothic
    anonymousPro
    source-han-mono
    source-han-sans-korean
    source-han-serif-korean
    noto-fonts
    noto-fonts-cjk
  ];
}
