{
  config,
  homes,
  lib,
  ...
}: let
  background = "#${config.colorScheme.palette.base00}33";
  border = "#${config.colorScheme.palette.base05}ff";
in {
  home.file.".config/waybar/scripts/utility/ocr.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      die() {
        notify-send -e -u critical "OCR" "$1" -i scanner -t 1000
        exit 1
      }
      cleanup() {
        [[ -n $1 ]] && rm -r "$1"
      }

      GEOMETRY=$(slurp -d -F "${homes.nerdfont}" -b "${background}" -c "${border}")
      SCR_IMG=$(mktemp -d) || die "failed to create tmpdir"

      # shellcheck disable=SC2064
      trap "cleanup '$SCR_IMG'" EXIT

      # Use grim and slurp to capture a selected region
      grim -g "$GEOMETRY" "$SCR_IMG/scr.png" || die "Area selection cancelled"
      mogrify -modulate 100,0 -resize 400% "$SCR_IMG/scr.png" || die "Failed to convert image"
      tesseract "$SCR_IMG/scr.png" "$SCR_IMG/scr" &>/dev/null || die "Failed to extract text"
      wl-copy <"$SCR_IMG/scr.txt" || die "Failed to copy text to clipboard"
      notify-send -e "OCR" "Text extracted to clipboard" -i scanner
      exit
    '';
  };
}
