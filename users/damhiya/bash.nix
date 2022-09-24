{ ... }: {
  programs.bash = {
    enable = true;
    initExtra = ''
      set -o vi
    '';
    shellAliases = {
      grep = "grep --color";
      emc = "emacsclient -nc";
      nv = "neovide";
    };
  };
}
