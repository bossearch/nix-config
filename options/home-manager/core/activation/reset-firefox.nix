{
  config,
  homes,
  hosts,
  lib,
  pkgs,
  ...
}:
pkgs.writeShellScript "reset-firefox" ''
  VERTICALTAB_ENABLE="${lib.boolToString homes.firefox.verticaltab.enable}"
  VERTICALTAB_POSITION="${homes.firefox.verticaltab.position}"
  VERTICALTAB_FILE="${config.home.homeDirectory}/.cache/${hosts.username}/verticaltab"
  PREFS="${config.xdg.configHome}/mozilla/firefox/${hosts.username}/prefs.js"

  if [[ ! -f "$VERTICALTAB_FILE" ]]; then
    echo "$VERTICALTAB_ENABLE" > "$VERTICALTAB_FILE"
    echo "$VERTICALTAB_POSITION" >> "$VERTICALTAB_FILE"
  else
    VERTICALTAB_ENABLE_OLD=$(sed -n "1p" $VERTICALTAB_FILE)
    VERTICALTAB_POSITION_OLD=$(sed -n "2p" $VERTICALTAB_FILE)

    if [[ "$VERTICALTAB_ENABLE" != "$VERTICALTAB_ENABLE_OLD" ]] || [[ "$VERTICALTAB_POSITION" != "$VERTICALTAB_POSITION_OLD" ]]; then
      ${pkgs.procps}/bin/pkill firefox || true
      if [[ -f "$PREFS" ]]; then
        sed -i '/^user_pref("browser.uiCustomization\./d' "$PREFS"
        sed -i '/^user_pref("sidebar\./d' "$PREFS"
      fi
      sed -i "1c $VERTICALTAB_ENABLE" "$VERTICALTAB_FILE"
      sed -i "2c $VERTICALTAB_POSITION" "$VERTICALTAB_FILE"
    fi
  fi
''
