{config, ...}: let
  base00 = "${config.lib.stylix.colors.withHashtag.base00}";
  base01 = "${config.lib.stylix.colors.withHashtag.base01}";
  base02 = "${config.lib.stylix.colors.withHashtag.base02}";
  base03 = "${config.lib.stylix.colors.withHashtag.base03}";
  base05 = "${config.lib.stylix.colors.withHashtag.base05}";
  base07 = "${config.lib.stylix.colors.withHashtag.base07}";
  base08 = "${config.lib.stylix.colors.withHashtag.base08}";
  base0A = "${config.lib.stylix.colors.withHashtag.base0A}";
  base0B = "${config.lib.stylix.colors.withHashtag.base0B}";
  base0C = "${config.lib.stylix.colors.withHashtag.base0C}";
  base0D = "${config.lib.stylix.colors.withHashtag.base0D}";
  base0F = "${config.lib.stylix.colors.withHashtag.base0F}";
in {
  home.file.".config/tmux/theme.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      declare -A THEME=(
        ["background"]="${base00}" #
        ["foreground"]="${base05}" # #network #wbgit
        ["black"]="${base01}" #
        ["blue"]="${base0D}" # #date #music
        ["green"]="${base0B}" #
        ["white"]="${base07}" #
        ["bblack"]="${base03}" #
        ["bblue"]="${base0D}" # #network
        ["bgreen"]="${base0F}" # #network
        ['ghgreen']="${base0C}" #wbgit
        ['ghred']="${base08}" #wbgit
        ['ghyellow']="${base0A}" #wbgit
        ['ghsky']="${base02}" # #date
        ['ghturquoise']="${base0F}" #
      )

      RESET="#[fg=''${THEME[foreground]},bg=''${THEME[background]},nobold,noitalics,nounderscore,nodim]"
    '';
  };
}
