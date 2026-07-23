{hosts, ...}: let
  keyboard =
    if hosts.hostname == "silvia"
    then ''
      hl.device({
          name = "foostan-corne",
          kb_options = "lv3:ralt_switch",
          repeat_rate = 40,
          repeat_delay = 400,
      })
    ''
    else ''
      hl.device({
          name = "at-translated-set-2-keyboard",
          kb_options = "lv3:ralt_switch",
          repeat_rate = 40,
          repeat_delay = 400,
      })
    '';
in {
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.input" = {
      autoLoad = true;
      content = ''
        ---------------
        ---- INPUT ----
        ---------------

        hl.config({
            input = {
                kb_layout = "us",
                follow_mouse = 2,
                focus_on_close = 0,
                float_switch_override_focus = 0,
                touchpad = {
                    natural_scroll = false,
                },
            },
        })

        hl.device({
            name = "corsair-corsair-gaming-scimitar-pro-rgb-mouse-1",
            sensitivity = 0.5,
            accel_profile = "flat",
        })

        hl.device({
            name = "foostan-corne-mouse",
            sensitivity = 0.5,
            accel_profile = "flat",
        })

        ${keyboard}
      '';
    };
  };
}
