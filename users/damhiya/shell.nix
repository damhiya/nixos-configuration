{ ... }: {
  home.shellAliases = {
    grep = "grep --color";
    emc = "emacsclient -nc";
    nv = "neovide --multigrid";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      set -gx GPG_TTY (tty)
    '';
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      set -o vi
    '';
  };
}
