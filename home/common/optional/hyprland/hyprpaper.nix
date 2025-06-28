{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = "/home/${config.spec.userName}/.cache/bosse/hyprpaper.png";
      wallpaper =
        map (
          m: "${m.name}, /home/${config.spec.userName}/.cache/bosse/hyprpaper.png"
        )
        config.monitors;
    };
  };
}
