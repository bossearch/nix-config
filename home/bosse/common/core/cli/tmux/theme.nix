{config, ...}: let
  base00 = "#${config.colorScheme.palette.base00}";
  base01 = "#${config.colorScheme.palette.base01}";
  base02 = "#${config.colorScheme.palette.base02}";
  base03 = "#${config.colorScheme.palette.base03}";
  base05 = "#${config.colorScheme.palette.base05}";
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}";
  base0A = "#${config.colorScheme.palette.base0A}";
  base0B = "#${config.colorScheme.palette.base0B}";
  base0C = "#${config.colorScheme.palette.base0C}";
  base0D = "#${config.colorScheme.palette.base0D}";
  base0F = "#${config.colorScheme.palette.base0F}";
in {
  home.file.".config/tmux/theme.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      declare -A THEME=(
        ["background"]="${base00}"
        ["foreground"]="${base05}"
        ["black"]="${base01}"
        ["blue"]="${base0D}"
        ["green"]="${base0B}"
        ["white"]="${base07}"
        ["bblack"]="${base03}"
        ["bblue"]="${base0D}"
        ["bgreen"]="${base0F}"
        ['ghgreen']="${base0C}"
        ['ghred']="${base08}"
        ['ghyellow']="${base0A}"
        ['ghsky']="${base02}"
        ['ghturquoise']="${base0F}"
      )

      RESET="#[fg=''${THEME[foreground]},bg=''${THEME[background]},nobold,noitalics,nounderscore,nodim]"
    '';
  };
}
