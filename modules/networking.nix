{ pkgs, ... }:
{
  networking = {
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    wireless.enable = false;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
    };
  };

  # systemd.services.SpoofDPI = {
  #   description = "SpoofDPI";
  #   serviceConfig = {
  #     ExecStart = "${pkgs.spoofdpi}/bin/spoofdpi";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };
  services.zapret = {
    enable = true;
    params = [ "--dpi-desync=disorder2" ];
  };
}
