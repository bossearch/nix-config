{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/word-lookup.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Get the word from Wayland clipboard
      word=$(wl-paste -p)

      # Check if clipboard is empty
      if [ -z "$word" ]; then
        notify-send -a "word-lookup" "Error" "Clipboard is empty!"
        exit 1
      fi

      # Fetch definition
      res=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en_US/$word")

      # Check if API call was successful
      if [ -z "$res" ] || echo "$res" | grep -q '"title":"No Definitions Found"'; then
        notify-send -a "word-lookup" "Error" "No definitions found for '$word'." -u critical
        exit 1
      fi

      # Extract and format definitions (handling quotes)
      regex=$'"definition":"(.*?)(?<!\\\\)"'
      definitions=$(echo "$res" | grep -Po "$regex" | sed 's/.*"definition":"//g' | sed 's/\\"/"/g' | sed 's/"$//g')

      if [ -z "$definitions" ]; then
        notify-send -a "word-lookup" "Error" "Could not parse definition." -u critical
        exit 1
      fi

      # Prepare the body with newlines for dunst notification
      formattedNotification=$(echo "$definitions" | tr '\n' '\n\n')

      # If the definition is too long for a notification, save it to a file
      if [ ''\${#formattedNotification} -gt 300 ]; then
        filepath="$HOME/Documents/Lookups/$word.txt"
        echo "$formattedNotification" >"$filepath"
        notify-send -a "word-lookup" "$word" "Definition saved to $filepath"
      else
        # Notify user with the formatted definition
        notify-send -a "word-lookup" "$word" "$formattedNotification" -t 10000
      fi
    '';
  };
}
