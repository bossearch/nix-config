{
  home.file.".config/hypr/scripts/playerctl/player-toggle.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      playerctl -p "$(cat ~/.cache/bosse/player)" play-pause
    '';
  };
}
