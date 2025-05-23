{pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
      ovmf.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;
}
