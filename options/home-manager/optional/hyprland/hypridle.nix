{hosts, ...}: let
  enabled =
    hosts.gui.enable
    && hosts.gui.windowmanager == "hyprland"
    && hosts.hostname == "silvia";
in {
  services.hypridle = {
    enable = enabled;
    settings = {
      general = {
        after_sleep_cmd = "sleep 3 && systemctl --user restart waybar";
      };
      listener = [
        # HYPRLOCK TIMEOUT
        {
          timeout = 900;
          on-timeout = "(playerctl -a status | grep -q 'Playing' || ~/.config/hypr/scripts/hyprlock.sh)";
        }
        # DPMS TIMEOUT
        {
          timeout = 1800;
          on-timeout = "(playerctl -a status | grep -q 'Playing' || hyprctl dispatch dpms off)";
          on-resume = "hyprctl dispatch dpms on";
        }
        # SUSPEND TIMEOUT
        {
          timeout = 3600;
          on-timeout = "(playerctl -a status | grep -q 'Playing' || systemctl suspend)";
        }
      ];
    };
  };
}
