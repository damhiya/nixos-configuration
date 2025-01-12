{ pkgs, ... }:
{
  fonts.packages =
    with pkgs;
    builtins.attrValues iosevka-custom
    ++ [
      nerd-fonts.iosevka
      stix-two
      julia-mono
      sarasa-gothic
      anonymousPro
      source-han-mono
      source-han-sans
      source-han-serif
      noto-fonts
      noto-fonts-cjk-sans
    ];
}
