{config, ...}: {
  home.file.".config/hypr/scripts/playerctl/player-skip.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      playerctl -p "$(cat ~/.cache/${config.spec.userName}/player)" "$@"
    '';
  };
}
