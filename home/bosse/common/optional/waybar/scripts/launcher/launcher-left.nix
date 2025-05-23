{...}: {
  home.file.".config/waybar/scripts/launcher/launcher-left.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl dispatch movecursor 1280 720
      kitty -T fastfetch -o cursor=#1a1b26 -o cursor_trail=0  -e zsh \
        -c "fastfetch --logo-position right --logo-padding-right 0; read -k"
    '';
  };
}
