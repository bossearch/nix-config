{
  homes,
  hosts,
  lib,
  ...
}: {
  home.file.".config/dunst/dunstsound.sh" = lib.mkIf homes.dunst {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      VOLUME_FILE="$HOME/.cache/${hosts.username}/volume"
      CURRENT_VOLUME=$(cat "$VOLUME_FILE")

      if [ "$DUNST_URGENCY" = "CRITICAL" ]; then
        paplay ~/.config/assets/sounds/Sonar.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "screenrecord" ]; then
        sleep 2 && paplay ~/.config/assets/sounds/clapper-board.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "screenshot" ]; then
        paplay ~/.config/assets/sounds/camera-shutter.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "nchat" ]; then
        paplay ~/.config/assets/sounds/Livechat.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "game_on" ]; then
        paplay ~/.config/assets/sounds/Mario-power-up.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "game_off" ]; then
        paplay ~/.config/assets/sounds/Mario-power-down.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "playerctl" ]; then
        paplay ~/.config/assets/sounds/Hello.mp3 --volume=$CURRENT_VOLUME
      else
        paplay ~/.config/assets/sounds/Chord.mp3 --volume=$CURRENT_VOLUME
      fi
    '';
  };
}
