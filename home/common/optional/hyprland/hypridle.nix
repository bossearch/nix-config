{config, ...}: let
  enabled =
    if config.spec.hostName == "silvia"
    then true
    else false;
in {
  services.hypridle = {
    enable = enabled;
    settings = {
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
