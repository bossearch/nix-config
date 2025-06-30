{
  config,
  lib,
  pkgs,
  ...
}: {
  services = lib.mkMerge [
    {
      fstrim.enable = true;
      gvfs = {
        enable = true;
        package = pkgs.gnome.gvfs;
      };
      udisks2 = {
        enable = true;
        package = pkgs.udisks2;
        mountOnMedia = true;
      };
      envfs.enable = true;
    }
    (lib.mkIf (config.spec.hostName == "stagea") {
      spice-vdagentd.enable = true;
      qemuGuest.enable = true;
    })
  ];

  # Ensure /media exists with the correct permissions
  systemd.tmpfiles.rules = [
    "d /media 0755 root root -"
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
}
