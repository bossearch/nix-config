{
  boot = {
    #silent boot
    kernelParams = ["quiet" "udev.log_level=0" "systemd.show_status=false"];
    initrd.verbose = false;
    consoleLogLevel = 0;
    #plymouth
    plymouth.enable = true;
    plymouth.theme = "breeze";
  };
}
