{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.layerrule" = {
      autoLoad = true;
      content = ''
        hl.layer_rule({
            match = { namespace = "waybar" },
            blur = true,
            blur_popups = true,
            ignore_alpha = 0,
            xray = true,
        })
        hl.layer_rule({
            match = { namespace = "notifications" },
            blur = true,
            ignore_alpha = 0,
            no_screen_share = true,
        })
      '';
    };
  };
}
