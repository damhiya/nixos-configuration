{
  description = "NixOS system configuration";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    kmonad.url = "github:kmonad/kmonad?dir=nix";
    kmonad.inputs.nixpkgs.follows = "nixpkgs";
    iosevka-custom.url = "github:damhiya/iosevka-custom";
    notsodeep-overlay.url = "github:damhiya/notsodeep-overlay";
    hhg-overlay.url = "github:damhiya/hhg-overlay";
    hhg-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-wayland, emacs-overlay
    , kmonad, iosevka-custom, notsodeep-overlay, hhg-overlay }:
    let
      baseModule = {
        imports = [
          home-manager.nixosModules.home-manager
          kmonad.nixosModules.default
        ];
        system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
        nix.registry.nixos.flake = nixpkgs;
        nixpkgs.overlays = [
          nixpkgs-wayland.overlays.default
          emacs-overlay.overlays.default
          iosevka-custom.overlays.default
          notsodeep-overlay.overlays.default
          hhg-overlay.overlays.default
          (final: prev: {
            st =
              prev.writeShellScriptBin "st" (builtins.readFile ./scripts/st.sh);
          })
        ];
      };
    in {

      nixosConfigurations.lambdaPi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ baseModule ./hosts/lambdaPi/configuration.nix ];
      };

      nixosConfigurations.mollusca = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ baseModule ./hosts/mollusca/configuration.nix ];
      };

      packages = iosevka-custom.packages;
    };
}
