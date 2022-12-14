{ pkgs, ... }:
let hsPkgs = pkgs: with pkgs; [ split ieee754 vector async ];
in {
  home.packages = with pkgs; [
    (ghc.withPackages hsPkgs)
    cabal-install
    hpack
    cabal2nix
    (agda.withPackages (pkgs: with pkgs; [ standard-library cubical ]))
    haskellPackages.fix-whitespace
  ];
}
