{
  programs.mpv = {
    scriptOpts = {
      chapters = {
        autoload = "yes";
        autosave = "no";
        global_chapters = "no";
      };
      chapterskip = {
        skip = "opening;ending;mycategory";
        categories = "mycategory>Pembuka/pembuka/Penutup/penutup/Selanjutnya/Pratinjau/op/Preview/PV";
      };
      command_palette = {
        font_size = 15;
        scale_by_window = "yes";
        lines_to_show = 20;
      };
      console = {
        font_size = 24;
        border_size = 1.5;
      };
      evafast = {
        seek_distance = 5;
        speed_increase = 0.1;
        speed_decrease = 0.1;
        speed_interval = 0.05;
        speed_cap = 2;
        subs_speed_cap = 1.8;
        multiply_modifier = "no";
        show_speed = "yes";
        show_speed_toggled = "yes";
        show_seek = "yes";
        lookahead = "no";
      };
      gallery_worker = {
        ytdl_exclude = "";
      };
      memo = {
        history_path = "~/.cache/mpv/memo-history.log";
        entries = 10;
        pagination = "yes";
        hide_duplicates = "yes";
        hide_deleted = "yes";
        hide_same_dir = "no";
        timestamp_format = "";
        use_titles = "yes";
        truncate_titles = 60;
        enabled = "yes";
        up_binding = "UP WHEEL_UP";
        down_binding = "DOWN WHEEL_DOWN";
        select_binding = "RIGHT ENTER";
        append_binding = "Shift+RIGHT Shift+ENTER";
        close_binding = "LEFT ESC";
        path_prefixes = "pattern:.*";
      };
      playlist_view = {
        gallery_position = "{ (ww - gw) / 2, (wh - gh) / 2 }";
        gallery_size = "{ 9 * ww / 10, 9 * wh / 10 }";
        min_spacing = "{ 15, 15 }";
        thumbnail_size = "(ww * wh <= 1366 * 768) and {192, 108} or {288, 162}";
        max_thumbnails = 64;
        take_thumbnail_at = "20%";
        load_file_on_toggle_off = "no";
        close_on_load_file = "yes";
        pause_on_start = "yes";
        resume_on_stop = "only-if-did-pause";
        start_on_mpv_startup = "no";
        follow_playlist_position = "yes";
        remember_time_position = "yes";
        show_text = "yes";
        show_title = "yes";
        strip_directory = "yes";
        strip_extension = "yes";
        text_size = 28;
        background_color = 000000;
        background_opacity = 33;
        normal_border_color = "FFFFFF";
        normal_border_size = 1;
        selected_border_color = "40407C";
        selected_border_size = 4;
        highlight_active = "yes";
        active_border_color = 272763;
        active_border_size = 6;
        flagged_border_color = "E29571";
        flagged_border_size = 4;
        placeholder_color = 000000;
        command_on_open = "";
        command_on_close = "";
        flagged_file_path = "./.cache/mpv";
        mouse_support = "yes";
        UP = "UP";
        DOWN = "DOWN";
        LEFT = "LEFT";
        RIGHT = "RIGHT";
        PAGE_UP = "PGUP";
        PAGE_DOWN = "PGDWN";
        FIRST = "HOME";
        LAST = "END";
        RANDOM = "r";
        ACCEPT = "ENTER";
        CANCEL = "ESC";
        REMOVE = "DEL";
        FLAG = "SPACE";
      };
      stats = {
        key_page_2 = "w";
        key_page_3 = "e";
        key_page_4 = "r";
        key_scroll_up = "UP";
        key_scroll_down = "DOWN";
        duration = 10;
        persistent_overlay = "yes";
        plot_vsync_ratio = "no";
        plot_vsync_jitter = "no";
        font_size = 20;
        font_color = "ffffff";
        border_size = 0.2;
        border_color = 000000;
        alpha = 11;
      };
      thumbfast = {
        socket = "";
        thumbnail = "";
        max_height = 200;
        max_width = 200;
        scale_factor = 1;
        tone_mapping = "auto";
        overlay_id = 42;
        spawn_first = "yes";
        quit_after_inactivity = 0;
        network = "yes";
        audio = "no";
        hwdec = "yes";
        direct_io = "no";
        mpv_path = "mpv";
      };
      uosc = {
        timeline_style = "line";
        timeline_line_width = 2;
        timeline_size = 25;
        timeline_persistency = "paused";
        timeline_border = 1;
        timeline_step = 5;
        progress = "windowed";
        progress_size = 2;
        progress_line_width = 20;
        subtitles = " command:subtitles:script-binding uosc/subtitles#sub?Subtitles";
        controls = "menu,command:search:script-binding youtube_search/search_youtube?Youtube Search,gap,<has_chapter>command:keyboard_double_arrow_left:add chapter -1?Previous Chapters,<has_chapter>chapters,<has_chapter>command:keyboard_double_arrow_right:add chapter 1?Next Chapters,<!has_chapter,!image>command:keyboard_double_arrow_right:script-binding skip-key?Skip To Silence,gap,<has_many_video>video,<has_many_audio>audio,<has_many_edition>editions,<stream>stream-quality,<stream>command:subscriptions:script-message-to youtube_upnext menu?Recommendations,<stream>toggle:subtitles:sub-visibility?Subtitles,<!stream,!image>subtitles,<!stream,!image>button:toggle_translation,<!stream,!image>button:toggle_vapoursynth,space,speed,space,gap,loop-file,loop-playlist,shuffle,gap,command:history:script-binding memo-history?History,gap,prev,<stream>command:list_alt:script-binding end/end?Playlist/Gallery,<!stream,!image>items?Playlist/Gallery,<image>command:list_alt:script-binding end/end?Playlist/Gallery,next,gap,fullscreen";
        controls_size = 35;
        controls_margin = 8;
        controls_spacing = 2;
        controls_persistency = "";
        volume = "right";
        volume_size = 39;
        volume_border = 1;
        volume_step = 1;
        volume_persistency = "";
        speed_step = 0.05;
        speed_step_is_factor = "no";
        speed_persistency = "";
        menu_item_height = 35;
        menu_min_width = 290;
        menu_padding = 4;
        menu_type_to_search = "yes";
        top_bar = "no-border";
        top_bar_size = 45;
        top_bar_controls = "right";
        top_bar_title = "yes";
        top_bar_alt_title = "''\${filename}";
        top_bar_alt_title_place = "toggle";
        top_bar_flash_on = "video,audio";
        top_bar_persistency = "";
        window_border_size = 1;
        autoload = "no";
        autoload_types = "video,audio,image";
        shuffle = "no";
        scale = 1;
        scale_fullscreen = 1;
        font_scale = 1.18;
        text_border = 1.2;
        border_radius = 2;
        color = "";
        opacity = "timeline=0.8,speed=0,menu=0.84,title=0,tooltip=0.8,curtain=0.13";
        refine = "=text_width";
        animation_duration = 100;
        click_threshold = 100;
        click_command = "cycle pause; script-binding uosc/flash-pause-indicator";
        flash_duration = 1000;
        proximity_in = 40;
        proximity_out = 120;
        font_bold = "yes";
        destination_time = "total";
        time_precision = 0;
        buffered_time_threshold = 60;
        autohide = "no";
        pause_indicator = "flash";
        stream_quality_options = "4320,2160,1440,1080,720,480,360,240,144";
        video_types = "3g2,3gp,asf,avi,f4v,flv,h264,h265,m2ts,m4v,mkv,mov,mp4,mp4v,mpeg,mpg,ogm,ogv,rm,rmvb,ts,vob,webm,wmv,y4m";
        audio_types = "aac,ac3,aiff,ape,au,cue,dsf,dts,flac,m4a,mid,midi,mka,mp3,mp4a,oga,ogg,opus,spx,tak,tta,wav,weba,wma,wv";
        image_types = "apng,avif,bmp,gif,j2k,jp2,jfif,jpeg,jpg,jxl,mj2,png,svg,tga,tif,tiff,webp";
        subtitle_types = "aqt,ass,gsub,idx,jss,lrc,mks,pgs,pjs,psb,rt,sbv,slt,smi,sub,sup,srt,ssa,ssf,ttxt,txt,usf,vt,vtt";
        playlist_types = "m3u,m3u8,pls,url,cue";
        default_directory = "~/";
        show_hidden_files = "no";
        use_trash = "no";
        adjust_osd_margins = "yes";
        chapter_ranges = "openings:30abf964,endings:30abf964,ads:c54e4e80";
        chapter_range_patterns = "openings:オープニング;endings:エンディング";
        languages = "slang,en";
        disable_elements = "";
      };
      youtube_upnext = {
        toggle_menu_binding = "ctrl+u";
        up_binding = "UP";
        down_binding = "DOWN";
        select_binding = "ENTER";
        fetch_on_start = "no";
        auto_add = "yes";
        cursor_selected = "● ";
        cursor_unselected = "○ ";
        cursor_appended = "▷ ";
        cursor_appended_selected = "▶ ";
        scale_playlist_by_window = "no";
        style_ass_tags = "{\\fnmonospace\\fs25}";
        text_padding_x = 5;
        text_padding_y = 5;
        curtain_opacity = 0.7;
        menu_timeout = 10;
        youtube_url = "https://www.youtube.com/watch?v=%s";
        invidious_instance = "https://inv.tux.pizza";
        restore_window_width = "no";
        check_certificate = "yes";
        keep_playlist_on_select = "yes";
        uosc_entry_action = "submenu";
        uosc_keep_menu_open = "no";
      };
    };
  };
  home.file.".config/mpv/script-opts/end.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Path to the mpv IPC socket
      MPV_SOCKET="/tmp/mpv-socket"

      # Check if the socket exists
      if [[ ! -e "$MPV_SOCKET" ]]; then
        echo "mpv IPC socket not found. Is mpv running with --input-ipc-server?"
        exit 1
      fi

      #echo '{ "command": ["script-message", "playlist-view-toggle"] }' | socat - UNIX-CONNECT:"$MPV_SOCKET"
      # Seek to the last second of the video
      echo '{ "command": ["seek", "99999", "absolute"] }' | socat - UNIX-CONNECT:"$MPV_SOCKET"

      # Resume playback if paused
      echo '{ "command": ["set_property", "pause", false] }' | socat - UNIX-CONNECT:"$MPV_SOCKET"
    '';
  };
}
