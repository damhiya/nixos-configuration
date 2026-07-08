{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
  toLua = lib.generators.toLua { };

  bind = key: dispatcher: {
    _args = [
      key
      (lua dispatcher)
    ];
  };

  bindRaw = key: dispatcher: {
    _args = [
      (lua key)
      (lua dispatcher)
    ];
  };

  bindRawWith = key: dispatcher: opts: {
    _args = [
      (lua key)
      (lua dispatcher)
      opts
    ];
  };

  exec = command: "hl.dsp.exec_cmd(${toLua command})";

  onStart =
    commands:
    "function()\n"
    + lib.concatMapStrings (command: "  hl.exec_cmd(${toLua command})\n") commands
    + "end";

  screenshotPath = "~/Pictures/Screenshots/screenshot.png";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    importantPrefixes = [
      "monitor"
      "config"
      "device"
      "curve"
      "animation"
      "bind"
      "on"
    ];

    settings = {
      mainMod = {
        _var = "SUPER";
      };

      monitor = [
        {
          output = "eDP-1";
          mode = "2560x1600@165.00";
          position = "0x0";
          scale = 1.6;
        }
        {
          output = "";
          mode = "highres";
          position = "auto";
          scale = 1.6;
        }
      ];

      on = {
        _args = [
          "hyprland.start"
          (lua (onStart [
            "kime --no-daemon"
            "hyprpaper"
            "waybar"
          ]))
        ];
      };

      config = {
        xwayland = {
          force_zero_scaling = true;
        };

        input = {
          kb_layout = "us";
          repeat_rate = 20; # 50ms
          repeat_delay = 165; # 165ms
          follow_mouse = 1;
          touchpad.natural_scroll = true;
          sensitivity = 0;
        };

        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          col = {
            active_border = {
              colors = [
                "rgba(33ccffee)"
                "rgba(00ff99ee)"
              ];
              angle = 45;
            };
            inactive_border = "rgba(595959aa)";
          };
          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 10;
            passes = 3;
          };
        };

        misc = {
          force_default_wallpaper = 2;
        };

        debug = {
          disable_logs = false;
        };

        animations = {
          enabled = true;
        };

        dwindle = {
          preserve_split = true;
        };
      };

      device = [
        {
          name = "kensington-slimblade-pro-trackball(wired)-kensington-slimblade-pro-trackball(wired)";
          scroll_method = "on_button_down";
          scroll_button = 275;
          scroll_button_lock = true;
          scroll_factor = 0.6;
        }
        {
          name = "kensington-slimblade-pro(2.4ghz-receiver)-kensington-slimblade-pro-trackball(2.4ghz-receiver)";
          scroll_method = "on_button_down";
          scroll_button = 275;
          scroll_button_lock = true;
          scroll_factor = 0.6;
        }
      ];

      curve = {
        _args = [
          "myBezier"
          {
            type = "bezier";
            points = [
              [
                0.05
                0.9
              ]
              [
                0.1
                1.05
              ]
            ];
          }
        ];
      };

      animation = [
        {
          leaf = "windows";
          enabled = true;
          speed = 7;
          bezier = "myBezier";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 7;
          bezier = "default";
          style = "popin 80%";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "borderangle";
          enabled = true;
          speed = 8;
          bezier = "default";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 7;
          bezier = "default";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 6;
          bezier = "default";
        }
      ];

      bind = [
        # Brightness
        (bind "XF86MonBrightnessUp" (exec "brightnessctl -d nvidia_0 set 10+"))
        (bind "XF86MonBrightnessDown" (exec "brightnessctl -d nvidia_0 set 10-"))
        (bind "SHIFT + XF86MonBrightnessUp" (exec "brightnessctl -d tpacpi::kbd_backlight set 1+"))
        (bind "SHIFT + XF86MonBrightnessDown" (exec "brightnessctl -d tpacpi::kbd_backlight set 1-"))

        # Audio volume
        (bind "XF86AudioMute" (exec "pactl set-sink-mute @DEFAULT_SINK@ toggle"))
        (bind "XF86AudioMicMute" (exec "pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
        (bind "XF86AudioRaiseVolume" (exec "pactl set-sink-volume @DEFAULT_SINK@ +3%"))
        (bind "XF86AudioLowerVolume" (exec "pactl set-sink-volume @DEFAULT_SINK@ -3%"))

        # Screenshot
        (bind "CTRL + Print" (exec "grim -g \"$(slurp)\" - | tee ${screenshotPath} | wl-copy -t image/png"))
        (bind "SHIFT + Print" (
          exec "grim -o \"$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')\" - | tee ${screenshotPath} | wl-copy -t image/png"
        ))
        (bind "Print" (
          exec ''grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | tee ${screenshotPath} | wl-copy -t image/png''
        ))

        # Execute
        (bindRaw ''mainMod .. " + SHIFT + Return"'' (exec "foot -D \"$(hyprcwd || echo \"$HOME\")\""))
        (bindRaw ''mainMod .. " + P"'' (
          exec "fuzzel -w 80 -l 15 -f Iosevka:size=15 -b fdfde3ff -seee8d5ff"
        ))

        # Control
        (bindRaw ''mainMod .. " + SHIFT + Q"'' "hl.dsp.exit()")
        (bindRaw ''mainMod .. " + SHIFT + C"'' "hl.dsp.window.close()")

        # Focus
        (bindRaw ''mainMod .. " + H"'' ''hl.dsp.focus({ direction = "left" })'')
        (bindRaw ''mainMod .. " + J"'' ''hl.dsp.focus({ direction = "down" })'')
        (bindRaw ''mainMod .. " + K"'' ''hl.dsp.focus({ direction = "up" })'')
        (bindRaw ''mainMod .. " + L"'' ''hl.dsp.focus({ direction = "right" })'')
        (bindRaw ''mainMod .. " + TAB"'' "hl.dsp.window.cycle_next()")
        (bindRaw ''mainMod .. " + SHIFT + TAB"'' "hl.dsp.window.cycle_next({ next = false })")
        (bindRaw ''mainMod .. " + 1"'' "hl.dsp.focus({ workspace = 1 })")
        (bindRaw ''mainMod .. " + 2"'' "hl.dsp.focus({ workspace = 2 })")
        (bindRaw ''mainMod .. " + 3"'' "hl.dsp.focus({ workspace = 3 })")
        (bindRaw ''mainMod .. " + 4"'' "hl.dsp.focus({ workspace = 4 })")
        (bindRaw ''mainMod .. " + 5"'' "hl.dsp.focus({ workspace = 5 })")
        (bindRaw ''mainMod .. " + 6"'' "hl.dsp.focus({ workspace = 6 })")
        (bindRaw ''mainMod .. " + 7"'' "hl.dsp.focus({ workspace = 7 })")
        (bindRaw ''mainMod .. " + 8"'' "hl.dsp.focus({ workspace = 8 })")
        (bindRaw ''mainMod .. " + 9"'' "hl.dsp.focus({ workspace = 9 })")
        (bindRaw ''mainMod .. " + 0"'' "hl.dsp.focus({ workspace = 10 })")

        # Layout
        (bindRaw ''mainMod .. " + Return"'' "hl.dsp.window.fullscreen()")
        (bindRaw ''mainMod .. " + V"'' ''hl.dsp.window.float({ action = "toggle" })'')
        (bindRaw ''mainMod .. " + SHIFT + H"'' ''hl.dsp.window.move({ direction = "left" })'')
        (bindRaw ''mainMod .. " + SHIFT + J"'' ''hl.dsp.window.move({ direction = "down" })'')
        (bindRaw ''mainMod .. " + SHIFT + K"'' ''hl.dsp.window.move({ direction = "up" })'')
        (bindRaw ''mainMod .. " + SHIFT + L"'' ''hl.dsp.window.move({ direction = "right" })'')
        (bindRaw ''mainMod .. " + SHIFT + 1"'' "hl.dsp.window.move({ workspace = 1 })")
        (bindRaw ''mainMod .. " + SHIFT + 2"'' "hl.dsp.window.move({ workspace = 2 })")
        (bindRaw ''mainMod .. " + SHIFT + 3"'' "hl.dsp.window.move({ workspace = 3 })")
        (bindRaw ''mainMod .. " + SHIFT + 4"'' "hl.dsp.window.move({ workspace = 4 })")
        (bindRaw ''mainMod .. " + SHIFT + 5"'' "hl.dsp.window.move({ workspace = 5 })")
        (bindRaw ''mainMod .. " + SHIFT + 6"'' "hl.dsp.window.move({ workspace = 6 })")
        (bindRaw ''mainMod .. " + SHIFT + 7"'' "hl.dsp.window.move({ workspace = 7 })")
        (bindRaw ''mainMod .. " + SHIFT + 8"'' "hl.dsp.window.move({ workspace = 8 })")
        (bindRaw ''mainMod .. " + SHIFT + 9"'' "hl.dsp.window.move({ workspace = 9 })")
        (bindRaw ''mainMod .. " + SHIFT + 0"'' "hl.dsp.window.move({ workspace = 10 })")
        (bindRawWith ''mainMod .. " + mouse:272"'' "hl.dsp.window.drag()" { mouse = true; })
        (bindRawWith ''mainMod .. " + mouse:273"'' "hl.dsp.window.resize()" { mouse = true; })
      ];
    };
  };
}
