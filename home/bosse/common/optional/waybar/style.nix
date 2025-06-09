{config, ...}: let
  palette = config.lib.stylix.colors;
in {
  programs.waybar.style = ''
    @define-color bg rgba(${palette.base00-rgb-r}, ${palette.base00-rgb-g}, ${palette.base00-rgb-b}, 0.8);
    @define-color fg rgba(${palette.base01-rgb-r}, ${palette.base01-rgb-g}, ${palette.base01-rgb-b}, 0.8);
    @define-color bblack ${config.lib.stylix.colors.withHashtag.base03};
    @define-color gray ${config.lib.stylix.colors.withHashtag.base04};
    @define-color nwhite ${config.lib.stylix.colors.withHashtag.base06};
    @define-color bwhite ${config.lib.stylix.colors.withHashtag.base07};
    @define-color red ${config.lib.stylix.colors.withHashtag.base08};
    @define-color yellow ${config.lib.stylix.colors.withHashtag.base0A};
    @define-color green ${config.lib.stylix.colors.withHashtag.base0B};
    @define-color cyan ${config.lib.stylix.colors.withHashtag.base0C};
    @define-color blue ${config.lib.stylix.colors.withHashtag.base0D};
    @define-color magenta ${config.lib.stylix.colors.withHashtag.base0E};
    * {
      font-family: CommitMono Nerd Font;
      font-size: 16px;
      border-radius: 8px;
    }

    window#waybar {
      background-color: @bg;
      border-radius: 8px;
    }

    #launcher {
      /*group for launcher*/
      color: @bblack;
      background-color: @fg;
      border-radius: 8px;
      padding: 0px 5px 0px 0px;
    }
    #custom-launcher {
      color: @cyan;
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
      background-color: @fg;
      border-radius: 8px;
      padding: 0 5px;
    }
    #cpu,
    #temperature,
    #custom-cputemp {
      color: @red;
      padding: 0 5px;
    }
    #custom-gpu,
    #temperature.gpu,
    #custom-gputemp {
      color: @yellow;
      padding: 0 5px;
    }
    #custom-memory {
      color: @green;
      padding: 0 5px;
    }

    #custom-weather {
      color: @bwhite;
      background-color: @fg;
      padding: 0 10px;
    }

    #workspaces {
      border-radius: 8px;
      background-color: @fg;
    }

    #workspaces button {
      padding: 0 5px;
      color: @gray;
      background-color: transparent;
    }

    #workspaces button.urgent {
      font-weight: bold;
      color: @yellow;
    }

    #workspaces button.active {
      background: alpha(@active, 0.4);
      color: @nwhite;
      border-radius: 8px;
    }

    #window {
      color: @bwhite;
    }

    #customtray {
      /*group for stoprec and tray*/
      color: @nwhite;
      background-color: @fg;
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
      background-color: @green;
    }

    #utility {
      /*group for screenshot, virtualkeyboard,hyprpicker, and wiz*/
      background-color: @fg;
      color: @bwhite;
      border-radius: 8px;
    }
    #custom-virtualkeyboard {
      padding: 0px 0px 0px 6px;
    }
    #custom-hyprpicker {
      padding: 0px 0px 0px 4px;
    }
    #custom-lamp {
      padding: 0px 0px 0px 8px;
    }

    #monitor {
      /*group for ddcutil, pulseaudio, and internet*/
      background-color: @fg;
      color: @blue;
      border-radius: 8px;
    }

    #network {
      color: @magenta;
      padding: 0 10px;
    }
    #network.disconnected {
      color: #f53c3c;
    }

    #clock {
      color: @bwhite;
      background-color: @fg;
      border-radius: 8px;
      padding: 0 10px;
    }

    #custom-notification {
      color: @bwhite;
      background-color: @fg;
      border-radius: 8px;
      padding: 0px 4.5px 0px 0px;
    }
    .modules-left > widget:first-child > #workspaces {
      margin-left: 0;
    }

    .modules-right > widget:last-child > #workspaces {
      margin-right: 0;
    }
  '';
}
