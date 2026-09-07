{ ... }:
{
  home.shellAliases = {
    grep = "grep --color";
    emc = "emacsclient -nc";
    xcp = "xclip -selection clipboard";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      set -gx GPG_TTY (tty)
      function nv
        neovide $argv &; disown
      end
      function ok
        okular $argv &>/dev/null &; disown
      end
    '';
  };

  programs.bash = {
    enable = true;
  };
}
