{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/lamp-control/get-lamp.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ARGS="$1"
      ADDRESS="192.168.18.14:38899"

      get_lamp() {
        local t="$1"
        GET_LAMP=$(echo -n '{"method":"getPilot"}' | socat -t"$t" - "UDP:$ADDRESS,so-reuseaddr" 2>/dev/null || echo "{}")
        LAMP_DATA=$(jq -r '.result | select(. != null) | "\(.state),\(.sceneId),\(.temp),\(.dimming)"' <<<"$GET_LAMP" 2>/dev/null || echo "")
      }

      for i in {1..10}; do
        TIMEOUT="0.$i"
        get_lamp "$TIMEOUT"
        if [[ -n "$LAMP_DATA" ]]; then
          echo "Attempt with ''${TIMEOUT}s success." >&2
          break
        fi
        echo "Attempt with ''${TIMEOUT}s failed. Retrying..." >&2
      done

      if [[ -z "$LAMP_DATA" ]]; then
        exit 1
      fi

      IFS=',' read -r STATE SCENE TEMP DIM <<<"$LAMP_DATA"

      if [[ $STATE == "false" ]]; then
        DIM=0
      fi

      if [[ $ARGS == "full" ]]; then
        echo "$STATE|$SCENE|$TEMP|$DIM"
      elif [[ $ARGS == "dim" ]]; then
        echo '{"percentage":'"$DIM"'}'
      else
        echo "$DIM"
      fi
    '';
  };
}
