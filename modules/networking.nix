{ pkgs, ... }:
{
  networking = {
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
    };
  };
}
