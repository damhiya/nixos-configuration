#!/bin/sh
nix flake lock \
  --update-input nixpkgs \
  --update-input home-manager \
  --update-input nixpkgs-wayland \
  --update-input emacs-overlay \
  --update-input kmonad
