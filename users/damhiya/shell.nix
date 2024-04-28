{ ... }: {
  home.shellAliases = {
    grep = "grep --color";
    emc = "emacsclient -nc";
    nv = "neovide";
    xcp = "xclip -selection clipboard";
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
  };
}
