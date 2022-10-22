{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    notsodeep-overlay.url = "github:damhiya/notsodeep-overlay";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-wayland, emacs-overlay
    , notsodeep-overlay }:
    let
      baseModule = {
        imports = [ home-manager.nixosModules.home-manager ];
        system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
        nix.registry.nixos.flake = nixpkgs;
        nixpkgs.overlays = [
          nixpkgs-wayland.overlays.default
          emacs-overlay.overlays.default
          notsodeep-overlay.overlays.default
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

    };
}
