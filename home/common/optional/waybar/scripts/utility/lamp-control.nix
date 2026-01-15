{config, ...}: {
  home.file.".config/waybar/scripts/utility/lamp-control.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      RECEIVE_PIPE="$HOME/.cache/${config.spec.userName}/lamp-control"
      LAMP_IP="192.168.18.14"
      PORT=38899

      send_command() {
        local payload="$1"
        local timeout="$2"
        echo -n "$payload" | socat -t"$timeout" - "UDP:$LAMP_IP:$PORT,so-reuseaddr" 2>/dev/null
      }

      lamp_status() {
        local lamp_status
        if lamp_status=$(send_command '{"method":"getPilot"}' 0.1); then
          read -r state dim temp <<<"$(jq -r '.result | "\(.state) \(.dimming) \(.temp)"' <<<"$lamp_status")"
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

      rm -rf "$RECEIVE_PIPE"
      mkfifo "$RECEIVE_PIPE"

      lamp_status

      while true; do
        read -r COMMAND <"$RECEIVE_PIPE"
        case "$COMMAND" in
        +)
          ((dim = (dim + 10) > 100 ? 100 : dim + 10))
          payload="{\"method\":\"setPilot\",\"params\":{\"dimming\":$dim}}"
          ;;
        -)
          ((dim = (dim - 10) < 10 ? 10 : dim - 10))
          payload="{\"method\":\"setPilot\",\"params\":{\"dimming\":$dim}}"
          ;;
        toggle)
          temp=$([[ "$temp" -eq 4200 ]] && echo 2700 || echo 4200)
          payload="{\"method\":\"setPilot\",\"params\":{\"temp\":$temp}}"
          ;;
        on)
          payload='{"method":"setState","params":{"state":true}}'
          ;;
        off)
          payload='{"method":"setState","params":{"state":false}}'
          ;;
        *) continue ;;
        esac

        send_command "$payload" "0"
        lamp_status
      done
    '';
  };
}
