{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.layerrule" = {
      autoLoad = true;
      content = ''
        -------------------
        ---- LAYERRULE ----
        -------------------

        hl.layer_rule({
            match = { namespace = "waybar" },
            blur = true,
            blur_popups = true,
            ignore_alpha = 0,
        })
        hl.layer_rule({
            match = { namespace = "swaync-control-center" },
            blur = true,
            ignore_alpha = 0,
        })
        hl.layer_rule({
            match = { namespace = "swaync-notification-window" },
            blur = true,
            ignore_alpha = 0.5,
        })
      '';
    };
  };
}
