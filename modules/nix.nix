{
  nix = {
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
    settings = {
      trusted-users = [ "root" "@wheel" ];
      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://cache.iog.io"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
    };
  };
}
