{
  services.xserver = {

    # General libinput config
    libinput = {
      enable = true;
      mouse = {
        naturalScrolling = false;
        accelProfile = "flat";
        accelSpeed = "1.0";
      };
      touchpad = {
        naturalScrolling = true;
        accelProfile = "flat";
        accelSpeed = "1.0";
      };
    };

    # Per-device input config
    # inputClassSections has no effect due to low priority
    # man 4 libinput
    extraConfig = ''
      Section "InputClass"
        Identifier   "Logitech-G302"
        MatchVendor  "Logitech"
        MatchProduct "Gaming Mouse G302"
        Driver       "libinput"
        Option       "ScrollMethod" "button"
        Option       "ScrollButton" "2"
      EndSection

      Section        "InputClass"
        Identifier   "Kensington-SlimBlade-Pro-Trackball"
        MatchVendor  "Kensington"
        MatchProduct "SlimBlade Pro Trackball"
        Driver       "libinput"
        Option       "ScrollMethod" "button"
        Option       "ScrollButton" "8"
        Option       "ScrollButtonLock" "true"
        Option       "ScrollPixelDistance" "50"
      EndSection
    '';

    # auto repeat
    autoRepeatDelay = 165;
    autoRepeatInterval = 50;
  };
}
