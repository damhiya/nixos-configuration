{ ... }: {
  services.polybar = {
    enable = true;
    settings = {
      "bar/bottom" = {
        width = "100%";
        height = "3%";
        bottom = true;
        modules-right = "battery date";
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%y.%m.%d";
        time = "%H:%M:%S";
        label = "%date% %time%";
      };
      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "AC";
        full-at = 100;
      };
    };
    script = ''
      polybar bottom &
    '';
  };
}
