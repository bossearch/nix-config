{config, ...}: {
  hardware = {
    bluetooth = {
      enable = config.spec.bluetooth;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  services = {
    blueman.enable = config.spec.bluetooth;
  };
}
