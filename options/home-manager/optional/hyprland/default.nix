{
  homes,
  hosts,
  lib,
  mylib,
  pkgs,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  imports = mylib.autoimport ./.;

  wayland.windowManager.hyprland = {
    enable = enabled;
    systemd.enable = false;
    settings = {
      monitor =
        map (
          m: let
            bitdepth =
              if m.hdr
              then "10"
              else "8";
          in "${m.name}, ${toString m.width}x${toString m.height}@${toString m.refreshRate}, 0x0, 1, bitdepth, ${bitdepth}"
        )
        homes.monitor;
    };
  };

  home.packages = lib.mkIf enabled (with pkgs; [
    cliphist
    hyprpicker
    hyprshutdown
    hyprsunset
    hyprtoolkit
    localsend
    wev
    wl-clipboard
    zenity
  ]);

  xdg.portal = {
    enable = enabled;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.hyprland = {
      default = ["hyprland" "gtk"];
    };
  };

  services = {
    hyprsunset.enable = enabled;
    hyprpolkitagent.enable = enabled;
  };
}
