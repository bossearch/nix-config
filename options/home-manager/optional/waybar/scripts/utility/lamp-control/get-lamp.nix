{
  homes,
  lib,
  pkgs,
  ...
}: let
  layer =
    if homes.notify == "swaync"
    then
      pkgs.writeShellScript "swaync-layer" ''
        while hyprctl layers | grep -q "namespace: swaync-control-center"; do
            sleep 0.1
        done
      ''
    else "";
in {
  home.file.".config/waybar/scripts/utility/lamp-control/get-lamp.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ARGS="$1"
      LAMP_IP="192.168.18.14"
      PORT=38899
      ADDRESS="$LAMP_IP:$PORT"

      get_lamp() {
        local t="$1"
        GET_LAMP=$(echo -n '{"method":"getPilot"}' | socat -t"$t" - "UDP:$ADDRESS,so-reuseaddr" 2>/dev/null || echo "{}")
        LAMP_DATA=$(jq -r '.result | select(. != null) | "\(.state),\(.sceneId),\(.temp),\(.dimming)"' <<<"$GET_LAMP" 2>/dev/null || echo "")
      }

      for i in {1..4}; do
        TIMEOUT="0.$i"
        get_lamp "$TIMEOUT"
        if [[ -n "$LAMP_DATA" ]]; then
          echo "Attempt with ''${TIMEOUT}s success." >&2
          break
        fi
        echo "Attempt with ''${TIMEOUT}s failed. Retrying..." >&2
      done

      if [[ -z "$LAMP_DATA" ]]; then
        ${layer}
        notify-send -e -u critical "Lamp control" "Error: Could not retrieve your lamp data" -i redshift-status-off
        exit 1
      fi

      IFS=',' read -r STATE SCENE TEMP DIM <<<"$LAMP_DATA"

      if [[ $STATE == "false" ]]; then
        DIM=0
      fi

      if [[ $ARGS == "full" ]]; then
        echo "$STATE|$SCENE|$TEMP|$DIM|$ADDRESS"
      elif [[ $ARGS == "dim" ]]; then
        echo '{"percentage":'"$DIM"'}'
      else
        echo "$DIM"
      fi
    '';
  };
}
