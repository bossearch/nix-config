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
        rocmPackages.clr.icd
      ];
      amdgpu = {
        opencl.enable = true;
      };
      i2c.enable = true;
    })
  ];
}
