{
  homes,
  lib,
  ...
}: let
  enabled = homes.waybar && homes.mako;
in {
  home.file.".config/waybar/scripts/notify/notify-history.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      DISPLAYED=$(makoctl list -j | jq 'length')
      HIST_COUNT=$(makoctl history -j | jq 'length')

      if ((DISPLAYED > 0)); then
        makoctl dismiss -a -h

      elif ((HIST_COUNT == 0)); then
        notify-send -e -u critical "Notification history is empty"

      else
        TO_RESTORE=$((HIST_COUNT < 5 ? HIST_COUNT : 5))

        for ((i = 0; i < TO_RESTORE; i++)); do
          makoctl restore
        done

        mapfile -t IDS < <(makoctl list -j | jq -r '.[].id')
        for ((idx = ''${#IDS[@]} - 1; idx >= 0; idx--)); do
          makoctl dismiss -n "''${IDS[idx]}"
        done

        for ((i = 0; i < TO_RESTORE; i++)); do
          makoctl restore
          sleep 0.01
        done
      fi
    '';
  };
}
