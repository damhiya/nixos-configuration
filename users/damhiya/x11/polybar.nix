{ ... }:
{
  services.polybar = {
    enable = true;
    settings = {
      "bar/bottom" = {
        bottom = true;
        wm-restack = "generic"; # https://github.com/polybar/polybar/issues/2205
        width = "100%:-6";
        height = "40";
        offset-x = "3";
        offset-y = "3";
        background = "#00000000";
        foreground = "#F5F5F5";
        # border-size
        # border-color
        padding = 1;
        module-margin = 1;
        font = [ "Iosevka Nerd Font:pixelsize=16;4" ];
        # modules-left
        # modules-center
        modules-right = "network battery date";
        tray-position = "left";
        tray-background = "#F5F5F5";
      };
      "module/date" = {
        type = "internal/date";
        date = "%F %a";
        time = "%l:%M:%S %p %Z";
        label = "%date% %time%";
      };
      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "AC";
        format-full = "<label-full>";
        format-charging = "<animation-charging>  <label-charging>";
        format-discharging = "<ramp-capacity>  <label-discharging>";
        label-full = "  Full %consumption%W";
        label-charging = "%percentage%% %consumption%W";
        label-discharging = "%percentage%% %consumption%W";
        animation-charging = [
          ""
          ""
          ""
          ""
          ""
        ]; # nf-fa-battery
        animation-charging-framerate = 750;
        ramp-capacity = [
          ""
          ""
          ""
          ""
          ""
        ];
      };
      "module/network" = {
        type = "internal/network";
        interface = "wlp0s20f3";
        format-connected = "<label-connected>";
        format-disconnected = "<label-disconnected>";
        label-connected = "󰖩  %essid% 󰁞 %upspeed% 󰁆 %downspeed%"; # nf-md-wifi, nf-md-arrow_up_thick, nf-md-arrow_down_thick
        label-disconnected = "󰖪  Offline"; # nf-md-wifi_off
      };
    };
    script = ''
      polybar bottom &
    '';
  };
}
