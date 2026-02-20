{
  config,
  hosts,
  homes,
  ...
}: let
  length =
    if builtins.all (m: m.width == 2560) homes.monitor
    then 120
    else 60;
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}";
  base0A = "#${config.colorScheme.palette.base0A}";
  base0B = "#${config.colorScheme.palette.base0B}";
  base0D = "#${config.colorScheme.palette.base0D}";
in {
  programs.waybar.settings = {
    mainBar = {
      # launcher and power
      "group/launcher" = {
        "orientation" = "inherit";
        "drawer" = {
          "transition-duration" = 500;
          "transition-left-to-right" = true;
        };
        "modules" = [
          "custom/launcher"
          "custom/lock"
          "custom/shutdown"
          "custom/reboot"
        ];
      };

      "custom/launcher" = {
        "exec" = "~/.config/waybar/scripts/utility/uptime.sh";
        "format" = "  ";
        "interval" = 60;
        "on-click" = "~/.config/waybar/scripts/launcher/launcher-left.sh";
        "on-click-right" = "~/.config/waybar/scripts/launcher/launcher-right.sh";
        "return-type" = "json";
        "tooltip" = true;
      };

      "custom/lock" = {
        "format" = "  ";
        "on-click" = "~/.config/hypr/scripts/hyprlock.sh";
        "tooltip" = false;
      };

      "custom/shutdown" = {
        "format" = "  ";
        "on-click" = "~/.config/waybar/scripts/utility/shutdown.sh";
        "tooltip" = false;
      };

      "custom/reboot" = {
        "format" = "  ";
        "on-click" = "~/.config/waybar/scripts/utility/reboot.sh";
        "tooltip" = false;
      };

      # resource monitor
      "group/task" = {
        "orientation" = "inherit";
        "modules" = [
          "cpu"
          "custom/cputemp"
          "custom/gpu"
          "custom/gputemp"
          "custom/memory"
        ];
      };

      "cpu" = {
        "interval" = 5;
        "format" = "  {usage}% ";
        "max-length" = 15;
        "on-click" = "kitty -T btop btop";
      };

      "custom/cputemp" = {
        "exec" = "~/.config/waybar/scripts/temp/cputemp.sh";
        "format" = "{}°C ";
        "interval" = 5;
        "on-click" = "kitty -T btop btop";
        "return-type" = "json";
        "tooltip" = true;
      };

      "custom/gpu" = {
        "exec" = "cat $(fd gpu_busy_percent /sys/class/hwmon/hwmon*/device/)";
        "interval" = 5;
        "format" = "  {}% ";
        "max-length" = 15;
        "on-click" = "kitty -T btop btop";
        "tooltip" = false;
      };

      "custom/gputemp" = {
        "exec" = "~/.config/waybar/scripts/temp/gputemp.sh";
        "format" = "{}°C ";
        "interval" = 5;
        "on-click" = "kitty -T btop btop";
        "return-type" = "json";
        "tooltip" = true;
      };

      "custom/memory" = {
        "interval" = 5;
        "format" = "  {} ";
        "on-click" = "kitty -T btop btop";
        "return-type" = "json";
        "exec" = "~/.config/waybar/scripts/utility/memhog.sh";
      };

      # weather
      "custom/weather" = {
        "format" = "{}";
        "tooltip" = true;
        "interval" = 3600;
        "exec" = "~/.config/waybar/scripts/utility/wttr.sh";
        "return-type" = "json";
      };

      # workspace button
      "hyprland/workspaces" = {
        "active-only" = false;
        "all-outputs" = true;
        "format" = "{icon}";
        "show-special" = false;
        "on-click" = "activate";
        "on-scroll-up" = "hyprctl dispatch workspace e+1";
        "on-scroll-down" = "hyprctl dispatch workspace e-1";
        "persistent-workspaces" = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
          "6" = [];
        };
        "format-icons" = {
          "1" = "一";
          "2" = "二";
          "3" = "三";
          "4" = "四";
          "5" = "五";
          "6" = "六";
        };
      };

      #window title
      "hyprland/window" = {
        "format" = "{}";
        "max-length" = length;
        # "separate-outputs"= true;
        "icon" = true;
        "icon-size" = 16;
        "on-click" = "~/.config/hypr/scripts/quit.sh";
        "on-click-right" = "hyprctl dispatch setprop active opaque toggle";
        "on-click-middle" = "hyprctl dispatch togglespecialworkspace anonymous";
        "on-scroll-up" = "hyprctl dispatch togglespecialworkspace gamespace";
        "on-scroll-down" = "hyprctl dispatch togglespecialworkspace scratchpad";
        "swap-icon-label" = false;
        "tooltip" = false;
      };

      # tray modules
      "group/customtray" = {
        "orientation" = "inherit";
        "modules" = [
          "custom/stoprec"
          "custom/xdm"
          "privacy"
          "tray"
        ];
      };

      "custom/stoprec" = {
        "format" = "{}";
        "return-type" = "json";
        "exec" = "~/.config/waybar/scripts/screenrecord/tray.sh";
        "on-click" = "~/.config/waybar/scripts/screenrecord/stoprec.sh";
        "signal" = 11;
      };

      "custom/xdm" = {
        "exec" = "pgrep -x xdm >/dev/null && echo '{\"text\": \"󰃘\"}'";
        "format" = "<span color='#DEDEDE'>{}</span>";
        "on-click" = "~/.config/waybar/scripts/utility/xdm.sh";
        "on-click-right" = "pkill xdm & ~/.config/waybar/scripts/utility/tray-trigger.sh xdm";
        "return-type" = "json";
        "signal" = 15;
        "tooltip" = false;
      };

      "privacy" = {
        "icon-spacing" = 14;
        "icon-size" = 14;
        "transition-duration" = 250;
        "modules" = [
          {
            "type" = "screenshare";
            "tooltip" = true;
            "tooltip-icon-size" = 24;
          }
          {
            "type" = "audio-in";
            "tooltip" = true;
            "tooltip-icon-size" = 24;
          }
        ];
      };

      "tray" = {
        "icon-size" = 14;
        "spacing" = 14;
        "reverse-direction" = true;
      };

      # utility
      "group/utility" = {
        "orientation" = "inherit";
        "modules" = [
          "group/screenshot"
          "custom/virtualkeyboard"
          "custom/magnifier"
          "custom/lamp"
        ];
      };

      "group/screenshot" = {
        "orientation" = "inherit";
        "drawer" = {
          "transition-duration" = 500;
          "transition-left-to-right" = false;
        };
        "modules" = [
          "custom/ssmonitor"
          "custom/hyprpicker"
          "custom/ocr"
          "custom/ssarea"
          "custom/sswindow"
        ];
      };

      "custom/hyprpicker" = {
        "format" = "  ";
        "on-click" = "~/.config/waybar/scripts/utility/hyprpicker.sh";
        "tooltip" = false;
      };

      "custom/ocr" = {
        "format" = " 󱄽 ";
        "on-click" = "~/.config/waybar/scripts/screenshot/ocr.sh";
        "tooltip" = false;
      };

      "custom/sswindow" = {
        "format" = " 󰘔 ";
        "on-click" = "~/.config/waybar/scripts/screenshot/sswindow.sh";
        "on-click-right" = "~/.config/waybar/scripts/screenrecord/recwindow.sh";
        "tooltip" = false;
      };

      "custom/ssarea" = {
        "format" = "  ";
        "on-click" = "~/.config/waybar/scripts/screenshot/ssarea.sh";
        "on-click-right" = "~/.config/waybar/scripts/screenrecord/recarea.sh";
        "tooltip" = false;
      };

      "custom/ssmonitor" = {
        "format" = " 󰹑 ";
        "on-click" = "~/.config/waybar/scripts/screenshot/ssmonitor.sh";
        "on-click-right" = "~/.config/waybar/scripts/screenrecord/recmonitor.sh";
        "tooltip" = false;
      };

      "custom/virtualkeyboard" = {
        "format" = "  ";
        "on-click" = "~/.config/waybar/scripts/utility/virtualkeyboard.sh";
        "on-click-right" = "pgrep sysboard | xargs kill && notify-send 'Virtual Keyboard' 'Off' -i keyboard";
        "tooltip" = false;
      };

      "custom/magnifier" = {
        "format" = " 󱈅 ";
        "on-scroll-up" = "current=$(hyprctl getoption cursor:zoom_factor | head -n 1 | awk '{print $2}') && hyprctl keyword cursor:zoom_factor $(echo \"$current + 0.5\" | bc)";
        "on-scroll-down" = "current=$(hyprctl getoption cursor:zoom_factor | head -n 1 | awk '{print $2}') && hyprctl keyword cursor:zoom_factor $(echo \"$current - 0.5\" | bc)";
        "on-click-right" = "hyprctl keyword cursor:zoom_factor 1";
        "on-click" = "hyprctl keyword cursor:zoom_factor 2";
        "tooltip" = false;
      };

      "custom/lamp" = {
        "format" = "{icon} ";
        "format-icons" = ["󰹐" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
        "exec" = "~/.config/waybar/scripts/utility/lamp-control.sh";
        "on-click" = "echo 'on' > ~/.cache/${hosts.username}/lamp-control";
        "on-click-middle" = "echo 'toggle' > ~/.cache/${hosts.username}/lamp-control";
        "on-click-right" = "echo 'off' > ~/.cache/${hosts.username}/lamp-control";
        "on-scroll-down" = "echo '-' > ~/.cache/${hosts.username}/lamp-control";
        "on-scroll-up" = "echo '+' > ~/.cache/${hosts.username}/lamp-control";
        "return-type" = "json";
        "tooltip" = false;
      };

      # quick control
      "group/monitor" = {
        "orientation" = "inherit";
        "modules" = [
          "custom/ddcutil"
          "custom/hyprsunset"
          "pulseaudio"
          "custom/mic"
          "network"
        ];
      };

      "custom/ddcutil" = {
        "format" = " {icon}{percentage}% ";
        "format-icons" = [" " " " " " " " " " " " " " " " " "];
        "exec" = "bash -c '~/.config/waybar/scripts/utility/ddcutil.sh'";
        "return-type" = "json";
        "on-scroll-up" = "echo '+' > ~/.cache/${hosts.username}/ddcutil";
        "on-scroll-down" = "echo '-' > ~/.cache/${hosts.username}/ddcutil";
        "on-click" = "echo 'max' > ~/.cache/${hosts.username}/ddcutil";
        "on-click-right" = "echo 'min' > ~/.cache/${hosts.username}/ddcutil";
        "tooltip" = false;
      };

      "custom/hyprsunset" = {
        "format" = "{} ";
        "exec" = "cat ~/.cache/${hosts.username}/hyprsunset-icon";
        "on-click" = "~/.config/waybar/scripts/hyprsunset/hyprsunset.sh";
        "on-scroll-up" = "~/.config/waybar/scripts/hyprsunset/scroll-up.sh";
        "on-scroll-down" = "~/.config/waybar/scripts/hyprsunset/scroll-down.sh";
        "signal" = 12;
        "tooltip" = false;
      };

      "pulseaudio" = {
        "format" = " {icon}{volume}%";
        "max-volume" = 150;
        "format-icons" = {
          #main speaker
          "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3" = [" " " " " "];
          "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3-muted" = " ";
          #front jack
          "alsa_output.pci-0000_08_00.6.analog-stereo" = "󰋋 ";
          "alsa_output.pci-0000_08_00.6.analog-stereo-muted" = "󰟎 ";
          #bluetooth
          "bluez_output.00_A4_1C_F9_15_84.1" = "󰂰 ";
          "bluez_output.00_A4_1C_F9_15_84.1-muted" = "󰂲 ";
        };
        "on-click" = "pavucontrol";
        "on-click-right" = "~/.config/waybar/scripts/pavucontrol/cycle-output.sh";
        "on-click-middle" = "~/.config/waybar/scripts/pavucontrol/toggle-output.sh";
        "scroll-step" = 5;
        "smooth-scrolling-threshold" = 2;
        "tooltip" = false;
        "signal" = 13;
      };

      "custom/mic" = {
        "format" = " {} ";
        "exec" = "~/.config/waybar/scripts/pavucontrol/mic-status.sh";
        "on-click" = "pavucontrol";
        "on-click-right" = "~/.config/waybar/scripts/pavucontrol/cycle-input.sh";
        "on-click-middle" = "~/.config/waybar/scripts/pavucontrol/toggle-input.sh";
        "return-type" = "json";
        "signal" = 14;
        "tooltip" = false;
      };

      "network" = {
        "format-wifi" = " 󰖩 {signalStrength}%";
        "format-ethernet" = "  ";
        "on-click" = "kitty -T nmtui nmtui";
        "format-disconnected" = " Disconnected  ";
        "tooltip" = false;
      };

      # clock and date
      "clock" = {
        "interval" = 1;
        "format" = "<span color='${base08}'>  </span>{:%H:%M:%S} ";
        "format-alt" = "<span color='${base08}'>  </span>{:%a %d/%b/%y} ";
        "tooltip-format" = "\n<span size='12pt'>{calendar}</span>";
        "calendar" = {
          "mode" = "year";
          "mode-mon-col" = 3;
          "weeks-pos" = "right";
          "on-scroll" = 1;
          "format" = {
            "months" = "<span color='${base0A}'>{}</span>";
            "days" = "<span color='${base07}'>{}</span>";
            "weeks" = "<span color='${base0D}'>W{}</span>";
            "weekdays" = "<span color='${base0B}'>{}</span>";
            "today" = "<span color='${base08}'><b><u>{}</u></b></span>";
          };
        };
        "actions" = {
          "on-scroll-up" = "shift_up";
          "on-scroll-down" = "shift_down";
        };
        "smooth-scrolling-threshold" = 5;
      };

      # notification-icon
      "custom/notification" = {
        "format" = " {} ";
        "exec" = "cat ~/.cache/${hosts.username}/notification-icon";
        "on-click" = "~/.config/waybar/scripts/dunst/dunsticon.sh";
        "on-click-right" = "~/.config/waybar/scripts/dunst/history.sh";
        "on-click-middle" = "dunstctl close-all";
        "signal" = 10;
        "tooltip" = false;
      };

      # "backlight" = {
      #   "device" = "DP-3";
      #   "format" = "{icon} {percent}%";
      #   "format-icons" = ["" "" "" "" "" "" "" "" ""];
      # };

      # "battery" = {
      #   "bat" = "BAT0";
      #   "adapter" = "ADP0";
      #   "interval" = 60;
      #   "states" = {
      #     "warning" = 30;
      #     "critical" = 15;
      #   };
      #   "max-length" = 20;
      #   "format" = "{icon} {capacity}%";
      #   "format-warning" = "{icon} {capacity}%";
      #   "format-critical" = "{icon} {capacity}%";
      #   "format-charging" = "<span font-family='Font Awesome 6 Free'></span> {capacity}%";
      #   "format-plugged" = "  {capacity}%";
      #   "format-alt" = "{icon} {time}";
      #   "format-full" = "  {capacity}%";
      #   "format-icons" = [" " " " " " " " " "];
      # };
    };
  };
}
