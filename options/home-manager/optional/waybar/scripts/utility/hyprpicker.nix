{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/hyprpicker.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      SELECTED=$(printf "hex\nrgb\nhsl\nhsv\ncmyk" | fzf --layout=default --border=none)

      if [[ -z "$SELECTED" ]]; then
        exit 0
      fi

      case "$SELECTED" in
      hex)
        HYPRPICKER_ARGS=("-a" "-q" "-l" "-f" "hex" "-o" "#{0}{1}{2}")
        ;;
      rgb)
        HYPRPICKER_ARGS=("-a" "-q" "-f" "rgb" "-o" "rgb({0}, {1}, {2})")
        ;;
      hsl)
        HYPRPICKER_ARGS=("-a" "-q" "-f" "hsl" "-o" "hsl({0}, {1}%, {2}%)")
        ;;
      hsv)
        HYPRPICKER_ARGS=("-a" "-q" "-f" "hsv" "-o" "hsv({0}, {1}%, {2}%)")
        ;;
      cmyk)
        HYPRPICKER_ARGS=("-a" "-q" "-f" "cmyk" "-o" "cmyk({0}%, {1}%, {2}%, {3}%)")
        ;;
      esac

      systemd-run --user --no-block bash -c '
        while hyprctl clients | grep -q "smallfzf"; do
          sleep 0.05
        done

        hyprctl eval "require(\"lib.util\").toggle_opacity(\"enable\")"

        while ! hyprctl getoption decoration:active_opacity 2>/dev/null | grep -q "float: 1.000000"; do
          sleep 0.01
        done

        hyprpicker "$@"

        hyprctl eval "require(\"lib.util\").toggle_opacity(\"disable\")"
      ' _ "''${HYPRPICKER_ARGS[@]}" >/dev/null 2>&1

      exit 0
    '';
  };
}
