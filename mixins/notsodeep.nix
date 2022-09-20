{ pkgs, ... }:
{
  systemd.services.notsodeep = {
    description = "notsodeep";
    serviceConfig = { ExecStart = "${pkgs.notsodeep}/bin/notsodeep"; };
    wantedBy = [ "multi-user.target" ];
  };
}
