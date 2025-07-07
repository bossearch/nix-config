{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = "/home/${config.spec.userName}/.cache/${config.spec.userName}/hyprpaper.png";
      wallpaper =
        map (
          m: "${m.name}, /home/${config.spec.userName}/.cache/${config.spec.userName}/hyprpaper.png"
        )
        config.monitors;
    };
  };
}
