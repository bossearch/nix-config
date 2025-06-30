{
  config,
  lib,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = lib.mkIf (config.spec.hostName == "silvia") ["amdgpu"];

  hardware = lib.mkMerge [
    {
      enableRedistributableFirmware = true;
    }
    (lib.mkIf (config.spec.hostName == "silvia") {
      graphics.enable = true;
      graphics.enable32Bit = true;
      graphics.extraPackages = with pkgs; [
        amdvlk
        rocmPackages.clr.icd
      ];
      graphics.extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
      amdgpu = {
        opencl.enable = true;
        amdvlk.enable = true;
      };
      i2c.enable = true;
    })
  ];
}
