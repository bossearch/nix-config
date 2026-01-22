{
  config,
  pkgs,
  ...
}: let
  mymonitor = builtins.all (m: m.height == 1440) config.monitors;
  cursor =
    if mymonitor
    then 24
    else 22;
in {
  imports = [
    ./conf
    ./scripts
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    cliphist
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
    systemd.enable = false;
    settings = {
      monitor =
        map (
          m: "${m.name},${toString m.width}x${toString m.height}@${toString m.refreshRate},0x0,1"
        )
        config.monitors;
    };
  };

  home.pointerCursor.hyprcursor = {
    enable = true;
    size = cursor;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config.hyprland = {
      default = ["wlr" "gtk"];
    };
  };

  services.hyprsunset.enable = true;
}
