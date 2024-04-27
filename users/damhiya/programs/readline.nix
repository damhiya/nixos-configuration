{ pkgs, ... }: {
  programs.readline = {
    enable = true;
    variables.editing-mode = "vi";
  };

  home.packages = [ pkgs.rlwrap ];
}
