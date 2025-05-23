{config, ...}: let
  timeout =
    if config.spec.hostName == "vm"
    then 86400
    else 3600;
in {
  services.hypridle = {
    enable = true;
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
          timeout = timeout;
          on-timeout = "(playerctl -a status | grep -q 'Playing' || systemctl suspend)";
        }
      ];
    };
  };
}
