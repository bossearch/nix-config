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
      LAMP_IP="192.168.18.14"
      PORT=38899
      ADDRESS="$LAMP_IP:$PORT"

      GET_LAMP=$(echo -n '{"method":"getPilot"}' | socat -t0.1 - "UDP:$ADDRESS,so-reuseaddr" 2>/dev/null)

      if [[ -n $GET_LAMP ]]; then
        read -r STATE SCENE TEMP DIM <<<"$(jq -r '.result | "\(.state) \(.sceneId) \(.temp) \(.dimming)"' <<<"$GET_LAMP")"
        if [[ $STATE == "true" ]]; then
          DIM=$((DIM))
        elif [[ -z $STATE ]]; then
          while [[ -z $STATE ]]; do
            GET_LAMP=$(echo -n '{"method":"getPilot"}' | socat -t0.1 - "UDP:$ADDRESS,so-reuseaddr" 2>/dev/null)
            read -r STATE <<<"$(jq -r '.result | "\(.state)"' <<<"$GET_LAMP")"
            if [[ $STATE == "true" ]]; then
              read -r DIM <<<"$(jq -r '.result | "\(.dimming)"' <<<"$GET_LAMP")"
            fi
            sleep 0.1
          done
          [[ -z $DIM ]] && DIM=0
        elif [[ $STATE == "false" ]]; then
          DIM=0
        fi
      else
        DIM=0
      fi

      if [[ $ARGS == "full" ]]; then
        echo "$STATE $SCENE $TEMP $DIM $ADDRESS"
      elif [[ $ARGS == "dim" ]]; then
        echo '{"percentage":'"$DIM"'}'
      else
        echo "$DIM"
      fi
    '';
  };
}
