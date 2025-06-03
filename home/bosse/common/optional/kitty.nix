{config, ...}: let
  height =
    if builtins.all (m: m.height == 1080) config.monitors
    then "100%"
    else "115%";
in {
  programs.kitty = {
    enable = true;
    themeFile = "tokyo_night_night";
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
      "ctrl+KP_Add" = "change_font_size all +2.0";
      "ctrl+KP_Subtract" = "change_font_size all -2.0";
      "ctrl+equal" = "change_font_size all 0";
      "0x1008ff57" = "copy_to_clipboard";
      "0x1008ff6d" = "paste_from_clipboard";
    };
    environment = {
      "TERM" = "xterm-256color";
    };
    extraConfig = ''
      # BEGIN_KITTY_FONTS
      font_family family='CommitMono Nerd Font Mono' style=Regular features='+ss01 +ss02 +ss03 +ss04 +ss05 cv02=1 cv05=1'
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
    '';
  };
}
