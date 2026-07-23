{config, ...}: let
  base00 = config.colorScheme.palette.base00;
in {
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.misc" = {
      autoLoad = true;
      content = ''
        --------------
        ---- MISC ----
        --------------

        hl.config({
            ecosystem = {
                no_update_news = true,
                no_donation_nag = true,
            },

            misc = {
                allow_session_lock_restore = true,
                background_color = "rgb(${base00})",
                disable_hyprland_logo = true,
                disable_splash_rendering = true,
                key_press_enables_dpms = true,
                mouse_move_enables_dpms = true,
            },

            debug = {
                vfr = true,
            },

            cursor = {
                zoom_rigid = true,
                zoom_detached_camera = false,
                enable_hyprcursor = true,
            },
        })
      '';
    };
  };
}
