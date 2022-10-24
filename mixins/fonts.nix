{ pkgs, ... }: {
  fonts.fonts = with pkgs;
    builtins.attrValues iosevka-custom ++ [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
      stix-two
      julia-mono
      sarasa-gothic
      anonymousPro
      source-han-mono
      source-han-sans
      source-han-serif
      noto-fonts
      noto-fonts-cjk
    ];
}
