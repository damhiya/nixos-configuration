{ pkgs, ... }:
let hsPkgs = pkgs: with pkgs; [ split ieee754 vector async PyF ];
in {
  home.packages = with pkgs; [
    (ghc.withPackages hsPkgs)
    cabal-install
    hpack
    cabal2nix
    haskellPackages.fix-whitespace
  ];
}
