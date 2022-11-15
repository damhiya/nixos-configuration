{ ... }: {
  home.shellAliases = {
    grep = "grep --color";
    emc = "emacsclient -nc";
    nv = "neovide";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      set -o vi
    '';
  };
}
