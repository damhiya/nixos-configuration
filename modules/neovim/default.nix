{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      packages.all = with pkgs.vimPlugins; {
        start = [
          lightline-vim
          nerdtree
          vim-surround
          haskell-vim
          vim-nix
          julia-vim
          agda-vim
          dhall-vim
          Coqtail
          gruvbox
        ];
        opt = [ bufexplorer ];
      };
      customRC = builtins.readFile ./init.vim;
    };
  };
}
