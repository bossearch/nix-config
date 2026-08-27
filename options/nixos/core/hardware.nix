{
  hosts,
  lib,
  pkgs,
  ...
}: {
  services = lib.mkIf (hosts.hostname == "silvia") {
    xserver.videoDrivers = ["amdgpu"];
  };

  hardware = lib.mkMerge [
    {
      enableRedistributableFirmware = true;
      graphics.enable = true;
      graphics.enable32Bit = true;
    }
    (lib.mkIf (hosts.hostname == "silvia") {
      graphics.extraPackages = with pkgs; [
        rocmPackages.clr.icd
        rocmPackages.hipblas
        rocmPackages.hipblaslt
        rocmPackages.rocwmma
      ];
      amdgpu = {
        initrd.enable = true;
        opencl.enable = true;
        # enable oc or uv
        overdrive = {
          enable = true;
          ppfeaturemask = "0xffffffff";
        };
      };
      i2c.enable = true;
      keyboard.qmk.enable = true;
    })
  ];
}
