{ pkgs, ... }: {

  networking = {
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    wireless.enable = false;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      extraCommands = ''
        iptables -A INPUT -p tcp --tcp-flags SYN,ACK SYN,ACK --sport 443 -j NFQUEUE --queue-num 200 --queue-bypass
        iptables -t raw -I PREROUTING -p tcp --sport 443 --tcp-flags SYN,ACK SYN,ACK -j NFQUEUE --queue-num 200 --queue-bypass
        iptables -t raw -I PREROUTING -p tcp --sport 80 --tcp-flags SYN,ACK SYN,ACK -j NFQUEUE --queue-num 200 --queue-bypass
      '';
    };
  };

  systemd.services.notsodeep = {
    description = "notsodeep";
    serviceConfig = { ExecStart = "${pkgs.notsodeep}/bin/notsodeep"; };
    wantedBy = [ "multi-user.target" ];
  };

}
