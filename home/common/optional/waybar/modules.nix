{config, ...}: let
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}";
  base0A = "#${config.colorScheme.palette.base0A}";
  base0B = "#${config.colorScheme.palette.base0B}";
  base0D = "#${config.colorScheme.palette.base0D}";
in {
  programs.waybar.settings = {
    mainBar = {
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

      "hyprland/window" = {
        "format" = "{}";
        "max-length" = 120;
        # "separate-outputs"= true;
        "icon" = true;
        "icon-size" = 16;
        "on-click" = "~/.config/hypr/scripts/quit.sh";
        "on-click-right" = "hyprctl dispatch setprop active opaque toggle";
        "on-click-middle" = "hyprctl dispatch togglespecialworkspace anonymous";
        "on-scroll-up" = "hyprctl dispatch togglespecialworkspace gamespace";
        "on-scroll-down" = "hyprctl dispatch togglespecialworkspace scratchpad";
        "tooltip" = false;
      };

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

      "group/utility" = {
        "orientation" = "inherit";
        "modules" = [
          "group/screenshot"
          "custom/virtualkeyboard"
          "custom/magnifier"
          "custom/hyprpicker"
          "custom/lamp"
        ];
      };

      "group/customtray" = {
        "orientation" = "inherit";
        "modules" = [
          "privacy"
          "custom/stoprec"
          "tray"
        ];
      };

      "group/screenshot" = {
        "orientation" = "inherit";
        "drawer" = {
          "transition-duration" = 500;
          "transition-left-to-right" = true;
        };
        "modules" = [
          "custom/ssmonitor"
          "custom/sswindow"
          "custom/ssarea"
          "custom/ocr"
        ];
      };

      "group/launcher" = {
        "orientation" = "inherit";
        "drawer" = {
          "transition-duration" = 500;
          "transition-right-to-left" = false;
        };
        "modules" = [
          "custom/launcher"
          "custom/lock"
          "custom/shutdown"
          "custom/reboot"
        ];
      };

      "tray" = {
        "icon-size" = 14;
        "spacing" = 8;
        "reverse-direction" = true;
      };

      "privacy" = {
        "icon-spacing" = 8;
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

      "custom/launcher" = {
        "format" = "";
        "on-click" = "~/.config/waybar/scripts/launcher/launcher-left.sh";
        "on-click-right" = "~/.config/waybar/scripts/launcher/launcher-right.sh";
        "on-click-middle" = "~/.config/hypr/scripts/quit.sh";
        "tooltip" = false;
      };

      "custom/lock" = {
        "format" = "";
        "on-click" = "~/.config/hypr/scripts/hyprlock.sh";
        "tooltip" = false;
      };

      "custom/shutdown" = {
        "format" = "";
        "on-click" = "~/.config/waybar/scripts/utility/shutdown.sh";
        "tooltip" = false;
      };

      "custom/reboot" = {
        "format" = "";
        "on-click" = "~/.config/waybar/scripts/utility/reboot.sh";
        "tooltip" = false;
      };

      "cpu" = {
        "interval" = 5;
        "format" = " {usage}%";
        "max-length" = 15;
        "on-click" = "kitty -T btop btop";
      };

      "custom/cputemp" = {
        "exec" = "echo $(cat $(for i in /sys/class/hwmon/hwmon*/temp3_input; do name=$(cat $(dirname \"$i\")/name 2>/dev/null); [ \"$name\" = \"k10temp\" ] && echo \"$i\" && break; done) | awk '{printf \"%d\", $1/1000}')";
        "interval" = 5;
        "format" = "{}°C";
        "on-click" = "kitty -T btop btop";
        "tooltip" = false;
      };

      "custom/gpu" = {
        "exec" = "cat $(fd gpu_busy_percent /sys/class/hwmon/hwmon*/device/)";
        "interval" = 5;
        "format" = " {}%";
        "max-length" = 15;
        "on-click" = "kitty -T btop btop";
        "tooltip" = false;
      };

      "custom/gputemp" = {
        "exec" = "echo $(cat $(for i in /sys/class/hwmon/hwmon*/temp1_input; do name=$(cat $(dirname \"$i\")/name 2>/dev/null); [ \"$name\" = \"amdgpu\" ] && echo \"$i\" && break; done) | awk '{printf \"%d\", $1/1000}')";
        "interval" = 5;
        "format" = "{}°C";
        "on-click" = "kitty -T btop btop";
        "tooltip" = false;
      };

      "custom/memory" = {
        "interval" = 5;
        "format" = " {}";
        "on-click" = "kitty -T btop btop";
        "return-type" = "json";
        "exec" = "~/.config/waybar/scripts/utility/memhog.sh";
      };

      "backlight" = {
        "device" = "DP-3";
        "format" = "{icon} {percent}%";
        "format-icons" = ["" "" "" "" "" "" "" "" ""];
      };

      "custom/ddcutil" = {
        "format" = " {icon}{percentage}% ";
        "format-icons" = [" " " " " " " " " " " " " " " " " "];
        "exec" = "~/.config/waybar/scripts/utility/ddcutil.sh";
        "return-type" = "json";
        "on-scroll-up" = "echo '+' > /tmp/waybar-ddc-module-rx";
        "on-scroll-down" = "echo '-' > /tmp/waybar-ddc-module-rx";
        "on-click" = "echo 'max' > /tmp/waybar-ddc-module-rx";
        "on-click-right" = "echo 'min' > /tmp/waybar-ddc-module-rx";
        "tooltip" = false;
      };

      "custom/hyprsunset" = {
        "format" = "{}";
        "exec" = "cat ~/.cache/bosse/hyprsunset-icon";
        "on-click" = "~/.config/waybar/scripts/hyprsunset/hyprsunset.sh";
        "on-scroll-up" = "~/.config/waybar/scripts/hyprsunset/scroll-up.sh";
        "on-scroll-down" = "~/.config/waybar/scripts/hyprsunset/scroll-down.sh";
        "signal" = 12;
        "tooltip" = false;
      };
      "network" = {
        "format-wifi" = "󰖩 {signalStrength}%";
        "format-ethernet" = " ";
        "on-click" = "kitty -T nmtui nmtui";
        "format-disconnected" = "Disconnected  ";
        "tooltip" = false;
      };

      "pulseaudio" = {
        "format" = "{icon}{volume}%";
        "max-volume" = 150;
        "format-icons" = {
          "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3" = [" " " " "  "];
          "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3-muted" = "  ";
          "alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo" = "󰋋 ";
          "alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo-muted" = "󰟎 ";
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
        "format" = "{}";
        "exec" = "~/.config/waybar/scripts/pavucontrol/mic-status.sh";
        "on-click" = "pavucontrol";
        "on-click-right" = "~/.config/waybar/scripts/pavucontrol/cycle-input.sh";
        "on-click-middle" = "~/.config/waybar/scripts/pavucontrol/toggle-input.sh";
        "return-type" = "json";
        "interval" = 10;
        "signal" = 14;
        "tooltip" = false;
      };

      "battery" = {
        "bat" = "BAT0";
        "adapter" = "ADP0";
        "interval" = 60;
        "states" = {
          "warning" = 30;
          "critical" = 15;
        };
        "max-length" = 20;
        "format" = "{icon} {capacity}%";
        "format-warning" = "{icon} {capacity}%";
        "format-critical" = "{icon} {capacity}%";
        "format-charging" = "<span font-family='Font Awesome 6 Free'></span> {capacity}%";
        "format-plugged" = "  {capacity}%";
        "format-alt" = "{icon} {time}";
        "format-full" = "  {capacity}%";
        "format-icons" = [" " " " " " " " " "];
      };

      "custom/weather" = {
        "format" = "{}";
        "tooltip" = true;
        "interval" = 3600;
        "exec" = "python3 ~/.config/waybar/scripts/utility/wttr.py";
        "return-type" = "json";
      };

      "custom/virtualkeyboard" = {
        "format" = " ";
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

      "custom/hyprpicker" = {
        "format" = "";
        "on-click" = "hyprpicker -a";
        "tooltip" = false;
      };

      "custom/lamp" = {
        "format" = "{icon} ";
        "format-icons" = ["󰌶" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
        "return-type" = "json";
        "exec" = "python3 ~/.config/waybar/scripts/lamp-control/get-brightness.py | { read x; echo '{\"percentage\":'''\${x}'}'; }";
        "on-scroll-up" = "~/.config/waybar/scripts/lamp-control/increase-brightness.sh";
        "on-scroll-down" = "~/.config/waybar/scripts/lamp-control/decrease-brightness.sh";
        "on-click" = "~/.config/waybar/scripts/lamp-control/turn-on.sh";
        "on-click-right" = "~/.config/waybar/scripts/lamp-control/turn-off.sh";
        "on-click-middle" = "~/.config/waybar/scripts/lamp-control/toggle-temp.sh";
        "signal" = 15;
        "tooltip" = false;
      };

      "custom/ssmonitor" = {
        "format" = " 󰹑 ";
        "on-click" = "~/.config/waybar/scripts/screenshot/ssmonitor.sh";
        "on-click-right" = "~/.config/waybar/scripts/screenrecord/recmonitor.sh";
        "tooltip" = false;
      };

      "custom/sswindow" = {
        "format" = "  ";
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

      "custom/stoprec" = {
        "format" = " {}";
        "return-type" = "json";
        "exec" = "~/.config/waybar/scripts/screenrecord/checkrec.sh";
        "on-click" = "~/.config/waybar/scripts/screenrecord/stoprec.sh";
        "signal" = 11;
      };

      "custom/ocr" = {
        "format" = " 󱄽 ";
        "on-click" = "~/.config/waybar/scripts/screenshot/ocr.sh";
        "tooltip" = false;
      };

      "custom/tor" = {
        "format" = "{}";
        "exec" = "~/.config/waybar/scripts/tor/tor-status.sh";
        "on-click" = "~/.config/waybar/scripts/tor/tor-toggle.sh";
        "return-type" = "json";
        "signal" = 11;
        "tooltip" = false;
      };

      "clock" = {
        "interval" = 1;
        "format" = "<span color='${base08}'> </span>{:%H:%M:%S}";
        "format-alt" = "<span color='${base08}'> </span>{:%a %d/%b/%y}";
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

      "custom/notification" = {
        "format" = " {} ";
        "exec" = "cat ~/.cache/bosse/notification-icon";
        "on-click" = "~/.config/waybar/scripts/dunst/dunsticon.sh";
        "signal" = 10;
        "tooltip" = false;
      };
    };
  };
}
