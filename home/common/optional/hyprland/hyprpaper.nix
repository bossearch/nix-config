{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = "/tmp/hyprpaper.png";
      wallpaper =
        map (
          m: "${m.name}, /tmp/hyprpaper.png"
        )
        config.monitors;
    };
  };
}
