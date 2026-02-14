{
  config,
  inputs,
  ...
}: let
  nix-colors = inputs.nix-colors;
  toRGBString = nix-colors.lib.conversions.hexToRGBString ",";
  base00-rgba = "rgba(${toRGBString config.colorScheme.palette.base00},0.7)";
  base01-rgba = "rgba(${toRGBString config.colorScheme.palette.base01},0.5)";
in {
  programs.waybar.style = ''
    @define-color bg ${base00-rgba};
    @define-color fg ${base01-rgba};
    @define-color bblack #${config.colorScheme.palette.base03};
    @define-color gray #${config.colorScheme.palette.base04};
    @define-color nwhite #${config.colorScheme.palette.base05};
    @define-color bwhite #${config.colorScheme.palette.base07};
    @define-color red #${config.colorScheme.palette.base08};
    @define-color yellow #${config.colorScheme.palette.base0A};
    @define-color green #${config.colorScheme.palette.base0B};
    @define-color cyan #${config.colorScheme.palette.base0C};
    @define-color blue #${config.colorScheme.palette.base0D};
    @define-color magenta #${config.colorScheme.palette.base0E};
    * {
      font-family: CommitMono Nerd Font Propo;
      font-size: 16px;
      border-radius: 8px;
    }

    #launcher {
      /*group for launcher*/
      color: @gray;
      background-color: @fg;
    }
    #custom-launcher {
      color: @cyan;
    }

    #task {
      /*group for cpu, gpu and memory*/
      background-color: @fg;
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
      background-color: @fg;
      color: @bwhite;
      padding: 0 10px;
    }

    #workspaces {
      background-color: @fg;
    }
    #workspaces button {
      background-color: transparent;
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
      color: @bwhite;
      border-radius: 8px;
    }

    #window {
      color: @bwhite;
    }
    window#waybar {
      background-color: @bg;
    }

    #customtray {
      /*group for stoprec and tray*/
      color: #FFFFFF;
      background-color: @fg;
    }
    #custom-stoprec {
      padding: 1px 6px 0px 8px;
    }
    #custom-xdm {
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
      background-color: @yellow;
    }

    #utility {
      /*group for screenshot, virtualkeyboard,hyprpicker, and wiz*/
      background-color: @fg;
      color: @bwhite;
    }
    #custom-lamp {
      padding: 0px 0px 0px 6px;
    }


    #monitor {
      /*group for ddcutil, pulseaudio, and internet*/
      background-color: @fg;
      color: @blue;
    }
    #network {
      color: @magenta;
    }
    #network.disconnected {
      color: @red;
    }

    #clock {
      color: @bwhite;
      background-color: @fg;
    }

    #custom-notification {
      color: @bwhite;
      background-color: @fg;
    }

    .modules-left > widget:first-child > #workspaces {
      margin-left: 0;
    }

    .modules-right > widget:last-child > #workspaces {
      margin-right: 0;
    }
    tooltip {
      background: @bg;
      border: 1px solid @fg;
    }
  '';
}
