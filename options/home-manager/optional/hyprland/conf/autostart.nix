{
  config,
  homes,
  ...
}: let
  footclient =
    if config.programs.foot.enable
    then "hl.exec_cmd(\"~/.config/foot/footclient.sh\")"
    else "";
  gowall =
    if homes.gowall
    then "hl.exec_cmd(\"~/.config/gowall/daily-wallpaper.sh\")"
    else "";
in {
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.autostart" = {
      autoLoad = true;
      content = ''
        -------------------
        ---- AUTOSTART ----
        -------------------

        hl.on("hyprland.start", function()
            hl.exec_cmd("hyprlock --immediate-render --no-fade-in")
            hl.exec_cmd("hyprpaper")
            hl.exec_cmd("blueman-applet")

            hl.exec_cmd("cliphist wipe")
            hl.exec_cmd("wl-paste --watch cliphist store")

            hl.exec_cmd("~/.config/hypr/scripts/startup-value.sh")
            ${footclient}
            ${gowall}
        end)
      '';
    };
  };
}
