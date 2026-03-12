{
  homes,
  hosts,
  lib,
  mylib,
  pkgs,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
  hyprshutdown = pkgs.unstable.hyprshutdown;
in {
  imports = mylib.autoimport ./.;

  wayland.windowManager.hyprland = {
    enable = enabled;
    systemd.enable = false;
    settings = {
      monitor =
        map (
          m: "${m.name},${toString m.width}x${toString m.height}@${toString m.refreshRate},0x0,1"
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
