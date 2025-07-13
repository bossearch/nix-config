{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = "${config.home.homeDirectory}/.cache/${config.spec.userName}/hyprpaper.png";
      wallpaper =
        map (
          m: "${m.name}, ${config.home.homeDirectory}/.cache/${config.spec.userName}/hyprpaper.png"
        )
        config.monitors;
    };
  };
}
