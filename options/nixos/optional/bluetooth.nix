{hosts, ...}: {
  hardware = {
    bluetooth = {
      enable = hosts.bluetooth;
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
    blueman.enable = hosts.bluetooth;
  };
}
