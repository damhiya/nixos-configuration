{ ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "fish";
        font = "Iosevka Fixed:size=11";
      };
      colors = {
        alpha = "1.0";
        foreground = "ffffff";
        background = "000000";

        regular0 = "7f8c98";
        regular1 = "ff8170";
        regular2 = "acf2e4";
        regular3 = "ffa14f";
        regular4 = "6bdfff";
        regular5 = "ff7ab2";
        regular6 = "dabaff";
        regular7 = "dfdfe0";

        dim0 = "414453";
        dim1 = "ff8170";
        dim2 = "78c2b3";
        dim3 = "d9c97c";
        dim4 = "4eb0cc";
        dim5 = "ff7ab2";
        dim6 = "b281eb";
        dim7 = "dfdfe0";
      };
    };
  };
}
