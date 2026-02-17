{
  hosts,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf hosts.pipewire {
    environment.systemPackages = with pkgs; [
      playerctl
      pulseaudio
      alsa-utils
    ];
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
  };
}
