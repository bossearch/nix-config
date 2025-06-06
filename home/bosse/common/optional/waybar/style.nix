{
  programs.waybar.style = ''
    * {
      font-family: CommitMono Nerd Font;
      font-size: 16px;
      border-radius: 8px;
    }

    window#waybar {
      background-color: rgba(26, 27, 38, 0.8);
      border-radius: 8px;
    }

    #launcher {
      /*group for launcher*/
      color: #414868;
      background-color: rgba(22, 22, 30, 0.8);
      border-radius: 8px;
      padding: 0px 5px 0px 0px;
    }
    #custom-launcher {
      color: #7dcfff;
      padding: 0px 10px 0px 10px;
    }
    #custom-lock {
      padding: 0 10px;
    }
    #custom-shutdown {
      padding: 0px 9px 0px 10px;
    }
    #custom-reboot {
      padding: 0 10px;
    }

    #task {
      /*group for cpu, gpu and memory*/
      background-color: rgba(22, 22, 30, 0.8);
      border-radius: 8px;
      padding: 0 5px;
    }
    #cpu,
    #temperature,
    #custom-cputemp {
      color: #f7768e;
      padding: 0 5px;
    }
    #custom-gpu,
    #temperature.gpu,
    #custom-gputemp {
      color: #e0af68;
      padding: 0 5px;
    }
    #memory {
      color: #9ece6a;
      padding: 0 5px;
    }

    #custom-weather {
      color: #c0caf5;
      background-color: rgba(22, 22, 30, 0.8);
      padding: 0 10px;
    }

    #workspaces {
      border-radius: 8px;
      background-color: rgba(22, 22, 30, 0.8);
    }

    #workspaces button {
      padding: 0 5px;
      color: #7984a4;
      background-color: transparent;
    }

    #workspaces button.urgent {
      font-weight: bold;
      color: #ebcb8b;
    }

    #workspaces button.active {
      background: alpha(@active, 0.4);
      color: #cccccc;
      border-radius: 8px;
    }

    #window {
      color: #c0caf5;
    }

    #customtray {
      /*group for stoprec and tray*/
      color: #ffffff;
      background-color: rgba(22, 22, 30, 0.8);
    }
    #privacy {
      padding: 0px 0px 0px 10px;
    }
    #custom-stoprec {
      padding: 0px 4px 0px 0px;
    }
    #tray {
      padding: 0 10px;
    }
    #tray > .passive {
      -gtk-icon-effect: dim;
    }
    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: #9ece6a;
    }

    #utility {
      /*group for screenshot, virtualkeyboard,hyprpicker, and wiz*/
      background-color: rgba(22, 22, 30, 0.8);
      color: #c0caf5;
      border-radius: 8px;
    }
    #custom-virtualkeyboard {
      padding: 0px 0px 0px 6px;
    }
    #custom-hyprpicker {
      padding: 0px 0px 0px 4px;
    }
    #custom-wiz {
      padding: 0px 0px 0px 8px;
    }

    #monitor {
      /*group for ddcutil, pulseaudio, and internet*/
      background-color: rgba(22, 22, 30, 0.8);
      color: #7aa2f7;
      border-radius: 8px;
    }

    #network {
      color: #bb9af7;
      padding: 0 10px;
    }
    #network.disconnected {
      color: #f53c3c;
    }

    #clock {
      color: #c0caf5;
      background-color: rgba(22, 22, 30, 0.8);
      border-radius: 8px;
      padding: 0 10px;
    }

    #custom-notification {
      color: #c0caf5;
      background-color: rgba(22, 22, 30, 0.8);
      border-radius: 8px;
      padding: 0px 4.5px 0px 0px;
    }
    .modules-left > widget:first-child > #workspaces {
      margin-left: 0;
    }

    .modules-right > widget:last-child > #workspaces {
      margin-right: 0;
    }

    /*
    #backlight {
      color: #8fbcbb;
    }

    #battery {
      color: #c0caf5;
    }

    #battery.charging,
    #battery.full,
    #battery.plugged {
      color: #26a65b;
    }

    @keyframes blink {
      to {
        background-color: rgba(30, 34, 42, 0.5);
        color: #abb2bf;
      }
    }

    #battery.critical:not(.charging) {
      color: #f53c3c;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }

    #disk {
      background-color: #964b00;
    }
    }*/
  '';
}
