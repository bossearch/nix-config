{config, ...}: ''
  # Output file for the app names and Exec commands
  output_file="$HOME/.cache/${config.spec.userName}/drun.txt"

  rm -f "$output_file"
  mkdir -p "$(dirname "$output_file")"
  touch "$output_file"

  # List of apps to exclude (add full .desktop filenames here)
  exclude_apps=(
    "Dota 2"
    "Stardew Valley"
    "Steam Linux Runtime 1.0 (scout)"
    "Steam Linux Runtime 2.0 (soldier)"
    "Steam Linux Runtime 3.0 (sniper)"
    "Waydroid"
    "auto-cpufreq-gtk"
    "avahi-discover"
    "bssh"
    "btop"
    "bvnc"
    "cmake-gui"
    "com.usebottles.bottles"
    "cups"
    "discord-1216669957799018608"
    "electron31"
    "electron32"
    "feh"
    "fish"
    "gcr-prompter"
    "gcr-viewer"
    "geoclue-demo-agent"
    "geoclue-where-am-i"
    "gkbd-keyboard-display"
    "google-maps-geo-handler"
    "java-java17-openjdk"
    "java-java21-openjdk"
    "kcm_kdeconnect"
    "kitty-open"
    "ktelnetservice6"
    "nautilus-autorun-software"
    "net.lutris.Lutris"
    "nixos-manual"
    "nvim"
    "openstreetmap-geo-handler"
    "org.freedesktop.Xwayland"
    "org.gnome.Evince"
    "org.gnome.Evince-previewer"
    "org.gnome.Zenity"
    "org.gnupg.pinentry-qt"
    "org.gnupg.pinentry-qt5"
    "org.kde.kdeconnect-settings"
    "org.kde.kdeconnect.app"
    "org.kde.kdeconnect.app"
    "org.kde.kdeconnect.daemon"
    "org.kde.kdeconnect.handler"
    "org.kde.kdeconnect.nonplasma"
    "org.kde.kdeconnect.sms"
    "org.kde.kiod6"
    "org.kde.kwalletd6"
    "org.kde.ksecretd"
    "org.kde.xwaylandvideobridge"
    "org.prismlauncher.PrismLauncher"
    "org.pwmt.zathura"
    "org.pwmt.zathura-cb"
    "org.pwmt.zathura-ps"
    "org.pwmt.zathura-djvu"
    "org.pwmt.zathura-pdf-mupdf"
    "polkit-gnome-authentication-agent-1"
    "qt5ct"
    "qv4l2"
    "qvidcap"
    "qwant-maps-geo-handler"
    "remote-viewer"
    "steam"
    "transmission-gtk"
    "umpv"
    "uuctl"
    "user-dirs-update-gtk"
    "userapp-transmission-gtk-*"
    "vim"
    "waydroid.app.install"
    "waydroid.com.android.calculator2"
    "waydroid.com.android.camera2"
    "waydroid.com.android.contacts"
    "waydroid.com.android.deskclock"
    "waydroid.com.android.documentsui"
    "waydroid.com.android.gallery3d"
    "waydroid.com.android.inputmethod.latin"
    "waydroid.com.android.settings"
    "waydroid.com.android.vending"
    "waydroid.com.aurora.adroid"
    "waydroid.com.aurora.services"
    "waydroid.com.aurora.store"
    "waydroid.com.google.android.gms"
    "waydroid.com.mobile.legends"
    "waydroid.com.mobilechess.gp"
    "waydroid.cu.axel.smartdock"
    "waydroid.io.github.huskydg.magisk"
    "waydroid.io.github.sds100.keymapper"
    "waydroid.io.github.sds100.keymapper.inputmethod.latin"
    "waydroid.market"
    "waydroid.org.fdroid.fdroid"
    "waydroid.org.lineageos.aperture"
    "waydroid.org.lineageos.eleven"
    "waydroid.org.lineageos.etar"
    "waydroid.org.lineageos.jelly"
    "waydroid.org.lineageos.recorder"
    "waydroid.org.mozilla.firefox"
    "wheelmap-geo-handler"
    "wine"
    "wine-extension-chm"
    "wine-extension-hlp"
    "wine-extension-msp"
    "wine-extension-vbs"
    "winetricks"
    "xdg-desktop-portal-gtk"
    "yazi"
  )

  custom_apps=(
    "Alacritty:alacritty"
    "com.mitchellh.ghostty:ghostty"
    "LocalSend:localsend"
    "io.github.mpobaschnig.Vaults:vaults"
    "io.github.giantpinkrobots.varia:varia"
    "org.cryptomator.Cryptomator:cryptomator"
    "org.gnome.Nautilus:nautilus"
    "org.gnome.baobab:baobab"
    "org.pulseaudio.pavucontrol:pavucontrol"
    "org.shotcut.Shotcut:shotcut"
    "vesktop:discord"
  )

  custom_execs=(
    "spotify:spotify"
    "alacritty:alacritty -e bash -c '~/.config/hypr/scripts/assets/tty.sh; exec zsh'"
    "kitty:kitty sh -c '~/.config/hypr/scripts/assets/tty.sh; exec fish'"
  )

  readarray -t applications < <(find \
    ~/.local/share/applications \
    ~/.nix-profile/share/applications \
    /run/current-system/sw/share/applications \
    /etc/profiles/per-user/$USER/share/applications \
    -name '*.desktop' 2>/dev/null)

  for path in "''${applications[@]}"; do
    name=$(basename "$path" .desktop)

    # Skip apps in the exclude list (using pattern matching)
    exclude=false
    for pattern in "''${exclude_apps[@]}"; do
      if [[ "$name" == $pattern ]]; then
        exclude=true
        break
      fi
    done

    if [ "$exclude" = true ]; then
      continue
    fi
    # Change the name for specific apps
    for app in "''${custom_apps[@]}"; do
      old_name=$(echo "$app" | cut -d ':' -f 1)
      new_name=$(echo "$app" | cut -d ':' -f 2)
      if [[ "$name" == "$old_name" ]]; then
        name="$new_name"
        break
      fi
    done

    # Extract the Exec command from the .desktop file
    exec_command=$(grep '^Exec=' "$path" | tail -1 | sed 's/^Exec=//' | sed 's/%.*//')

    # Change the Exec command for specific apps
    for exec in "''${custom_execs[@]}"; do
      app_name=$(echo "$exec" | cut -d ':' -f 1)
      custom_command=$(echo "$exec" | cut -d ':' -f 2)
      if [[ "$name" == "$app_name" ]]; then
        exec_command="$custom_command"
        break
      fi
    done

    # Skip entries without an Exec command
    if [ -n "$exec_command" ]; then

      if ! grep -q "^$name|" "$output_file"; then
        # Save the name and Exec command to the output file
        echo "$name|$exec_command" >>"$output_file"
      fi
    fi
  done
''
