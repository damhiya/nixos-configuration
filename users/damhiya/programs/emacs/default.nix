{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };
  home.file."init.el" = {
    source = ./init.el;
    target = ".emacs.d/init.el";
  };
}
