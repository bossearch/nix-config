{
  homes,
  lib,
  mylib,
  pkgs,
  ...
}: let
  modules =
    if homes.notify == "dunst"
    then {
      launcher = "group/launcher";
      utility = "group/utility";
    }
    else if homes.notify == "swaync"
    then {
      launcher = "custom/launcher";
      utility = "";
    }
    else "";
in {
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
    systemd.target = "hyprland-session.target";
    settings = {
      mainBar = {
        "height" = 34;
        "layer" = "top";
        "margin-top" = 0;
        "margin-right" = 8;
        "margin-bottom" = 0;
        "margin-left" = 8;
        "fixef-center" = "true";
        "spacing" = 4;

        "modules-left" = [
          "${modules.launcher}"
          "hyprland/workspaces"
          "custom/chevron"
          "hyprland/window"
        ];

        "modules-right" = [
          "group/customtray"
          "custom/weather"
          "${modules.utility}"
          "group/resource"
          "group/control"
          # "backlight"
          # "battery"
          "clock"
          "custom/notify"
        ];
      };
    };
  };
}
