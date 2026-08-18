{
  config,
  pkgs,
  lib,
  hosts,
  ...
}: {
  boot = lib.mkMerge [
    {
      loader = {
        systemd-boot.enable = true;
        systemd-boot.consoleMode = "max";
        efi.canTouchEfiVariables = true;
        timeout = 1;
      };
      kernelPackages = pkgs.linuxPackages_zen;
    }
    (lib.mkIf (hosts.hostname == "silvia") {
      kernelModules = ["i2c-dev" "ddcci_backlight"];
      extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
        ddcci-driver
      ];
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
    })
  ];
}
