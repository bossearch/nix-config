{
  pkgs,
  ...
}: {
  imports = [
    ./scripts
    ./modules.nix
    ./style.nix
  ];

  home.packages = with pkgs; [
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
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";
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
