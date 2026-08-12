{
  config,
  homes,
  hosts,
  ...
}: let
  enabled = hosts.gui.enable;
in {
  services.hyprpaper = {
    enable = enabled;
    settings = {
      ipc = true;
      splash = false;
      preload = "${config.home.homeDirectory}/.cache/${hosts.username}/hyprpaper.png";
      wallpaper =
        map (m: {
          monitor = m.name;
          path = "${config.home.homeDirectory}/.cache/${hosts.username}/hyprpaper.png";
          fit_mode = "cover";
        })
        homes.monitor;
    };
  };
}
