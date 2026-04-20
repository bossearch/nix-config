{
  homes,
  hosts,
  mylib,
  pkgs,
  ...
}: let
  hide = "swaync-client -cp -sw &&";
  layer = pkgs.writeShellScript "swaync-layer" ''
    while hyprctl layers | grep -q "namespace: swaync-control-center"; do
        sleep 0.1
    done
  '';
  volume = "--volume=$(cat ~/.cache/${hosts.username}/notify-volume)";
in {
  imports = mylib.autoimport ./.;

  services.swaync = {
    enable = homes.notify == "swaync";
    settings = {
      "$schema" = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";
      control-center-margin-bottom = 8;
      control-center-margin-left = 8;
      control-center-margin-right = 8;
      control-center-margin-top = 8;
      control-center-width = 512;

      cssPriority = "user";
      fit-to-screen = true;

      hide-on-action = true;
      hide-on-clear = false;
      image-visibility = "always";
      keyboard-shortcuts = true;

      notification-2fa-action = true;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-grouping = true;
      notification-inline-replies = true;
      notification-window-width = 452;

      positionX = "right";
      positionY = "top";
      text-empty = "No Notifications";

      timeout = 3;
      timeout-critical = 4;
      timeout-low = 2;
      transition-time = 200;

      script-fail-notify = true;
      scripts = {
        _game_off = {
          exec = "paplay ~/.config/assets/sounds/Mario-power-down.mp3 ${volume}";
          app-name = "game_off";
        };
        _game_on = {
          exec = "paplay ~/.config/assets/sounds/Mario-power-up.mp3 ${volume}";
          urgency = "Normal";
          app-name = "game_on";
        };
        _nchat = {
          exec = "paplay ~/.config/assets/sounds/Livechat.mp3 ${volume}";
          app-name = "nchat";
        };
        _playerctl = {
          exec = "paplay ~/.config/assets/sounds/Hello.mp3 ${volume}";
          app-name = "playerctl";
        };
        _screenrecord = {
          exec = "sleep 2 && paplay ~/.config/assets/sounds/clapper-board.mp3 ${volume}";
          app-name = "screenrecord";
        };
        _screenshot = {
          exec = "paplay ~/.config/assets/sounds/camera-shutter.mp3 ${volume}";
          app-name = "screenshot";
        };
        critical = {
          exec = "paplay ~/.config/assets/sounds/Sonar.mp3 ${volume}";
          urgency = "Critical";
          app-name = ".*";
        };
        low = {
          exec = "paplay ~/.config/assets/sounds/Chord.mp3 ${volume}";
          urgency = "Low";
          app-name = ".*";
        };
        normal = {
          exec = "paplay ~/.config/assets/sounds/Chord.mp3 ${volume}";
          urgency = "Normal";
          app-name = ".*";
        };
      };
      widget-config = {
        buttons-grid = {
          buttons-per-row = 6;
          actions = [
            {
              label = "";
              type = "toggle";
              command = "${hide} ~/.config/waybar/scripts/utility/virtualkeyboard.sh";
              update-command = "pgrep sysboard > /dev/null && echo true || echo false";
              active = false;
            }
            {
              label = "";
              command = "${hide} notify-send -e \"Oops\" \"This button\'s isn\'t configured yet\"";
            }
            {
              label = "";
              command = "${hide} notify-send -e \"Oops\" \"This button\'s isn\'t configured yet\"";
            }
            {
              label = "";
              command = "${hide} ${layer} && ~/.config/hypr/scripts/hyprlock.sh";
            }
            {
              label = "";
              command = "${hide} ~/.config/waybar/scripts/launcher/reboot.sh";
            }
            {
              label = "";
              command = "${hide} ~/.config/waybar/scripts/launcher/shutdown.sh";
            }
          ];
        };
        dnd = {
          text = "Do Not Disturb";
        };
        menubar = {
          "buttons#utility" = {
            position = "left";
            actions = [
              {
                label = "󱈅";
                type = "toggle";
                command = "${hide} ~/.config/waybar/scripts/utility/magnifier.sh";
                update-command = "bash -c 'if hyprctl getoption cursor:zoom_factor | grep -q \"1.000000\"; then echo false; else echo true; fi'";
                active = false;
              }
              {
                label = "";
                command = "${hide} ~/.config/waybar/scripts/utility/hyprpicker.sh";
              }
              {
                label = "󱄽";
                command = "${hide} ~/.config/waybar/scripts/utility/ocr.sh";
              }
            ];
          };
          "menu#0screenshot" = {
            label = "";
            position = "left";
            animation-type = "slide_down";
            actions = [
              {
                label = "󰹑";
                command = "${hide} ${layer} && ~/.config/waybar/scripts/utility/screenshot/monitor.sh";
              }
              {
                label = "󰘔";
                command = "${hide} ${layer} && ~/.config/waybar/scripts/utility/screenshot/window.sh";
              }
              {
                label = "";
                command = "${hide} ${layer} && ~/.config/waybar/scripts/utility/screenshot/area.sh";
              }
            ];
          };
          "menu#1screenrecord" = {
            label = "";
            position = "left";
            animation-type = "slide_down";
            actions = [
              {
                label = "󰹑";
                command = "${hide} ~/.config/waybar/scripts/utility/screenrecord/monitor.sh";
              }
              {
                label = "󰘔";
                command = "${hide} ~/.config/waybar/scripts/utility/screenrecord/window.sh";
              }
              {
                label = "";
                command = "${hide} ~/.config/waybar/scripts/utility/screenrecord/area.sh";
              }
            ];
          };
          "menu#2lamp" = {
            label = "󰛨";
            position = "left";
            animation-type = "slide_down";
            actions = [
              {
                label = "State";
                command = "${hide} ~/.config/waybar/scripts/utility/lamp-control/set-lamp.sh state";
              }
              {
                label = "Temp";
                command = "${hide} ~/.config/waybar/scripts/utility/lamp-control/set-lamp.sh temp";
              }
              {
                label = "Cozy";
                command = "${hide} ~/.config/waybar/scripts/utility/lamp-control/set-lamp.sh cozy";
              }
            ];
          };
        };
        mpris = {
          autohide = true;
          show-album-art = "always";
          loop-carousel = true;
        };
        notifications = {
          vexpand = true;
        };
        "slider#lamp" = {
          label = "󰛨";
          min = 0;
          max = 100;
          min_limit = 10;
          max_limit = 100;
          value_scale = 0;
          cmd_getter = "~/.config/waybar/scripts/utility/lamp-control/get-lamp.sh";
          cmd_setter = "~/.config/waybar/scripts/utility/lamp-control/set-lamp.sh $value";
        };
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "󰎟";
        };
        volume = {
          label = "󰕾";
          show-per-app = true;
          show-per-app-icon = true;
          show-per-app-label = false;
          step = 10;
          expand-button-label = "";
          collapse-button-label = "";
        };
      };
      widgets = [
        "buttons-grid"
        "menubar"
        "volume"
        "slider#lamp"
        "mpris"
        "title"
        "notifications"
        "dnd"
      ];
    };
  };
}
