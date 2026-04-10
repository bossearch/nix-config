{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/lamp-control/set-lamp.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      GET_LAMP="$HOME/.config/waybar/scripts/utility/lamp-control/get-lamp.sh full"
      read -r STATE SCENE TEMP DIM ADDRESS < <($GET_LAMP)
      ARGS="$1"

      SET_LAMP() {
        echo -n "$1" | socat -t0 - "UDP:$ADDRESS,so-reuseaddr" 2>/dev/null
      }
      case "$ARGS" in
      +)
        ((DIM = (DIM + 10) > 100 ? 100 : DIM + 10))
        PAYLOAD='{"method":"setPilot","params":{"dimming":'$DIM'}}'
        ;;
      -)
        ((DIM = (DIM - 10) < 10 ? 10 : DIM - 10))
        PAYLOAD='{"method":"setPilot","params":{"dimming":'$DIM'}}'
        ;;
      temp)
        TEMP_ALT=$([[ "$TEMP" -eq 4200 ]] && echo 2700 || echo 4200)
        PAYLOAD='{"method":"setPilot","params":{"temp":'$TEMP_ALT'}}'
        ;;
      state)
        STATE_ALT=$([[ "$STATE" == "true" ]] && echo "false" || echo "true")
        PAYLOAD='{"method":"setState","params":{"state":'$STATE_ALT'}}'
        ;;
      cozy)
        PAYLOAD='{"method":"setPilot","params":{"sceneId":6}}'
        ;;
      *)
        PAYLOAD='{"method":"setPilot","params":{"dimming":'$ARGS'}}'
        ;;
      esac

      if [[ $SCENE == 6 ]]; then
        TEMP_ALT2=$([[ "$TEMP" -eq 4200 ]] && echo 4200 || echo 2700)
        EXTRA_PAYLOAD='{"method":"setPilot","params":{"temp":'$TEMP_ALT2'}}'
        if [[ $ARGS == "toggle" ]]; then
          SET_LAMP "$PAYLOAD"
        elif [[ $ARGS == "+" ]]; then
          SET_LAMP "$EXTRA_PAYLOAD"
        elif [[ $ARGS == "-" || $ARGS == "cozy" ]]; then
          :
        else
          SET_LAMP "$EXTRA_PAYLOAD"
          SET_LAMP "$PAYLOAD"
        fi
      else
        if [[ $ARGS == "cozy" ]]; then
          EXTRA_PAYLOAD='{"method":"setPilot","params":{"dimming":10}}'
          SET_LAMP "$EXTRA_PAYLOAD"
          SET_LAMP "$PAYLOAD"
        else
          SET_LAMP "$PAYLOAD"
        fi
      fi

      pkill -SIGRTMIN+15 waybar
    '';
  };
}
