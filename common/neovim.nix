pkgs: {
  packages.all = with pkgs.vimPlugins; {
    start = [
      lightline-vim
      nerdtree
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
}
