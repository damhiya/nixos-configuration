# damhiya's NixOS system configuration

## Some subtleties
* It is recommended to add some substituters. See `mixins/nix.nix`.
* The build process may fail due to memory shortage. This is because nix tries to build
  multiple iosevka packages in parallel. Run `build-iosevka.sh` to build these packages
  sequentially.

## Installation
```sh
sudo nixos-install --root /mnt --flake github:damhiya/nixos-configuration#mollusca
```

## Update
```sh
sudo nixos-rebuild switch --flake .#mollusca
```
