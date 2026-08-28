{
  homes,
  lib,
  mylib,
  pkgs,
  ...
}: {
  imports = mylib.autoimport ./.;

  home.packages = lib.mkIf homes.waybar (with pkgs; [
    brightnessctl
    grim
    pavucontrol
    slurp
    socat
    tesseract
    wl-screenrec
    sysboard
  ]);

  programs.waybar = {
    enable = homes.waybar;
    package = pkgs.waybar-fix-hypr-lua;
    systemd.enable = true;
    systemd.targets = ["hyprland-session.target"];
    settings = {
      mainBar = {
        "height" = 34;
        "layer" = "bottom";
        "margin-top" = 0;
        "margin-right" = 8;
        "margin-bottom" = 0;
        "margin-left" = 8;
        "spacing" = 4;

        "modules-left" = [
          "custom/launcher"
          "hyprland/workspaces"
          "custom/chevron"
          "hyprland/window"
        ];

        "modules-right" = [
          "group/customtray"
          "group/resource"
          "group/control"
          "clock"
          "custom/notify"
        ];
      };
    };
  };
}
