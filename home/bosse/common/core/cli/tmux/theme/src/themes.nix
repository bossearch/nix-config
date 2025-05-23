{...}: {
  home.file.".config/tmux/plugins/theme/src/themes.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      TRANSPARENT_THEME="$(tmux show-option -gv @tokyo-night-tmux_transparent)"

      declare -A THEME=(
        ["background"]="#1A1B26"
        ["foreground"]="#a9b1d6"
        ["black"]="#414868"
        ["blue"]="#7aa2f7"
        ["cyan"]="#7dcfff"
        ["green"]="#73daca"
        ["magenta"]="#bb9af7"
        ["red"]="#f7768e"
        ["white"]="#c0caf5"
        ["yellow"]="#e0af68"

        ["bblack"]="#2A2F41"
        ["bblue"]="#7aa2f7"
        ["bcyan"]="#7dcfff"
        ["bgreen"]="#41a6b5"
        ["bmagenta"]="#bb9af7"
        ["bred"]="#ff9e64"
        ["bwhite"]="#787c99"
        ["byellow"]="#e0af68"
      )

      # Override background with "default" if transparent theme is enabled
      if [ "''${TRANSPARENT_THEME}" == 1 ]; then
        THEME["background"]="default"
      fi

      THEME['ghgreen']="#3fb950"
      THEME['ghmagenta']="#A371F7"
      THEME['ghred']="#d73a4a"
      THEME['ghyellow']="#d29922"
      THEME['ghsky']="#3B4261"
      THEME['ghturquoise']="#27a1b9"
      THEME['ghblack']="#16161E"

      RESET="#[fg=''${THEME[foreground]},bg=''${THEME[background]},nobold,noitalics,nounderscore,nodim]"
    '';
  };
}
