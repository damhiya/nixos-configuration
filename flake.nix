{
  description = "NixOS system configuration";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    kmonad.url = "github:kmonad/kmonad?dir=nix";
    kmonad.inputs.nixpkgs.follows = "nixpkgs";
    iosevka-custom.url = "github:damhiya/iosevka-custom";
    hhg-overlay.url = "github:damhiya/hhg-overlay";
    hhg-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      kmonad,
      iosevka-custom,
      hhg-overlay,
    }:
    let
      baseModule = {
        imports = [
          home-manager.nixosModules.default
          kmonad.nixosModules.default
        ];
        system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
        nixpkgs.overlays = [
          iosevka-custom.overlays.default
          hhg-overlay.overlays.default
          (import ./scripts/overlay.nix)
        ];
      };
    in
    {

      nixosConfigurations.lambdaPi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          baseModule
          ./hosts/lambdaPi/configuration.nix
        ];
      };

      nixosConfigurations.mollusca = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          baseModule
          ./hosts/mollusca/configuration.nix
        ];
      };

      packages = iosevka-custom.packages;
    };
}
