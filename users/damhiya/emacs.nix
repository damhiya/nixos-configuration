{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    # package = pkgs.emacsPgtk;
  };
}
