{...}: {
  boot = {
    # Use systemd bootload
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 1;
    #silent boot
    kernelParams = ["quiet" "udev.log_level=0" "systemd.show_status=false"];
    initrd.verbose = false;
    consoleLogLevel = 0;
    #plymouth
    plymouth.enable = true;
    plymouth.theme = "breeze";
  };
}
