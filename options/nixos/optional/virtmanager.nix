{
  config,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = config.spec.virtmanager;
    onBoot = "ignore";
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
      vhostUserPackages = with pkgs; [virtiofsd];
    };
  };
  virtualisation.spiceUSBRedirection.enable = config.spec.virtmanager;

  programs.virt-manager.enable = config.spec.virtmanager;
}
