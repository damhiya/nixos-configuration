{ pkgs, ... }: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluez;
  hardware.bluetooth.settings = { General = { ControllerMode = "bredr"; }; };
  services.blueman.enable = true;
}
