{config, ...}: let
  height =
    if builtins.all (m: m.height == 1080) config.monitors
    then "100%"
    else "115%";
  base00 = "#${config.colorScheme.palette.base00}";
  base01 = "#${config.colorScheme.palette.base01}";
  base02 = "#${config.colorScheme.palette.base02}";
  base03 = "#${config.colorScheme.palette.base03}";
  base04 = "#${config.colorScheme.palette.base04}";
  base05 = "#${config.colorScheme.palette.base05}";
  base06 = "#${config.colorScheme.palette.base06}";
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
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      symbol_map = let
        mappings = [
          "U+e000-U+e00a"
          "U+ea60-U+ebeb"
          "U+e0a0-U+e0c8"
          "U+e0ca"
          "U+e0cc-U+e0d7"
          "U+e200-U+e2a9"
          "U+e300-U+e3e3"
          "U+e5fa-U+e6b1"
          "U+e700-U+e7c5"
          "U+ed00-U+efc1"
          "U+f000-U+f2ff"
          "U+f000-U+f2e0"
          "U+f300-U+f372"
          "U+f400-U+f533"
          "U+f0001-U+f1af0"
        ];
      in
        (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font Mono";
    };
    keybindings = {
      "ctrl+plus" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+equal" = "change_font_size all 0";
      "0x1008ff57" = "copy_to_clipboard";
      "0x1008ff6d" = "paste_from_clipboard";
    };
    environment = {
      "TERM" = "xterm-256color";
    };
    extraConfig = ''
      # BEGIN_KITTY_FONTS
      font_family family='CommitMono Nerd Font Mono' style=Regular features='+ss03 +ss04 +ss05 cv02=1 cv05=1'
      bold_font auto
      italic_font auto
      bold_italic_font auto
      font_size 12.0

      # modify_font cell_width 150%
      modify_font cell_height ${height}
      modify_font underline_thickness 120%

      # Cursor
      cursor_shape block
      cursor_trail 1
      cursor_trail_decay 0.1 0.2

      # OSC 52 clipboard support (copy/paste)
      allow_remote_control yes

      # Mouse
      mouse_map left click ungrabbed mouse_handle_click selection link prompt
      mouse_map middle release ungrabbed paste_from_selection
      # vim:ft=kitty

      background ${base00}
      foreground ${base07}
      selection_background ${base02}
      selection_foreground ${base07}
      url_color ${base0F}
      cursor ${base07}
      cursor_text_color ${base00}

      # Tabs
      active_tab_background ${base0D}
      active_tab_foreground ${base01}
      inactive_tab_background ${base03}
      inactive_tab_foreground ${base04}
      #tab_bar_background ${base01}

      # Windows
      active_border_color ${base0D}
      inactive_border_color ${base03}

      # normal
      color0 ${base01}
      color1 ${base08}
      color2 ${base0B}
      color3 ${base0A}
      color4 ${base0D}
      color5 ${base0E}
      color6 ${base0C}
      color7 ${base05}

      # bright
      color8 ${base03}
      color9 ${base08}
      color10 ${base0B}
      color11 ${base0A}
      color12 ${base0D}
      color13 ${base0E}
      color14 ${base0C}
      color15 ${base07}

      # extended colors
      color16 ${base09}
      color17 ${base06}
    '';
  };
}
