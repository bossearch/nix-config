{
  hosts,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = hosts.virtmanager;
    onBoot = "ignore";
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
      vhostUserPackages = with pkgs; [virtiofsd];
    };
  };
  virtualisation.spiceUSBRedirection.enable = hosts.virtmanager;

  programs.virt-manager.enable = hosts.virtmanager;
}
