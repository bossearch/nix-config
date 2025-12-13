{config, ...}: {
  home.file.".config/waybar/scripts/utility/lamp-control.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      RECEIVE_PIPE="$HOME/.cache/${config.spec.userName}/lamp-control"

      LAMP_IP="192.168.18.14"
      PORT=38899

      lamp_control_fast() {
        socat -t0 - UDP:$LAMP_IP:$PORT,so-reuseaddr 2>/dev/null
      }
      lamp_control_slow() {
        socat -t0.1 - UDP:$LAMP_IP:$PORT,so-reuseaddr 2>/dev/null
      }

      lamp_status() {
        if lamp_status=$(echo -n '{"method":"getPilot"}' | "$@"); then
          state=$(echo "$lamp_status" | grep -o '"state":[^,}]*' | cut -d: -f2)
          dim=$(echo "$lamp_status" | grep -o '"dimming":[^,}]*' | cut -d: -f2)
          temp=$(echo "$lamp_status" | grep -o '"temp":[^,}]*' | cut -d: -f2)
          if [[ $state == "true" ]]; then
            dim=$((dim))
          elif [[ -z $state ]]; then
            while [[ -z $state ]]; do
              state=$(echo -n '{"method":"getPilot"}' | lamp_control_slow | grep -o '"state":[^,}]*' | cut -d: -f2)
              if [[ $state == "true" ]]; then
                dim=$(echo -n '{"method":"getPilot"}' | lamp_control_slow | grep -o '"dimming":[^,}]*' | cut -d: -f2)
              fi
              sleep 0.15
            done
            if [[ -z $dim ]]; then
              dim=0
            fi
          elif [[ $state == "false" ]]; then
            dim=0
          fi
        else
          dim=0
        fi
        echo '{"percentage":'"$dim"'}'
      }

      rm -rf "$RECEIVE_PIPE"
      mkfifo "$RECEIVE_PIPE"

      lamp_status lamp_control_slow

      while true; do
        read -r COMMAND <"$RECEIVE_PIPE"
        case $COMMAND in
        +)
          CURRENT_DIMMING=$(echo "$dim" | grep -o '[0-9]\+')
          NEW_DIMMING=$((CURRENT_DIMMING + 10))
          PAYLOAD="{\"method\":\"setPilot\",\"params\":{\"dimming\":$NEW_DIMMING}}"
          echo -n "$PAYLOAD" | lamp_control_fast
          ;;
        -)
          CURRENT_DIMMING=$(echo "$dim" | grep -o '[0-9]\+')
          NEW_DIMMING=$((CURRENT_DIMMING - 10))
          PAYLOAD="{\"method\":\"setPilot\",\"params\":{\"dimming\":$NEW_DIMMING}}"
          echo -n "$PAYLOAD" | lamp_control_fast
          ;;
        toggle)
          if [ "$temp" -eq 4200 ]; then
            PAYLOAD='{"id":1,"method":"setPilot","params":{"temp":2700}}'
          elif [ "$temp" -eq 2700 ]; then
            PAYLOAD='{"id":1,"method":"setPilot","params":{"temp":4200}}'
          fi
          echo -n "$PAYLOAD" | lamp_control_fast
          ;;
        on)
          PAYLOAD='{"id":1,"method":"setState","params":{"state":true}}'
          echo -n "$PAYLOAD" | lamp_control_fast
          ;;
        off)
          PAYLOAD='{"id":1,"method":"setState","params":{"state":false}}'
          echo -n "$PAYLOAD" | lamp_control_fast
          ;;
        esac
        lamp_status lamp_control_slow
      done
    '';
  };
}
