{ pkgs, ... }:
{
  # See following references:
  # - man 4 libinput
  # - https://unix.stackexchange.com/questions/58117/determine-xinput-device-manufacturer-and-model

  # General input config
  services.libinput = {
    enable = true;
    # default accel speed 0.0 is usually too slow flow flat profile
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
  services.xserver = {
    # inputClassSections has no effect due to low priority
    extraConfig = ''
      Section "InputClass"
        Identifier   "Trackpoint"
        MatchProduct "TPPS/2 Elan TrackPoint"
        Driver       "libinput"
        Option       "AccelProfile" "adaptive"
        Option       "AccelSpeed" "-0.5"
        Option       "ScrollMethod" "button"
        Option       "ScrollButton" "2"
        Option       "ScrollPixelDistance" "30"
      EndSection

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

    # auto repeat (mili seconds)
    autoRepeatDelay = 165;
    autoRepeatInterval = 50;

  };

  environment.systemPackages = with pkgs; [
    libinput
  ];
}
