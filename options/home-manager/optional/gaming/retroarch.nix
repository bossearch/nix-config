{
  homes,
  hosts,
  pkgs,
  ...
}: {
  programs.retroarch = {
    enable = homes.game.retroarch;
    package = pkgs.retroarch-bare;
    cores = {
      #--- Arcade ---#
      # Mame
      mame.enable = true;
      #--- Console ---#
      # Atari 2600
      stella.enable = true;
      # Nintendo Entertainment System
      mesen.enable = true;
      # Super Nintendo Entertainment System
      snes9x.enable = true;
      # Nintendo 64
      mupen64plus.enable = true;
      # Nintendo GameCube & Wii
      dolphin.enable = true;
      # NEC TurboGrafx CD/16
      beetle-pce-fast.enable = true;
      # Sega SG-1000, Master System, Mega Drive & Game Gear (Handheld)
      genesis-plus-gx.enable = true;
      # Sega Saturn
      beetle-saturn.enable = true;
      # Sega Dreamcast
      flycast.enable = true;
      # Sony Playstation
      beetle-psx-hw.enable = true;
      beetle-psx.enable = true;
      pcsx-rearmed.enable = true;
      swanstation.enable = true;
      #--- Handheld ---#
      # Bandai Wonderswan
      beetle-wswan.enable = true;
      # Nintendo-GB/GBC
      gambatte.enable = true;
      # Nintendo-GBA
      mgba.enable = true;
      # Nintendo-DS
      desmume.enable = true;
      # Nintendo-3DS
      citra.enable = true;
      # SNK Neo Geo Pocket/Color
      beetle-ngp.enable = true;
      # Sony PSP
      ppsspp.enable = true;
    };
    settings = {
      apply_cheats_after_toggle = "true";
      custom_viewport_height = "1440";
      custom_viewport_width = "1600";
      input_bind_timeout = "1";
      input_driver = "udev";
      input_joypad_driver = "sdl2";
      input_max_users = "1";
      input_menu_toggle_btn = "5";
      input_overlay_behind_menu = "true";
      input_overlay_enable = "true";
      input_overlay_hide_in_menu = "false";
      input_overlay_opacity = "1.000000";
      input_player1_a_btn = "1";
      input_player1_analog_dpad_mode = "1";
      input_player1_b_btn = "0";
      input_player1_device_reservation_type = "2";
      input_player1_down_btn = "12";
      input_player1_joypad_index = "1";
      input_player1_l2_axis = "+4";
      input_player1_l3_btn = "7";
      input_player1_l_btn = "9";
      input_player1_l_x_minus_axis = "-0";
      input_player1_l_x_plus_axis = "+0";
      input_player1_l_y_minus_axis = "-1";
      input_player1_l_y_plus_axis = "+1";
      input_player1_left_btn = "13";
      input_player1_r2_axis = "+5";
      input_player1_r3_btn = "8";
      input_player1_r_btn = "10";
      input_player1_r_x_minus_axis = "-2";
      input_player1_r_x_plus_axis = "+2";
      input_player1_r_y_minus_axis = "-3";
      input_player1_r_y_plus_axis = "+3";
      input_player1_reserved_device = "045e:028e Xbox 360 Controller";
      input_player1_right_btn = "14";
      input_player1_select_btn = "4";
      input_player1_start_btn = "6";
      input_player1_up_btn = "11";
      input_player1_x_btn = "3";
      input_player1_y_btn = "2";
      input_player2_joypad_index = "0";
      input_turbo_enable = "false";
      menu_driver = "xmb";
      menu_dynamic_wallpaper_enable = "false";
      menu_shader_pipeline = "0";
      menu_thumbnails = "2";
      menu_wallpaper = "~/.cache/${hosts.username}/retroarch.png";
      menu_wallpaper_opacity = "0.600000";
      network_on_demand_thumbnails = "true";
      notification_show_autoconfig = "false";
      notification_show_autoconfig_fails = "false";
      pause_nonactive = "false";
      pause_on_disconnect = "true";
      savestate_auto_save = "true";
      show_hidden_files = "true";
      video_driver = "vulkan";
      video_shader_enable = "true";
      xmb_theme = "7";
      xmb_vertical_thumbnails = "true";
    };
  };
}
