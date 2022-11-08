{ pkgs, ... }: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  hardware.bluetooth.settings = { General = { ControllerMode = "bredr"; }; };
}
