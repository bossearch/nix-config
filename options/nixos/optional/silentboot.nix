{
  config,
  lib,
  pkgs,
  ...
}: let
  themes = pkgs.adi1090x-plymouth-themes.override {
    selected_themes = ["spinner_alt"];
  };
in {
  config = lib.mkIf config.spec.silentboot {
    boot = {
      #silent boot
      kernelParams = [
        "quiet"
        "udev.log_level=0"
        "systemd.show_status=false"
      ];
      initrd.verbose = false;
      consoleLogLevel = 0;
      #plymouth
      plymouth = {
        enable = true;
        theme = "spinner_alt";
        themePackages = [themes];
      };
    };
  };
}
