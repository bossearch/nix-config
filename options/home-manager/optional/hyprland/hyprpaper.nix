{
  config,
  homes,
  hosts,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  services.hyprpaper = {
    enable = enabled;
    settings = {
      ipc = true;
      splash = false;
      preload = "${config.home.homeDirectory}/.cache/${hosts.username}/hyprpaper.png";
      wallpaper =
        map (
          m: "${m.name}, ${config.home.homeDirectory}/.cache/${hosts.username}/hyprpaper.png"
        )
        homes.monitor;
    };
  };
}
