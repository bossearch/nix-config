{
  config,
  lib,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = lib.mkIf (config.spec.hostname == "silvia") ["amdgpu"];

  hardware = lib.mkMerge [
    {
      enableRedistributableFirmware = true;
      graphics.enable = true;
      graphics.enable32Bit = true;
    }
    (lib.mkIf (config.spec.hostname == "silvia") {
      graphics.extraPackages = with pkgs; [
        rocmPackages.clr.icd
        rocmPackages.hipblas
        rocmPackages.hipblaslt
        rocmPackages.rocwmma
      ];
      amdgpu = {
        opencl.enable = true;
      };
      i2c.enable = true;
    })
  ];
}
