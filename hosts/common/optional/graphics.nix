{pkgs, ...}: {
  # NOTE: hardware.enableAllFirmware if using laptop

  services.xserver.videoDrivers = ["amdgpu"];

  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
    graphics.extraPackages = with pkgs; [
      amdvlk
      rocmPackages.clr.icd
    ];
    graphics.extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
    amdgpu.opencl.enable = true;
    amdgpu.amdvlk.enable = true;
  };
}
