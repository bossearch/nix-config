{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.layout" = {
      autoLoad = true;
      content = ''
        hl.config({
            dwindle = {
                preserve_split = true,
            },

            master = {
                mfact = 0.5,
            },

            scrolling = {
                direction = "right",
            },
        })
      '';
    };
  };
}
