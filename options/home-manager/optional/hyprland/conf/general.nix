{config, ...}: let
  base00 = config.colorScheme.palette.base00;
  base03 = config.colorScheme.palette.base03;
in {
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.general" = {
      autoLoad = true;
      content = ''
        -----------------
        ---- GENERAL ----
        -----------------

        hl.config({
            general = {
                gaps_in = 4,
                gaps_out = 8,
                border_size = 2,

                col = {
                    active_border = "rgb(${base00})",
                    inactive_border = "rgb(${base03})",
                },

                resize_on_border = false,
                allow_tearing = true,
                layout = "master",
            },
        })
      '';
    };
  };
}
