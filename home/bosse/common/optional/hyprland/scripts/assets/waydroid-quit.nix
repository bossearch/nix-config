{...}: {
  home.file.".config/hypr/scripts/assets/waydroid-quit.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e
      waydroid session stop
      systemctl stop waydroid-container
      nmcli connection up Wired\ connection\ 1
    '';
  };
}
