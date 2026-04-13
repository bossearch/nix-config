{config, ...}: let
in {
  services.swaync.style = ''
    @define-color bg #${config.colorScheme.palette.base01};
    @define-color fg #${config.colorScheme.palette.base00};
    @define-color gray #${config.colorScheme.palette.base04};
    @define-color white #${config.colorScheme.palette.base05};
    @define-color bwhite #${config.colorScheme.palette.base07};
    @define-color red #${config.colorScheme.palette.base08};
    @define-color blue #${config.colorScheme.palette.base0D};

    * {
      font-family: "CommitMono Nerd Font Propo";
      font-size: 16px;
      border-radius: 8px;
    }

    /* --- Control Center --- */
    .control-center {
      background: alpha(@bg, 0.5);
      border: 2px solid alpha(@fg, 0.7);
    }

    /* --- Hide Control Center Scrollbar --- */
    .control-center scrollbar,
    .control-center scrollbar contents,
    .control-center scrollbar slider,
    .control-center scrollbar slider:hover,
    .control-center scrollbar slider:active,
    .control-center scrollbar trough,
    .control-center .notification-row scrollbar,
    .control-center .notification-row scrollbar thumb,
    .control-center .notification-row scrollbar thumb:hover {
        background: transparent;
        min-width: 1px;
        margin-right: -100px;
    }

    /* --- Notification Window --- */
    .notification {
      background: alpha(@fg, 0.7);
    }

    .notification-action,
    .notification-content,
    .notification-default-action {
      background: none;
    }

    .notification:hover {
      background: alpha(@bg, 0.5);
    }

    .notification-action:hover,
    .notification-content:hover,
    .notification-default-action:hover {
      background: none;
    }

    /* --- Urgency Border Overrides --- */
    .notification.low {
      border: 2px solid alpha(@gray, 0.7);
    }

    .notification.normal {
      border: 2px solid alpha(@fg, 0.7);
    }

    .notification.critical {
      border: 2px solid alpha(@red, 0.7);
    }

    .summary {
      font-weight: bold;
      color: @bwhite;
    }

    .body {
      color: @white;
    }

    .time {
      color: @white;
      font-size: 11px;
    }

    /* --- Notification Group --- */
    .notification-group {
      background: alpha(@fg, 0.7);
    }

    .notification-group-headers {
      color: @bwhite;
      margin: 8px 14px;
    }

    .notification-group-headers > label {
      color: @bwhite;
      margin: 0px 16px;
    }

    .notification-group-icon {
      color: @bwhite;
    }

    .notification-group-collapse-button,
    .notification-group-close-all-button {
      min-width: 16px;
      min-height: 16px;
      background: @gray;
      color: alpha(@fg, 0.7);
      margin: 0px;
      padding: 5px;
    }

    /* --- DND  --- */
    .widget-dnd {
      background: alpha(@fg, 0.7);
      padding: 8px 16px;
    }
    .widget-dnd label {
      color: @bwhite;
    }

    .widget-dnd > switch {
      background: @gray;
    }

    .widget-dnd > switch:checked {
      background: @blue;
    }

    .widget-dnd > switch slider {
      background: alpha(@fg, 0.7);
    }

    /* --- menu-bar --- */
    .widget-menubar {
      margin: 8px 0px 8px -6px;
      padding: 0px;
    }

    .widget-menubar > box {
      margin: 0px;
      padding: 0px;
    }

    /* menu# and buttons# */
    .widget-menubar > box > box > button,
    .widget-menubar > box > box > box > button {
      margin: 0px 0px 0px 6px;
      padding: 5px 29px;
      background: alpha(@fg, 0.7);
      color: @bwhite;
      border: 2px solid alpha(@fg, 0.7);
    }

    .widget-menubar > box > box > button:nth-child(3),
    .widget-menubar > box > box > button:nth-child(4) {
      padding: 5px 28px 5px 29px;
    }

    .widget-menubar > box > box > button:hover,
    .widget-menubar > box > box > box > button:hover {
      background: alpha(@fg, 0.7);
      color: @bwhite;
      border: 2px solid @blue;
    }

    .widget-menubar > box > box > button:checked,
    .widget-menubar > box > box > box > button:checked {
      background: @blue;
      color: alpha(@fg, 0.7);
      border: 2px solid @blue;
    }

    /* dropdown buttons */
    .widget-menubar > revealer * {
      margin: 0px 0px 0px 6px;
    }
    .widget-menubar > revealer * button {
      margin: 8px;
      background: alpha(@fg, 0.7);
      color: @bwhite;
      border: 2px solid alpha(@fg, 0.7);
    }
    .widget-menubar > revealer * button:hover {
      background: alpha(@fg, 0.7);
      color: @bwhite;
      border: 2px solid @blue;
    }
    .widget-menubar > revealer * button:first-child {
      margin-top: 8px;
    }
    .widget-menubar > revealer * button:last-child {
      margin-bottom: 0;
    }

    /* --- buttons-grid --- */
    .widget-buttons-grid {
      margin: -3px;
      background: none;
    }

    .widget-buttons-grid>flowbox>flowboxchild>button {
      background: alpha(@fg, 0.7);
      color: @bwhite;
      border: 2px solid alpha(@fg, 0.7);
    }

    .widget-buttons-grid>flowbox>flowboxchild>button:hover {
      background: alpha(@fg, 0.7);
      color: @bwhite;
      border: 2px solid @blue;
    }

    .widget-buttons-grid>flowbox>flowboxchild>button:checked {
      background: @blue;
      color: alpha(@fg, 0.7);
      border: 2px solid @blue;
    }

    /* --- Notification Control Center Title --- */
    .widget-title {
      background: alpha(@fg, 0.7);
      color: @bwhite;
      padding: 8px 16px;
    }

    .widget-title>button {
      background: @gray;
      color: alpha(@fg, 0.7);
      padding: 1px 5px;
    }

    .widget-title>button:hover {
      background: @red;
      color: alpha(@fg, 0.7);
    }

    .widget-label > label {
    }

    /* --- Volume, backlight, & slider --- */
    .widget-backlight,
    .widget-slider,
    .widget-volume {
      background: alpha(@fg, 0.7);
      color: @bwhite;
      padding: 8px 16px;
    }

    .widget-backlight label,
    .widget-slider label,
    .widget-volume label {
      font-size: 24px;
      min-width: 30px;
    }

    .widget-backlight button,
    .widget-slider button,
    .widget-volume button {
      background: none;
      color: @bwhite;
      padding: 0px;
    }

    .widget-backlight trough,
    .widget-slider trough,
    .widget-volume trough {
      min-height: 8px;
      border-radius: 5px;
    }

    .widget-backlight highlight,
    .widget-slider highlight,
    .widget-volume highlight {
      min-height: 8px;
      border-radius: 5px;
      background: @blue;
    }

    .widget-backlight slider,
    .widget-slider slider,
    .widget-volume slider {
      min-width: 12px;
      min-height: 12px;
      background: @bwhite;
    }

    .per-app-volume {
      margin: 2px 0px;
    }

    .per-app-volume trough {
      margin: 0px 28px 0px 4px;
    }

    /* --- MPRIS --- */
    .widget-mpris {
      background: alpha(@fg, 0.7);
      color: @bwhite;
      padding: 8px 8px;
    }
    .widget-mpris>.horizontal>.image-button {
      margin-top: 80px;
      margin-bottom: 80px;
      background: none;
    }
    .widget-mpris>.horizontal>.image-button:hover {
      margin-top: 80px;
      margin-bottom: 80px;
      background: @gray;
    }

    /* --- Hide notification close button --- */
    .close-button {
      opacity: 0;
    }

    /* --- Avoid 'annoying' background --- */
    .blank-window {
      background: transparent;
    }
  '';
}
