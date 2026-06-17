{
  services.kmonad = {
    enable = true;
    keyboards = {
      thinkpad-internal = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };
        config = ''
          (defsrc
              esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  home end  ins  del
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '         ret
              lsft z    x    c    v    b    n    m    ,    .    /              rsft
                   lctl lmet lalt           spc            ralt sys  rctl pgdn up   pgup
                                                                          left down rght
          )
          (deflayer qwerty
              esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  home end  ins  del
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              lctl a    s    d    f    g    h    j    k    l    ;    '         ret
              lsft z    x    c    v    b    n    m    ,    .    /              rsft
                   lctl lalt lmet           spc            ralt sys  rctl pgdn up   pgup
                                                                          left down rght
          )
        '';
      };
      hhkb = {
        device = "/dev/input/by-id/usb-PFU_Limited_HHKB-Classic-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };
        config = ''
          (defsrc
              esc  1    2    3    4    5    6    7    8    9    0    -    =    \    grv
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    bspc
              lctl a    s    d    f    g    h    j    k    l    ;    '         ret
              lsft z    x    c    v    b    n    m    ,    .    /              rsft
                        lalt lmet           spc            rmet ralt
          )
          (deflayer qwerty
              esc  1    2    3    4    5    6    7    8    9    0    -    =    \    grv
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    bspc
              lctl a    s    d    f    g    h    j    k    l    ;    '         ret
              lsft z    x    c    v    b    n    m    ,    .    /              rsft
                        lalt lmet           spc            rmet ralt
          )
        '';
      };
    };
  };
}
