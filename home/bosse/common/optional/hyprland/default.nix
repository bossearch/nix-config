{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./conf
    ./scripts
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    cliphist
    hypridle
    hyprpaper
    hyprpicker
    hyprsunset
    localsend
    wev
    wl-clipboard
    zenity
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      monitor =
        map (
          m: "${m.name},${toString m.width}x${toString m.height}@${toString m.refreshRate},0x0,1"
        )
        config.monitors;
    };
  };
}
