{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # See https://www.reddit.com/r/NixOS/comments/wyu3rj/how_to_get_pactl_in_pipewire/
    # https://unix.stackexchange.com/questions/36937/volume-on-linux-much-lower-than-on-windows
    alsa-utils
    pulseaudio
    pulsemixer
  ];
}
