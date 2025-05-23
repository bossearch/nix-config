{...}: {
  home.file.".config/qmk/cheatsheet-wrapper.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl dispatch movecursor 1280 720
      kitty -T crkbd -o cursor="#1a1b26" -o cursor_trail=0 -e ~/.config/qmk/crkbd-cheatsheet.sh
    '';
  };
}
