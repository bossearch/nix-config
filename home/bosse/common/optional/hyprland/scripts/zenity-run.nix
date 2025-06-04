{config, ...}: let
  mymonitor = builtins.all (m: m.height == 1440) config.monitors;
  size = {
    width =
      if mymonitor
      then "480"
      else "360";
    height =
      if mymonitor
      then "385"
      else "324";
  };
in {
  home.file.".config/hypr/scripts/zenity-run.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Show a dialog to choose an application
      choice=$(zenity --list --title="App Selector" \
        --column="App" "Steam" "PrismLauncher" "Waydroid" "VirtManager"\
        --width=${size.width} --height=${size.height})

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
