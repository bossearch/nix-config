{config, ...}: {
  home.file.".config/waybar/scripts/utility/lamp-control.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      RECEIVE_PIPE="$HOME/.cache/${config.spec.userName}/lamp-control"
      LAMP_IP="192.168.18.14"
      PORT=38899
      export GTK_ICON_THEME=Papirus-Dark

      send_command() {
        local payload="$1"
        local timeout="$2"
        echo -n "$payload" | socat -t"$timeout" - "UDP:$LAMP_IP:$PORT,so-reuseaddr" 2>/dev/null
      }

      lamp_status() {
        local lamp_status
        if lamp_status=$(send_command '{"method":"getPilot"}' 0.1); then
          read -r state scene temp dim <<<"$(jq -r '.result | "\(.state) \(.sceneId) \(.temp) \(.dimming)"' <<<"$lamp_status")"
          if [[ $state == "true" ]]; then
            dim=$((dim))
          elif [[ -z $state ]]; then
            while [[ -z $state ]]; do
              lamp_status=$(send_command '{"method":"getPilot"}' 0.1)
              read -r state <<<"$(jq -r '.result | "\(.state)"' <<<"$lamp_status")"
              if [[ $state == "true" ]]; then
                read -r dim <<<"$(jq -r '.result | "\(.dimming)"' <<<"$lamp_status")"
              fi
              sleep 0.1
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

      lamp_status

      rm -f "$RECEIVE_PIPE"
      mkfifo "$RECEIVE_PIPE"

      while true; do
        read -r COMMAND <"$RECEIVE_PIPE"

        case "$COMMAND" in
        +)
          ((dim = (dim + 10) > 100 ? 100 : dim + 10))
          payload="{\"method\":\"setPilot\",\"params\":{\"dimming\":$dim}}"
          ;;
        -)
          if [[ $dim -gt "10" ]]; then
            new_dimming=$((dim - 10))
            payload="{\"method\":\"setPilot\",\"params\":{\"dimming\":$new_dimming}}"
          else
            if [[ $scene != 6 ]]; then
              if ! hyprctl clients -j | jq -e '.[] | select(.class=="zenity" and .title=="Lamp Control")' >/dev/null; then
                if zenity --question \
                  --title="Lamp Control" \
                  --text="Enable Low Power Mode?" \
                  --icon=redshift-status-off \
                  --width=200; then
                  send_command '{"method":"setPilot","params":{"sceneId":6}}' "0"
                fi
              fi
              sleep 1
            fi
          fi
          ;;
        toggle)
          temp_alt=$([[ "$temp" -eq 4200 ]] && echo 2700 || echo 4200)
          payload="{\"method\":\"setPilot\",\"params\":{\"temp\":$temp_alt}}"
          ;;
        on)
          payload='{"method":"setState","params":{"state":true}}'
          ;;
        off)
          payload='{"method":"setState","params":{"state":false}}'
          ;;
        *)
          continue
          ;;
        esac
        if [[ $scene == 6 ]]; then
          temp_alt2=$([[ "$temp" -eq 4200 ]] && echo 4200 || echo 2700)
          if [[ $COMMAND == "on" || $COMMAND == "off" ]]; then
            send_command "{\"method\":\"setPilot\",\"params\":{\"temp\":$temp_alt2}}" "0"
            send_command "$payload" "0"
          elif [[ $COMMAND == "toggle" ]]; then
            send_command "$payload" "0"
          elif [[ $COMMAND == "+" ]]; then
            send_command "{\"method\":\"setPilot\",\"params\":{\"temp\":$temp_alt2}}" "0"
          elif [[ $COMMAND == "-" ]]; then
            :
          fi
        else
          send_command "$payload" "0"
        fi

        lamp_status
      done
    '';
  };
}
