{ pkgs, ... }: {
  fonts.fonts = with pkgs; [
    stix-two
    julia-mono
    iosevka-bin
    sarasa-gothic
    anonymousPro
    source-han-mono
    source-han-sans
    source-han-serif
    noto-fonts
    noto-fonts-cjk
  ];
}
