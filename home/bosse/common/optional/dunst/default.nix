{
  config,
  pkgs,
  ...
}: let
  base00 = "${config.lib.stylix.colors.withHashtag.base00}";
  base01 = "${config.lib.stylix.colors.withHashtag.base01}";
  base02 = "${config.lib.stylix.colors.withHashtag.base02}";
  base07 = "${config.lib.stylix.colors.withHashtag.base07}";
  base08 = "${config.lib.stylix.colors.withHashtag.base08}";
in {
  imports = [
    ./dunstsound.nix
    ./sound.nix
  ];
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    settings = {
      global = {
        background = base01;
        foreground = base00;
        monitor = 0;
        follow = "mouse";
        width = "(0,600)";
        height = "(0,300)";
        progress_bar = true;
        progress_bar_height = 25;
        progress_bar_frame_width = 3;
        progress_bar_min_width = 460;
        progress_bar_max_width = 480;
        indicate_hidden = true;
        shrink = true;
        transparency = 5;
        separator_height = 2;
        padding = 10;
        horizontal_padding = 10;
        frame_width = 0;
        sort = "update";
        idle_threshold = 0;
        font = "CommitMono Nerd Font 13";
        line_height = 2;
        markup = "full";
        origin = "top-right";
        offset = "(10, 10)";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        show_age_threshold = 60;
        word_wrap = true;
        ignore_newline = false;
        stack_duplicates = false;
        hide_duplicate_count = false;
        show_indicators = true;
        icon_position = "left";
        max_icon_size = 86;
        min_icon_size = 32;
        icon_theme = "Papirus";
        enable_recursive_icon_lookup = true;
        sticky_history = true;
        history_length = 20;
        browser = "firefox";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 8;
        icon_corner_radius = 5;
        notification_limit = 5;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action";
        mouse_right_click = "context_all";
        ignore_dbusclose = true;
        ellipsize = "middle";
      };
      urgency_low = {
        timeout = 2;
        background = base00;
        foreground = base07;
        frame_color = base07;
        icon = "dialog-information";
        script = "~/.config/dunst/dunstsound.sh";
      };
      urgency_normal = {
        timeout = 3;
        background = base01;
        foreground = base07;
        frame_color = base07;
        icon = "dialog-information";
        script = "~/.config/dunst/dunstsound.sh";
      };
      urgency_critical = {
        timeout = 4;
        background = base02;
        foreground = base08;
        frame_color = base08;
        icon = "dialog-warning";
        script = "~/.config/dunst/dunstsound.sh";
      };
      zsh = {
        appname = "zsh";
        new_icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps/utilities-terminal.svg";
      };
      fish = {
        appname = "fish";
        new_icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps/utilities-terminal.svg";
      };
      nchat = {
        appname = "nchat";
        new_icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps/internet_chat.svg";
      };
      game_on = {
        appname = "game_on";
        new_icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/status/state_running.svg";
      };
      game_off = {
        appname = "game_off";
        new_icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/status/state_paused.svg";
      };
      playerctl = {
        appname = "playerctl";
        new_icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps/xt7-player-mpv.svg";
      };
      screenshot = {
        appname = "screenshot";
        new_icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/devices/camera-photo.svg";
      };
      screenrecord = {
        appname = "screenrecord";
        new_icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/devices/camera-video.svg";
      };
    };
  };
}
