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
      padding: 0 6px;
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
    #custom-xdm,
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
      padding: 0px 4px 0px 0px;
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
      color: @red;
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
    tooltip {
      background: @bg;
      border: 1px solid @fg;
    }
  '';
}
