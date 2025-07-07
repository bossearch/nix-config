{config, ...}: {
  home.file.".config/hypr/scripts/playerctl/player-seek.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      PLAYER=$(cat ~/.cache/${config.spec.userName}/player)
      CHANGE=$1  # e.g. +5 or -5

      current=$(playerctl --player="$PLAYER" position | cut -d '.' -f1)
      target=$(( current + CHANGE ))
      [[ $target -lt 0 ]] && target=0

      playerctl --player="$PLAYER" position "$target"
    '';
  };
}
