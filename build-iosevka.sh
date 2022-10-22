#!/bin/sh
nix build .#iosevka
nix build .#iosevka-slab
nix build .#iosevka-fixed
nix build .#iosevka-fixed-slab
nix build .#iosevka-aile
nix build .#iosevka-etoile
