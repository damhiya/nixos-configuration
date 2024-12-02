{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainbar = {
      layer = "top";
      position = "top";
      height = 30;
      spacing = 4;
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "tray" ];
      modules-right = [
        "wireplumber"
        "network"
        "battery"
        "clock"
      ];
      tray = {
        icon-size = 21;
        spacing = 6;
      };
      clock = {
        interval = 1;
        format = "{:%F %a  %I:%M:%S %p %Z}";
      };
      battery = {
        format = "{icon}  {capacity}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ]; # nf-fa-battery
      };
      network = {
        inteval = 5;
        interface = "wlp0s20f3";
        format-wifi = "󰖩  {essid} 󰁞 {bandwidthUpBytes} 󰁆 {bandwidthDownBytes}"; # nf-md-wifi, nf-md-arrow_up_thick, nf-md-arrow_down_thick
        format-disconnected = "󰖪  Offline"; # nf-md-wifi_off
        tooltip = false;
      };
      wireplumber = {
        format = "{node_name}  {icon} {volume}%";
        format-muted = "{node_name}  󰖁"; # nf-md-volume_off
        on-click = "helvum";
        format-icons = [
          "󰕿"
          "󰖀"
          "󰕾"
        ]; # nf-md-volume
        tooltip = false;
      };
    };
    style = ''
      * {
        font-family: Iosevka;
      }
    '';
  };
}
