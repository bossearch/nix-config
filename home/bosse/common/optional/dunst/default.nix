{pkgs, ...}: {
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
        background = "#16161e";
        foreground = "#1a1b26";
        monitor = 0;
        follow = "mouse";
        width = "(0,600)";
        height = "(0,300)";
        progress_bar = true;
        progress_bar_height = 25;
        progress_bar_frame_width = 3;
        progress_bar_min_width = 460;
        progress_bar_max_width = 480;
        highlight = "#79dcaa";
        indicate_hidden = true;
        shrink = true;
        transparency = 5;
        separator_height = 2;
        padding = 10;
        horizontal_padding = 10;
        frame_width = 0;
        frame_color = "#ebdbb2";
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
        icon_theme = "Papirus,papirus";
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
        background = "#1a1b26";
        foreground = "#c0caf5";
        frame_color = "#c0caf5";
        icon = "dialog-information";
        script = "~/.config/dunst/dunstsound.sh";
      };
      urgency_normal = {
        timeout = 3;
        background = "#16161e";
        foreground = "#c0caf5";
        frame_color = "#c0caf5";
        icon = "dialog-information";
        script = "~/.config/dunst/dunstsound.sh";
      };
      urgency_critical = {
        timeout = 4;
        background = "#292e42";
        foreground = "#db4b4b";
        frame_color = "#db4b4b";
        icon = "dialog-warning";
        script = "~/.config/dunst/dunstsound.sh";
      };
      zsh = {
        appname = "zsh";
        new_icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps/kitty.svg";
      };
      nchat = {
        appname = "nchat";
        new_icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/16x16/panel/google-chat-badge.svg";
      };
    };
  };
}
