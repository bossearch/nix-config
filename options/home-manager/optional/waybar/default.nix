{
  homes,
  lib,
  mylib,
  pkgs,
  ...
}: {
  imports = mylib.autoimport ./.;

  home.packages = lib.mkIf homes.waybar (with pkgs; [
    ddcutil
    grim
    libnotify
    pavucontrol
    slurp
    socat
    tesseract
    waybar
    wl-screenrec
    sysboard
  ]);

  programs.waybar = {
    enable = homes.waybar;
    systemd.enable = true;
    systemd.target = "graphical-session.target";
    settings = {
      mainBar = {
        "height" = 32;
        "layer" = "top";
        "margin-top" = 4;
        "margin-left" = 8;
        "margin-bottom" = -3;
        "margin-right" = 8;
        "fixef-center" = "true";
        "spacing" = 4;

        "modules-left" = [
          "group/launcher"
          "group/task"
          "custom/weather"
          "hyprland/workspaces"
        ];

        "modules-center" = [
          "hyprland/window"
        ];

        "modules-right" = [
          "group/customtray"
          "group/utility"
          "group/monitor"
          # "backlight"
          # "battery"
          "clock"
          "custom/notification"
        ];
      };
    };
  };
}
