{
  config,
  homes,
  ...
}: {
  programs.waybar.style = ''
    @define-color bg #${config.colorScheme.palette.base01};
    @define-color fg #${config.colorScheme.palette.base00};
    @define-color bblack #${config.colorScheme.palette.base03};
    @define-color gray #${config.colorScheme.palette.base04};
    @define-color white #${config.colorScheme.palette.base07};
    @define-color red #${config.colorScheme.palette.base08};
    @define-color yellow #${config.colorScheme.palette.base0A};
    @define-color green #${config.colorScheme.palette.base0B};
    @define-color cyan #${config.colorScheme.palette.base0C};
    @define-color blue #${config.colorScheme.palette.base0D};
    @define-color magenta #${config.colorScheme.palette.base0E};
    * {
      font-family: ${homes.nerdfont} Nerd Font Propo;
      font-size: 16px;
      border-radius: 8px;
    }

    #launcher {
      /*group for launcher*/
      color: @gray;
      background: alpha(@fg, 0.7);
    }
    #custom-launcher,
    #custom-chevron {
      color: @cyan;
    }

    #resource {
      /*group for cpu, gpu and memory*/
      background: alpha(@fg, 0.7);
    }
    #cpu,
    #custom-cputemp {
      color: @red;
    }
    #custom-gpu,
    #custom-gputemp {
      color: @yellow;
    }
    #custom-memory {
      color: @green;
    }

    #custom-weather {
      color: #DFDFDF;
      padding: 0px 10px 0px 0px;
    }

    #workspaces {
      background: alpha(@fg, 0.7);
    }
    #workspaces button {
      background: transparent;
      color: @gray;
      padding: 0 6px;
    }
    #workspaces button.empty {
      color: @bblack;
    }
    /* #workspaces button.visible { */
    /*   color: @blue; */
    /* } */
    #workspaces button.urgent {
      font-weight: bold;
      color: @yellow;
    }
    #workspaces button.active {
      color: @white;
      border-radius: 8px;
    }

    #window {
      color: #DFDFDF;
      padding: 2px 0px 0px 0px;
    }
    window#waybar {
      background: alpha(@bg, 0.5);
    }

    #customtray {
      /*group for stoprec and tray*/
      color: #DFDFDF;
    }
    #custom-stoprec {
      padding: 1px 6px 0px 8px;
    }
    #privacy {
      padding: 0px 6px 0px 8px;
    }
    #tray {
      padding: 0px 8px 0px 8px;
    }
    #tray > .passive {
      -gtk-icon-effect: dim;
    }
    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background: @yellow;
    }

    #utility {
      /*group for screenshot, virtualkeyboard,hyprpicker, and wiz*/
      background: alpha(@fg, 0.7);
      color: @white;
    }
    #custom-lamp {
      padding: 0px 0px 0px 6px;
    }


    #control {
      /*group for ddcutil, pulseaudio, and internet*/
      background: alpha(@fg, 0.7);
      color: @blue;
    }
    #network {
      color: @magenta;
    }
    #network.disconnected {
      color: @red;
    }

    #clock {
      color: @white;
      background: alpha(@fg, 0.7);
    }

    #custom-notify {
      color: @white;
      background: alpha(@fg, 0.7);
    }

    .modules-left > widget:first-child > #workspaces {
      margin-left: 0;
    }

    .modules-right > widget:last-child > #workspaces {
      margin-right: 0;
    }
    tooltip {
      background: alpha(@bg, 0.5);
      border: 2px solid alpha(@fg, 0.7);
      color: #DFDFDF;
    }
  '';
}
