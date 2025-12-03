{config, ...}: {
  home.file.".config/hypr/scripts/startup-value.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      mkdir -p "$HOME/.cache/${config.spec.userName}"

      DUNST_VOLUME_FILE="$HOME/.cache/${config.spec.userName}/volume"
      echo "65536" >"$DUNST_VOLUME_FILE"

      DUNST_ICON_FILE="$HOME/.cache/${config.spec.userName}/notification-icon"
      echo "󰂞" >"$DUNST_ICON_FILE"

      HYPRSUNSET_ICON_FILE="$HOME/.cache/${config.spec.userName}/hyprsunset-icon"
      echo "  " >"$HYPRSUNSET_ICON_FILE"
      HYPRSUNSET_TEMP_FILE="$HOME/.cache/${config.spec.userName}/temperature"
      HYPRSUNSET_TEMP_SCROLL="$HOME/.cache/${config.spec.userName}/temp-scroll"
      echo "6500" | tee "$HYPRSUNSET_TEMP_FILE" "$HYPRSUNSET_TEMP_SCROLL"

      GAMEMODE_FILE="$HOME/.cache/${config.spec.userName}/gamemode"
      rm -f "$GAMEMODE_FILE"

      SCREENRECORD_TOOLTIP="$HOME/.cache/${config.spec.userName}/screenrecord-tooltip"
      touch "$SCREENRECORD_TOOLTIP"

      PLAYERCTL_FILE="$HOME/.cache/${config.spec.userName}/player"
      echo "spotify" >"$PLAYERCTL_FILE"

      SWAP_SPECIAL_FILE="$HOME/.cache/bosse/swap-special"
      SWAP_NORMAL_FILE="$HOME/.cache/bosse/swap-normal"
      rm -f "$SWAP_SPECIAL_FILE" "$SWAP_NORMAL_FILE"

      CPUTEMP_FILE="$HOME/.cache/${config.spec.userName}/cputemp"
      GPUTEMP_FILE="$HOME/.cache/${config.spec.userName}/gputemp"
      rm -f "$CPUTEMP_FILE" "$GPUTEMP_FILE"

      rm -f /tmp/nvim-startup.log
      nvim --headless +q --startuptime /tmp/nvim-startup.log
    '';
  };
}
