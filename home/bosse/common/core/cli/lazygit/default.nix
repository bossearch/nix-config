{config, ...}: let
  base02 = "#${config.colorScheme.palette.base02}";
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}";
  base09 = "#${config.colorScheme.palette.base09}";
  base0A = "#${config.colorScheme.palette.base0A}";
  base0D = "#${config.colorScheme.palette.base0D}";
  base0F = "#${config.colorScheme.palette.base0F}";
  base0E = "#${config.colorScheme.palette.base0E}";
in {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        nerdFontsVersion = "3";
        theme = {
          activeBorderColor = ["${base09}" "bold"];
          inactiveBorderColor = ["${base0F}"];
          searchingActiveBorderColor = ["${base09}" "bold"];
          optionsTextColor = ["${base0D}"];
          selectedLineBgColor = ["${base02}"];
          cherryPickedCommitFgColor = ["${base0D}"];
          cherryPickedCommitBgColor = ["${base0E}"];
          markedBaseCommitFgColor = ["${base0D}"];
          markedBaseCommitBgColor = ["${base0A}"];
          unstagedChangesColor = ["${base08}"];
          defaultFgColor = ["${base07}"];
        };
      };
    };
  };
}
