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
    systemd.enable = true;
    configType = "lua";
    settings = {
      monitor =
        map (m: let
          vrr =
            if m.vrr
            then 1
            else 0;
        in {
          output = "${m.name}";
          mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
          position = "0x0";
          scale = 1;
          vrr = vrr;
        })
        homes.monitor;
    };
  };

  home = lib.mkIf enabled {
    packages = with pkgs; [
      cliphist
      hyprpicker
      hyprshutdown
      hyprsunset
      hyprtoolkit
      localsend
      wev
      wl-clipboard
      zenity
    ];
    file.".config/hypr/.stylua.toml" = {
      text = ''
        indent_type = "Spaces"
        indent_width = 4
      '';
    };
  };

  xdg.portal = {
    enable = enabled;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = ["gtk"];
      hyprland = {
        default = ["hyprland" "gtk"];
        "org.freedesktop.impl.portal.Screencast" = ["hyprland"];
        "org.freedesktop.impl.portal.Screenshot" = ["hyprland"];
      };
    };
  };

  services = {
    hyprsunset.enable = enabled;
    hyprpolkitagent.enable = enabled;
  };
}
