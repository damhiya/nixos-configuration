{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
  };
  home.file."init.el" = {
    source = ./init.el;
    target = ".emacs.d/init.el";
  };
}
