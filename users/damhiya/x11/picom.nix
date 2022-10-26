{ ... }: {
  services.picom = {
    enable = true;
    experimentalBackends = true;
    backend = "glx";
    fade = false;
    settings = {
      active-opacity = 1.0;
      inactive-opacity = 1.0;
      frame-opacity = 0.3;
      corner-radius = 0;
      blur = {
        method = "dual_kawase";
        strength = 10;
      };
      blur-background-exclude = [ "class_g = 'firefox'" ];
    };
  };
}
