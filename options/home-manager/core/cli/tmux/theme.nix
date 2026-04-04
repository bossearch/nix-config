{config, ...}: let
  base00 = "#${config.colorScheme.palette.base00}";
  base01 = "#${config.colorScheme.palette.base01}";
  base02 = "#${config.colorScheme.palette.base02}";
  base03 = "#${config.colorScheme.palette.base03}";
  base04 = "#${config.colorScheme.palette.base04}";
  base05 = "#${config.colorScheme.palette.base05}";
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}";
  base09 = "#${config.colorScheme.palette.base09}";
  base0A = "#${config.colorScheme.palette.base0A}";
  base0B = "#${config.colorScheme.palette.base0B}";
  base0C = "#${config.colorScheme.palette.base0C}";
  base0D = "#${config.colorScheme.palette.base0D}";
  base0E = "#${config.colorScheme.palette.base0E}";
  base0F = "#${config.colorScheme.palette.base0F}";
in {
  home.file.".config/tmux/theme.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      declare -A THEME=(
        ["base00"]="${base00}"
        ["base01"]="${base01}"
        ["base02"]="${base02}"
        ["base03"]="${base03}"
        ["base04"]="${base04}"
        ["base05"]="${base05}"
        ["base07"]="${base07}"
        ["base08"]="${base08}"
        ["base09"]="${base09}"
        ["base0A"]="${base0A}"
        ["base0B"]="${base0B}"
        ["base0C"]="${base0C}"
        ["base0D"]="${base0D}"
        ["base0E"]="${base0E}"
        ["base0F"]="${base0F}"
      )

      RESET="#[fg=''${THEME[base05]},bg=''${THEME[base01]},nobold,noitalics,nounderscore,nodim]"
    '';
  };
}
