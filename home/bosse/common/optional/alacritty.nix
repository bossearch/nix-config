{config, ...}: let
  base00 = "${config.lib.stylix.colors.withHashtag.base00}";
  base01 = "${config.lib.stylix.colors.withHashtag.base01}";
  base03 = "${config.lib.stylix.colors.withHashtag.base03}";
  base05 = "${config.lib.stylix.colors.withHashtag.base05}";
  base07 = "${config.lib.stylix.colors.withHashtag.base07}";
  base08 = "${config.lib.stylix.colors.withHashtag.base08}";
  base0A = "${config.lib.stylix.colors.withHashtag.base0A}";
  base0B = "${config.lib.stylix.colors.withHashtag.base0B}";
  base0C = "${config.lib.stylix.colors.withHashtag.base0C}";
  base0D = "${config.lib.stylix.colors.withHashtag.base0D}";
  base0E = "${config.lib.stylix.colors.withHashtag.base0E}";
  base0F = "${config.lib.stylix.colors.withHashtag.base0F}";
in {
  programs.alacritty = {
    enable = true;
    settings = {
      general.live_config_reload = true;
      env.TERM = "xterm-256color";
      window.decorations = "None";
      window.padding.x = 0;
      window.padding.y = 0;
      window.dynamic_padding = true;
      window.dynamic_title = true;
      window.option_as_alt = "Both";
      font.normal.family = "MesloLGS Nerd Font";
      font.bold.family = "MesloLGS Nerd Font";
      font.italic.family = "MesloLGS Nerd Font";
      font.bold_italic.family = "MesloLGS Nerd Font";
      font.offset.x = 0;
      font.offset.y = 0;
      font.size = 12;
      font.builtin_box_drawing = true;
      cursor.style = "block";
      terminal.osc52 = "CopyPaste";
      keyboard.bindings = [
        {
          key = "+";
          mods = "Control";
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

      # Color settings
      colors.primary.background = base00;
      colors.primary.foreground = base07;
      colors.normal.black = base01;
      colors.normal.red = base08;
      colors.normal.green = base0B;
      colors.normal.yellow = base0A;
      colors.normal.blue = base0D;
      colors.normal.magenta = base0E;
      colors.normal.cyan = base0C;
      colors.normal.white = base05;
      colors.bright.black = base03;
      colors.bright.red = base08;
      colors.bright.green = base0B;
      colors.bright.yellow = base0A;
      colors.bright.blue = base0D;
      colors.bright.magenta = base0E;
      colors.bright.cyan = base0C;
      colors.bright.white = base07;
      colors.indexed_colors = [
        {
          index = 16;
          color = base0E;
        }
        {
          index = 17;
          color = base0F;
        }
      ];
    };
  };
}
