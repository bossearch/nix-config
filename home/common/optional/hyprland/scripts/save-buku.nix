{
  home.file.".config/hypr/scripts/save-buku.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      url=$(wl-paste)

      if [[ "$url" =~ ^https?:// ]]; then
        buku -a "$url"
        notify-send "$url" "Saved to Buku"
      else
        notify-send "No valid URL in clipboard"
      fi
    '';
  };
}
