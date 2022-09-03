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
    , notsodeep-overlay }: {

      nixosConfigurations.lambdaPi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            system.configurationRevision =
              nixpkgs.lib.mkIf (self ? rev) self.rev;
            nixpkgs.overlays = [
              nixpkgs-wayland.overlay
              emacs-overlay.overlay
              notsodeep-overlay.overlay
            ];
          }
          ./hosts/lambdaPi/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

    };
}
