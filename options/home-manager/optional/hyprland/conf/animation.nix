{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.animation" = {
      autoLoad = true;
      content = ''
        --------------------
        ---- ANIMATIONS ----
        --------------------

        -- stylua: ignore start
        hl.config({ animations = { enabled = true } })
        hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })

        hl.animation({ leaf = "windows",          enabled = true, speed = 1, bezier = "md3_decel", style = "slide" })
        hl.animation({ leaf = "windowsOut",       enabled = false })
        hl.animation({ leaf = "windowsIn",        enabled = true, speed = 1, bezier = "md3_decel", style = "popin" })
        hl.animation({ leaf = "windowsMove",      enabled = true, speed = 1, bezier = "md3_decel", style = "slide" })
        hl.animation({ leaf = "border",           enabled = true, speed = 4, bezier = "md3_decel" })
        hl.animation({ leaf = "fade",             enabled = true, speed = 4, bezier = "md3_decel" })
        hl.animation({ leaf = "fadeDim",          enabled = true, speed = 4, bezier = "md3_decel" })
        hl.animation({ leaf = "workspaces",       enabled = true, speed = 2, bezier = "md3_decel", style = "slide" })
        hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "md3_decel", style = "slidevert" })
        hl.animation({ leaf = "fadeSwitch",       enabled = false })
        -- stylua: ignore end
      '';
    };
  };
}
