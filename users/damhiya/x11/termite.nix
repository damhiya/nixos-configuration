{ ... }: {
  programs.termite = {
    enable = true;
    font = "Iosevka Fixed 11";
    scrollbackLines = -1;
    scrollbar = "off";

    foregroundColor = "#ffffff";
    foregroundBoldColor = "#ffffff";
    backgroundColor = "rgba(0,0,0,0.6)";
    cursorColor = "#ffffff";

    colorsExtra = ''
      # black
      color0  = #414453
      color8  = #7f8c98

      # red
      color1  = #ff8170
      color9  = #ff8170

      # green
      color2  = #78c2b3
      color10 = #acf2e4

      # yellow
      color3  = #d9c97c
      color11 = #ffa14f

      # blue
      color4  = #4eb0cc
      color12 = #6bdfff

      # magenta
      color5  = #ff7ab2
      color13 = #ff7ab2

      # cyan
      color6  = #b281eb
      color14 = #dabaff

      # white
      color7  = #dfdfe0
      color15 = #dfdfe0
    '';
  };
}
