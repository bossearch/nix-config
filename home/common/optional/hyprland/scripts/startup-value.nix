{
  home.file.".config/hypr/scripts/startup-value.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      mkdir -p "$HOME/.cache/bosse"

      DUNST_VOLUME_FILE="$HOME/.cache/bosse/volume"
      echo "65536" >"$DUNST_VOLUME_FILE"

      DUNST_ICON_FILE="$HOME/.cache/bosse/notification-icon"
      echo "󰂞" >"$DUNST_ICON_FILE"

      HYPRSUNSET_ICON_FILE="$HOME/.cache/bosse/hyprsunset-icon"
      echo "  " >"$HYPRSUNSET_ICON_FILE"
      HYPRSUNSET_TEMP_FILE="$HOME/.cache/bosse/temperature"
      HYPRSUNSET_TEMP_SCROLL="$HOME/.cache/bosse/temp-scroll"
      echo "6500" | tee "$HYPRSUNSET_TEMP_FILE" "$HYPRSUNSET_TEMP_SCROLL"

      GAMEMODE_FILE="$HOME/.cache/bosse/gamemode"
      if [ -f "$GAMEMODE_FILE" ]; then
        rm "$GAMEMODE_FILE"
      fi

      SCREENRECORD_TOOLTIP="$HOME/.cache/bosse/screenrecord-tooltip"
      if [ ! -f "$SCREENRECORD_TOOLTIP" ]; then
        touch "$SCREENRECORD_TOOLTIP"
      fi

      PLAYERCTL_FILE="$HOME/.cache/bosse/player"
      echo "spotify" >"$PLAYERCTL_FILE"

      rm -f /tmp/nvim-startup.log
      nvim --headless +q --startuptime /tmp/nvim-startup.log
    '';
  };
}
