{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/startup-value.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      mkdir -p "$HOME/.cache/${hosts.username}"

      NOTIFY_VOLUME_FILE="$HOME/.cache/${hosts.username}/notify-volume"
      echo "65536" >"NOTIFY_VOLUME_FILE"

      NOTIFY_ICON_FILE="$HOME/.cache/${hosts.username}/notify-icon"
      echo "󰂞" >"$NOTIFY_ICON_FILE"

      HYPRSUNSET_ICON_FILE="$HOME/.cache/${hosts.username}/hyprsunset-icon"
      echo "" >"$HYPRSUNSET_ICON_FILE"
      HYPRSUNSET_TEMP_FILE="$HOME/.cache/${hosts.username}/temperature"
      HYPRSUNSET_TEMP_SCROLL="$HOME/.cache/${hosts.username}/temp-scroll"
      echo "6500" | tee "$HYPRSUNSET_TEMP_FILE" "$HYPRSUNSET_TEMP_SCROLL"

      GAMEMODE_FILE="$HOME/.cache/${hosts.username}/gamemode"
      rm -f "$GAMEMODE_FILE"

      SCREENRECORD_TOOLTIP="$HOME/.cache/${hosts.username}/screenrecord-tooltip"
      touch "$SCREENRECORD_TOOLTIP"

      PLAYERCTL_FILE="$HOME/.cache/${hosts.username}/player"
      echo "spotify" >"$PLAYERCTL_FILE"

      SWAP_SPECIAL_FILE="$HOME/.cache/${hosts.username}/swap-special"
      SWAP_NORMAL_FILE="$HOME/.cache/${hosts.username}/swap-normal"
      rm -f "$SWAP_SPECIAL_FILE" "$SWAP_NORMAL_FILE"

      CPUTEMP_FILE="$HOME/.cache/${hosts.username}/cputemp"
      GPUTEMP_FILE="$HOME/.cache/${hosts.username}/gputemp"
      rm -f "$CPUTEMP_FILE" "$GPUTEMP_FILE"
    '';
  };
}
