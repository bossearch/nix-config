{
  homes,
  hosts,
  lib,
  mylib,
  pkgs,
  ...
}: let
  enabled = hosts.gui.enable;
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
          mode =
            if m.modeline != null
            then m.modeline
            else "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
        in {
          output = "${m.name}";
          mode = mode;
          position = m.position;
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

  services = {
    hyprsunset.enable = enabled;
    hyprpolkitagent.enable = enabled;
  };
}
