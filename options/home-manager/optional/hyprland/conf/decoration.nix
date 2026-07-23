{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.decoration" = {
      autoLoad = true;
      content = ''
        --------------------
        ---- DECORATION ----
        --------------------

        hl.config({
            decoration = {
                rounding = 8,
                active_opacity = 0.9,
                inactive_opacity = 0.85,

                blur = {
                    enabled = true,
                    size = 6,
                    passes = 4,
                    new_optimizations = true,
                },
                shadow = {
                    enabled = false,
                },
            },
        })
      '';
    };
  };
}
