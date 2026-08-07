{
  config,
  hosts,
  lib,
  ...
}: let
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}";
  base0A = "#${config.colorScheme.palette.base0A}";
  base0B = "#${config.colorScheme.palette.base0B}";
  base0D = "#${config.colorScheme.palette.base0D}";
  resource =
    if hosts.hostname == "silvia"
    then ["custom/cputemp" "custom/gpu" "custom/gputemp"]
    else [];
  control =
    if hosts.hostname == "silvia"
    then ["backlight"]
    else [];
in {
  programs.waybar.settings = {
    mainBar = {
      "custom/launcher" = {
        "exec" = "~/.config/waybar/scripts/launcher/uptime.sh";
        "format" = "  ";
        "interval" = 60;
        "on-click" = "~/.config/waybar/scripts/launcher/launcher-left.sh";
        "on-click-right" = "~/.config/waybar/scripts/launcher/launcher-right.sh";
        "return-type" = "json";
        "tooltip" = true;
      };

      "group/resource" = {
        "orientation" = "inherit";
        "modules" =
          ["cpu"]
          ++ resource
          ++ ["custom/memory"];
      };

      "cpu" = {
        "interval" = 5;
        "format" = "  {usage}% ";
        "max-length" = 15;
        "on-click" = "footclient -T btop btop";
      };

      "custom/cputemp" = {
        "exec" = "~/.config/waybar/scripts/resource/cputemp.sh";
        "format" = "{}° ";
        "interval" = 5;
        "on-click" = "footclient -T btop btop";
        "return-type" = "json";
        "tooltip" = true;
      };

      "custom/gpu" = {
        "exec" = "cat $(fd gpu_busy_percent /sys/class/hwmon/hwmon*/device/)";
        "interval" = 5;
        "format" = "  {}% ";
        "max-length" = 15;
        "on-click" = "footclient -T btop btop";
        "tooltip" = false;
      };

      "custom/gputemp" = {
        "exec" = "~/.config/waybar/scripts/resource/gputemp.sh";
        "format" = "{}° ";
        "interval" = 5;
        "on-click" = "footclient -T btop btop";
        "return-type" = "json";
        "tooltip" = true;
      };

      "custom/memory" = {
        "interval" = 5;
        "format" = "  {}% ";
        "on-click" = "footclient -T btop btop";
        "return-type" = "json";
        "exec" = "~/.config/waybar/scripts/resource/memory.sh";
      };

      # workspace button
      "hyprland/workspaces" = {
        "active-only" = false;
        "all-outputs" = true;
        "format" = "<sub>{icon}</sub> {windows}";
        "format-icons" = {
          "1" = "Y";
          "2" = "U";
          "3" = "I";
          "4" = "O";
          "5" = "P";
          "6" = "N";
          "7" = "M";
          "8" = ",";
          "9" = ".";
          "10" = "/";
        };
        "format-window-separator" = " ";
        "on-click" = "activate";
        "on-scroll-down" = "hyprctl dispatch 'hl.dsp.focus({workspace=\"e-1\"})'";
        "on-scroll-up" = "hyprctl dispatch 'hl.dsp.focus({workspace=\"e+1\"})'";
        "show-special" = false;
        "window-rewrite-default" = "󰖺";
        "window-rewrite" = import ./.rewrite.nix;
      };

      "custom/chevron" = {
        "format" = " ❯ ";
        "tooltip" = false;
      };

      #window title
      "hyprland/window" = {
        "format" = "{}";
        "rewrite" = {
          "(.*) — Mozilla Firefox" = "$1";
        };
        # "separate-outputs"= true;
        "icon" = false;
        "tooltip" = false;
        "on-click" = "~/.config/hypr/scripts/quit.sh";
        "on-scroll-down" = "~/.config/hypr/scripts/cycle.sh prev";
        "on-scroll-up" = "~/.config/hypr/scripts/cycle.sh next";
      };

      # tray modules
      "group/customtray" = {
        "orientation" = "inherit";
        "modules" = [
          "custom/stoprec"
          "custom/hyprsunset"
          "privacy"
          "tray"
          "custom/weather"
        ];
      };

      "custom/stoprec" = {
        "format" = "{}";
        "return-type" = "json";
        "exec" = "~/.config/waybar/scripts/tray/screenrecord-tray.sh";
        "on-click" = "~/.config/waybar/scripts/tray/screenrecord-stop.sh";
        "signal" = 11;
      };

      "custom/hyprsunset" = {
        "format" = "{}";
        "exec" = "cat ~/.cache/${hosts.username}/hyprsunset-icon";
        "signal" = 12;
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

      "custom/weather" = {
        "format" = "{}";
        "tooltip" = true;
        "interval" = 3600;
        "exec" = "~/.config/waybar/scripts/tray/wttr.sh";
        "return-type" = "json";
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
          "custom/monitor"
          "custom/hyprpicker"
          "custom/ocr"
          "custom/area"
          "custom/window"
        ];
      };

      "custom/hyprpicker" = {
        "format" = "  ";
        "on-click" = "~/.config/waybar/scripts/utility/hyprpicker.sh";
        "tooltip" = false;
      };

      "custom/ocr" = {
        "format" = " 󱄽 ";
        "on-click" = "~/.config/waybar/scripts/utility/ocr.sh";
        "tooltip" = false;
      };

      "custom/area" = {
        "format" = "  ";
        "on-click" = "~/.config/waybar/scripts/utility/screenshot/area.sh";
        "on-click-right" = "~/.config/waybar/scripts/utility/screenrecord/area.sh";
        "tooltip" = false;
      };

      "custom/monitor" = {
        "format" = " 󰹑 ";
        "on-click" = "~/.config/waybar/scripts/utility/screenshot/monitor.sh";
        "on-click-right" = "~/.config/waybar/scripts/utility/screenrecord/monitor.sh";
        "tooltip" = false;
      };

      "custom/window" = {
        "format" = " 󰘔 ";
        "on-click" = "~/.config/waybar/scripts/utility/screenshot/window.sh";
        "on-click-right" = "~/.config/waybar/scripts/utility/screenrecord/window.sh";
        "tooltip" = false;
      };

      "custom/virtualkeyboard" = {
        "format" = "  ";
        "on-click" = "~/.config/waybar/scripts/utility/virtualkeyboard.sh";
        "tooltip" = false;
      };

      "custom/magnifier" = {
        "format" = " 󱈅 ";
        "on-scroll-up" = "current=$(hyprctl getoption cursor:zoom_factor | head -n 1 | awk '{print $2}') && hyprctl keyword cursor:zoom_factor $(echo \"$current + 0.5\" | bc)";
        "on-scroll-down" = "current=$(hyprctl getoption cursor:zoom_factor | head -n 1 | awk '{print $2}') && hyprctl keyword cursor:zoom_factor $(echo \"$current - 0.5\" | bc)";
        "on-click" = "~/.config/waybar/scripts/utility/magnifier.sh";
        "tooltip" = false;
      };

      "custom/lamp" = {
        "exec" = "~/.config/waybar/scripts/utility/lamp-control/get-lamp.sh dim";
        "format" = "{icon} ";
        "format-icons" = ["󰹐" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
        "on-click" = "~/.config/waybar/scripts/utility/lamp-control/set-lamp.sh state";
        "on-click-middle" = "~/.config/waybar/scripts/utility/lamp-control/set-lamp.sh temp";
        "on-click-right" = "~/.config/waybar/scripts/utility/lamp-control/set-lamp.sh cozy";
        "on-scroll-down" = "~/.config/waybar/scripts/utility/lamp-control/set-lamp.sh -";
        "on-scroll-up" = "~/.config/waybar/scripts/utility/lamp-control/set-lamp.sh +";
        "return-type" = "json";
        "signal" = 15;
        "tooltip" = false;
      };

      "group/control" = {
        "orientation" = "inherit";
        "modules" =
          control
          ++ [
            "pulseaudio"
            "custom/mic"
            "network"
          ];
      };

      "backlight" = {
        "format" = " {icon}{percent}% ";
        "format-icons" = [" " " " " " " " " " " " " " " " " "];
        "on-scroll-up" = "brightnessctl set +10%";
        "on-scroll-down" = "brightnessctl set 10%-";
        "on-click" = "brightnessctl set 80%";
        "on-click-right" = "brightnessctl set 0%";
        "tooltip" = false;
      };

      "pulseaudio" = {
        "format" = " {icon}{volume}% ";
        "max-volume" = 150;
        "format-icons" = lib.mkMerge [
          (lib.mkIf (hosts.hostname == "silvia")
            {
              #main speaker
              "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra1" = [" " " " " "];
              "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra1-muted" = " ";
              #front jack
              "alsa_output.pci-0000_08_00.6.analog-stereo" = "󰋋 ";
              "alsa_output.pci-0000_08_00.6.analog-stereo-muted" = "󰟎 ";
              #bluetooth
              "bluez_output.00_A4_1C_F9_15_84.1" = "󰂰 ";
              "bluez_output.00_A4_1C_F9_15_84.1-muted" = "󰂲 ";
            })
          (lib.mkIf (hosts.hostname == "stagea")
            {
              "alsa_output.pci-0000_00_1b.0.analog-stereo" = [" " " " " "];
              "alsa_output.pci-0000_00_1b.0.analog-stereo-muted" = " ";
            })
        ];
        "on-click" = "pavucontrol";
        "on-click-right" = "~/.config/waybar/scripts/control/output/cycle-output.sh";
        "on-click-middle" = "~/.config/waybar/scripts/control/output/toggle-output.sh";
        "scroll-step" = 5;
        "smooth-scrolling-threshold" = 2;
        "tooltip" = false;
        "signal" = 13;
      };

      "custom/mic" = {
        "format" = " {} ";
        "exec" = "~/.config/waybar/scripts/control/input/mic-status.sh";
        "on-click" = "pavucontrol";
        "on-click-right" = "~/.config/waybar/scripts/control/input/cycle-input.sh";
        "on-click-middle" = "~/.config/waybar/scripts/control/input/toggle-input.sh";
        "on-scroll-up" = "pactl set-source-volume @DEFAULT_SOURCE@ +5% && pkill -RTMIN+14 waybar";
        "on-scroll-down" = "pactl set-source-volume @DEFAULT_SOURCE@ -5% && pkill -RTMIN+14 waybar";
        "return-type" = "json";
        "smooth-scrolling-threshold" = 2;
        "tooltip" = false;
        "signal" = 14;
      };

      "network" = {
        "format-wifi" = " 󰖩 {signalStrength}% ";
        "format-ethernet" = "  ";
        "on-click" = "footclient -T nmtui bash -c 'sleep 0.1 && nmtui'";
        "format-disconnected" = " Disconnected  ";
        "tooltip" = false;
      };

      "clock" = {
        "interval" = 1;
        "format" = "<small><b> {0:%a, %d/%b/%y} \n    {0:%H:%M:%S}</b></small>";
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

      "custom/notify" = {
        "format" = " {} ";
        "exec" = "cat ~/.cache/${hosts.username}/notify-icon";
        "on-click" = ".config/waybar/scripts/notify/notify-icon.sh";
        "on-click-right" = "~/.config/waybar/scripts/notify/notify-history.sh";
        "signal" = 10;
        "tooltip" = false;
      };
    };
  };
}
