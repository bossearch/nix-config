{
  programs.alacritty = {
    enable = true;
    settings = {
      # General settings
      general.live_config_reload = true;

      # Environment variables
      env.TERM = "xterm-256color";

      # Window settings
      window.decorations = "None";
      window.padding.x = 0;
      window.padding.y = 0;
      window.dynamic_padding = true;
      window.dynamic_title = true;
      window.option_as_alt = "Both";

      # Font settings
      font.normal.family = "MesloLGS Nerd Font";
      font.bold.family = "MesloLGS Nerd Font";
      font.italic.family = "MesloLGS Nerd Font";
      font.bold_italic.family = "MesloLGS Nerd Font";
      font.offset.x = 0;
      font.offset.y = 0;
      font.size = 12;
      font.builtin_box_drawing = true;

      # Cursor settings
      cursor.style = "block";

      # Terminal settings
      terminal.osc52 = "CopyPaste";

      # Keyboard bindings
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
      colors.primary.background = "#1a1b26";
      colors.primary.foreground = "#c0caf5";

      colors.normal.black = "#16161e";
      colors.normal.red = "#f7768e";
      colors.normal.green = "#9ece6a";
      colors.normal.yellow = "#e0af68";
      colors.normal.blue = "#7aa2f7";
      colors.normal.magenta = "#bb9af7";
      colors.normal.cyan = "#7dcfff";
      colors.normal.white = "#a9b1d6";

      colors.bright.black = "#414868";
      colors.bright.red = "#ff899d";
      colors.bright.green = "#9fe044";
      colors.bright.yellow = "#faba4a";
      colors.bright.blue = "#8db0ff";
      colors.bright.magenta = "#c7a9ff";
      colors.bright.cyan = "#a4daff";
      colors.bright.white = "#c0caf5";

      colors.indexed_colors = [
        {
          index = 16;
          color = "#ff9e64";
        }
        {
          index = 17;
          color = "#db4b4b";
        }
      ];
    };
  };
}
