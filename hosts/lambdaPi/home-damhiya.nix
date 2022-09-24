{ pkgs, ... }: {

  wayland.windowManager.sway = {
    enable = true;
    xwayland = false;
    extraOptions = [ "--unsupported-gpu" ];

    config = rec {
      gaps.inner = 30;
      window.border = 3;

      modifier = "Mod1";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      keybindings = {
        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";

        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${right}" = "move right";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";

        "${modifier}+Return" = "fullscreen toggle";
        "${modifier}+Shift+C" = "kill";
        "${modifier}+R" = "reload";

        "${modifier}+Shift+Return" = "exec foot";
        "${modifier}+P" = "exec fuzzel -w 80 -l 15 -f IosevkaTerm:size=15 -b fdf6e3ff -s eee8d5ff";

        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +3%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -3%";
      };

      startup = [
        { command = "kime"; }
        { command = "swaybg -m fill -i ~/Pictures/background.png"; }
      ];

      input = {
        "1739:31251:DLL07BE:01_06CB:7A13_Touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          accel_profile = "flat";
          pointer_accel = "0.5";
        };
      };

      output = {
        eDP-1 = { scale = "2.0"; };
        DP-1 = { scale = "1.56"; };
      };
    };
  };

  programs.emacs.enable = true;
  programs.emacs.package = pkgs.emacsPgtkNativeComp;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.vscode.enable = true;
  programs.firefox.enable = true;
  programs.chromium.enable = true;
  programs.feh.enable = true;
  programs.rofi.enable = true;
  programs.fish.enable = true;

  home.packages = (import ../../common/commonPackages.nix pkgs).userPackages;
  # home.sessionVariables = {};
  # export PATH=$PATH:$HOME/.cabal/bin
}
