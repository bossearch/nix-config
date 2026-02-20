{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/save-buku.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      url=$(wl-paste)

      if [[ "$url" =~ ^https?:// ]]; then
        buku -a "$url"
        notify-send "$url" "Saved to Buku"
      else
        notify-send "No valid URL in clipboard"
      fi
    '';
  };
}
