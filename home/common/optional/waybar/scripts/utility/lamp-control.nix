{config, ...}: {
  home.file.".config/waybar/scripts/utility/lamp-control.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      RECEIVE_PIPE="$HOME/.cache/${config.spec.userName}/lamp-control"
      LAMP_IP="192.168.18.14"
      PORT=38899

      dim=0
      temp=0
      state="false"

      send_command() {
        local payload="$1"
        local timeout="''${2:-0.1}"
        echo -n "$payload" | socat -t"$timeout" - "UDP:$LAMP_IP:$PORT,so-reuseaddr" 2>/dev/null
      }

      update_local_status() {
        local raw_status
        raw_status=$(send_command '{"method":"getPilot"}' 0.5)

        if [[ -n "$raw_status" ]]; then
          read -r state dim temp <<<"$(echo "$raw_status" | jq -r '.result | "\(.state), \(.dimming), \(.temp)"')"
        fi
      }

      mkdir -p "$(dirname "$RECEIVE_PIPE")"
      [[ -p "$RECEIVE_PIPE" ]] || mkfifo "$RECEIVE_PIPE"

      update_local_status

      while true; do
        if ! read -r COMMAND <"$RECEIVE_PIPE"; then continue; fi

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
          state="true"
          payload='{"method":"setState","params":{"state":true}}'
          ;;
        off)
          state="false"
          payload='{"method":"setState","params":{"state":false}}'
          ;;
        status)
          update_local_status
          echo "{\"percentage\": $dim, \"state\": $state, \"temp\": $temp}"
          continue
          ;;
        *) continue ;;
        esac

        send_command "$payload" "0"

        #NOTE: Periodically re-sync status in the background if needed
      done
    '';
  };
}
