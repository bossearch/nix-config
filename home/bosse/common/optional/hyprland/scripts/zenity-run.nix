{...}: {
  home.file.".config/hypr/scripts/zenity-run.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Show a dialog to choose an application
      choice=$(zenity --list --title="App Selector" \
        --column="App" "Steam" "PrismLauncher" "Waydroid" "VirtManager"\
        --width=480 --height=385)

      # Check the user's choice and launch the selected app
      case $choice in
      "Steam")
        steam
        ;;
      "PrismLauncher")
        prismlauncher
        ;;
      "Waydroid")
        ~/.config/hypr/scripts/assets/waydroid-run.sh
        ;;
      "VirtManager")
        virt-manager
        ;;
      *)
        # Do nothing if no selection is made
        ;;
      esac
    '';
  };
}
