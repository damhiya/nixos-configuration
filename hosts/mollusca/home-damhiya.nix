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

        "XF86MonBrightnessUp" = "exec light -A 10";
        "XF86MonBrightnessDown" = "exec light -U 10";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +3%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -3%";
      };

      startup = [
        { command = "kime"; }
        { command = "swaybg -m fill -i ~/Pictures/background.png"; }
      ];

      input = {
        "1267:12813:ELAN0686:00_04F3:320D_Touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          accel_profile = "flat";
          pointer_accel = "0.5";
        };
      };

      output = {
        eDP-1 = { scale = "1.4"; pos = "0 0"; };
        # DP-2 = { scale = "1.4"; pos = "1830 0"; };
      };
    };
  };

  home.file.kime-config.target = ".config/kime/config.yaml";
  home.file.kime-config.text = ''
    ---
    daemon:
      modules:
        - Xim
        - Wayland
        - Indicator
    indicator:
      icon_color: Black
    engine:
      default_category: Latin
      global_category_state: false
      global_hotkeys:
        M-Backslash:
          behavior:
            Mode: Math
          result: ConsumeIfProcessed
        M-Space:
          behavior:
            Toggle:
              - Hangul
              - Latin
          result: Consume
        M-C-E:
          behavior:
            Mode: Emoji
          result: ConsumeIfProcessed
        Esc:
          behavior:
            Switch: Latin
          result: Bypass
        Muhenkan:
          behavior:
            Toggle:
              - Hangul
              - Latin
          result: Consume
        Hangul:
          behavior:
            Toggle:
              - Hangul
              - Latin
          result: Consume
      category_hotkeys:
        Hangul:
          ControlR:
            behavior:
              Mode: Hanja
            result: Consume
          HangulHanja:
            behavior:
              Mode: Hanja
            result: Consume
          F9:
            behavior:
              Mode: Hanja
            result: ConsumeIfProcessed
      mode_hotkeys:
        Math:
          Enter:
            behavior: Commit
            result: ConsumeIfProcessed
          Tab:
            behavior: Commit
            result: ConsumeIfProcessed
        Hanja:
          Enter:
            behavior: Commit
            result: ConsumeIfProcessed
          Tab:
            behavior: Commit
            result: ConsumeIfProcessed
        Emoji:
          Enter:
            behavior: Commit
            result: ConsumeIfProcessed
          Tab:
            behavior: Commit
            result: ConsumeIfProcessed
      xim_preedit_font:
        - Noto Sans CJK KR
        - 30.0
      latin:
        layout: Qwerty
        preferred_direct: true
      hangul:
        layout: dubeolsik
        word_commit: false
        addons:
          all: []
          dubeolsik:
            - TreatJongseongAsChoseong
  '';

  programs.emacs.enable = true;
  programs.emacs.package = pkgs.emacsPgtkNativeComp;

  programs.git.enable = true;
  programs.git.userName = "damhiya";
  programs.git.userEmail = "damhiya@gmail.com";
  programs.git.delta.enable = true;
  programs.git.delta.options = { navigate = true; line-numbers = true; };
  programs.git.extraConfig = {
    diff = { colorMoved = "default"; };
    merge = { conflictstyle = "diff3"; };
    init = { defaultBranch = "main"; };
    credential = { helper = "store"; };
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.vscode.enable = true;
  programs.foot.enable = true;
  programs.foot.settings = {
    main = { font = "Iosevka Term:size=11"; };
    colors = {
      alpha = "1.0";
      foreground = "ffffff";
      background = "000000";

      regular0 = "7f8c98";
      regular1 = "ff8170";
      regular2 = "acf2e4";
      regular3 = "ffa14f";
      regular4 = "6bdfff";
      regular5 = "ff7ab2";
      regular6 = "dabaff";
      regular7 = "dfdfe0";

      dim0 = "414453";
      dim1 = "ff8170";
      dim2 = "78c2b3";
      dim3 = "d9c97c";
      dim4 = "4eb0cc";
      dim5 = "ff7ab2";
      dim6 = "b281eb";
      dim7 = "dfdfe0";
    };
  };
  programs.firefox.enable = true;
  programs.chromium.enable = true;
  programs.feh.enable = true;
  programs.rofi.enable = true;
  programs.fish.enable = true;
  programs.bash.enable = true;
  programs.bash.initExtra = ''
    set -o vi
  '';
  programs.bash.shellAliases = {
    grep = "grep --color";
    emc = "emacsclient -nc";
    nv = "neovide";
  };

  home.packages = (import ../../common/commonPackages.nix pkgs).userPackages;
  # home.sessionVariables = {};
  # export PATH=$PATH:$HOME/.cabal/bin

  home.username = "damhiya";
  home.homeDirectory = "/home/damhiya";
  home.stateVersion = "22.05";
}
