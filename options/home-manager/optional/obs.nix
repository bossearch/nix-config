{
  homes,
  pkgs,
  ...
}: {
  programs.obs-studio = {
    enable = homes.obs;
    plugins = with pkgs; [
      obs-studio-plugins.input-overlay
      obs-studio-plugins.obs-backgroundremoval
      obs-studio-plugins.obs-pipewire-audio-capture
      obs-studio-plugins.wlrobs
    ];
  };
}
