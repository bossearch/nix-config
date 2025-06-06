{
  home.file.".config/dunst/dunstsound.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      VOLUME_FILE="$HOME/.cache/bosse/volume"
      CURRENT_VOLUME=$(cat "$VOLUME_FILE")

      if [ "$DUNST_URGENCY" = "CRITICAL" ]; then
        paplay ~/.config/dunst/sound/Sonar.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "screenrecord" ]; then
        sleep 2 && paplay ~/.config/dunst/sound/clapper-board.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "screenshot" ]; then
        paplay ~/.config/dunst/sound/camera-shutter.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "nchat" ]; then
        paplay ~/.config/dunst/sound/Livechat.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "game_on" ]; then
        paplay ~/.config/dunst/sound/Mario-power-up.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "game_off" ]; then
        paplay ~/.config/dunst/sound/Mario-power-down.mp3 --volume=$CURRENT_VOLUME
      elif [ "$DUNST_APP_NAME" = "playerctl" ]; then
        paplay ~/.config/dunst/sound/Hello.mp3 --volume=$CURRENT_VOLUME
      else
        paplay ~/.config/dunst/sound/Chord.mp3 --volume=$CURRENT_VOLUME
      fi
    '';
  };
}
