{
  hosts,
  pkgs,
  ...
}: let
  enabled = hosts.gui.enable && hosts.hostname == "silvia";
in {
  home.packages = [pkgs.sway-audio-idle-inhibit];
  services.hypridle = {
    enable = enabled;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || ~/.config/hypr/scripts/hyprlock.sh";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({action = \"on\"})'";
      };
      listener = [
        # HYPRLOCK TIMEOUT
        {
          timeout = 900;
          on-timeout = "loginctl lock-session";
        }
        # DPMS TIMEOUT
        {
          timeout = 1800;
          on-timeout = "hyprctl dispatch 'hl.dsp.dpms({action = \"off\"})'";
          on-resume = "hyprctl dispatch 'hl.dsp.dpms({action = \"on\"})'";
        }
        # SUSPEND TIMEOUT
        {
          timeout = 3600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
