{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/xdph.conf" = lib.mkIf enabled {
    text = ''
      screencopy {
          max_fps = 60
          allow_token_by_default = true
      }
    '';
  };
}
