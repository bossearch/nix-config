{
  config,
  homes,
  pkgs,
  ...
}: let
  base00 = "#${config.colorScheme.palette.base00}";
  base01 = "#${config.colorScheme.palette.base01}";
  base03 = "#${config.colorScheme.palette.base03}";
  base05 = "#${config.colorScheme.palette.base05}";
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}";
  base0A = "#${config.colorScheme.palette.base0A}";
  base0B = "#${config.colorScheme.palette.base0B}";
  base0C = "#${config.colorScheme.palette.base0C}";
  base0D = "#${config.colorScheme.palette.base0D}";
  base0E = "#${config.colorScheme.palette.base0E}";
  base0F = "#${config.colorScheme.palette.base0F}";
in {
  programs.alacritty = {
    enable = homes.terminal == "alacritty";
    package = pkgs.alacritty-graphics;
    settings = {
      colors = {
        bright = {
          black = base03;
          red = base08;
          green = base0B;
          yellow = base0A;
          blue = base0D;
          magenta = base0E;
          cyan = base0C;
          white = base07;
        };
        cursor = {
          text = base01;
          cursor = base07;
        };
        indexed_colors = [
          {
            index = 16;
            color = base0E;
          }
          {
            index = 17;
            color = base0F;
          }
        ];
        normal = {
          black = base00;
          red = base08;
          green = base0B;
          yellow = base0A;
          blue = base0D;
          magenta = base0E;
          cyan = base0C;
          white = base05;
        };
        primary = {
          background = base01;
          foreground = base07;
        };
      };
      cursor.style = "block";
      env.TERM = "xterm-256color";
      font = {
        normal.family = "${homes.nerdfont} Nerd Font";
        bold.family = "${homes.nerdfont} Nerd Font";
        italic.family = "${homes.nerdfont} Nerd Font";
        bold_italic.family = "${homes.nerdfont} Nerd Font";
        offset = {
          x = 0;
          y = 2;
        };
        size = 12;
        builtin_box_drawing = true;
      };
      keyboard.bindings = [
        {
          key = "Copy";
          action = "Copy";
        }
        {
          key = "Paste";
          action = "Paste";
        }
        {
          key = "+";
          mods = "Control|Shift";
          action = "IncreaseFontSize";
        }
        {
          key = "-";
          mods = "Control";
          action = "DecreaseFontSize";
        }
        {
          key = "=";
          mods = "Control";
          action = "ResetFontSize";
        }
      ];
      terminal.osc52 = "CopyPaste";
      window = {
        decorations = "None";
        padding.x = 0;
        padding.y = 0;
        dynamic_padding = true;
        dynamic_title = true;
        option_as_alt = "Both";
      };
    };
  };
}
