{
  # Use `systemctl restart display-manager.service` after system switch to take effect of new config
  # See log at /var/log/X.0.log
  services.xserver = {
    enable = true;
    dpi = 150;
    displayManager.lightdm.enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hsPkgs: with hsPkgs; [ PyF ];
    };
    # View current xorg configuration at /etc/X11/xorg.conf
    exportConfiguration = true;
  };
}
