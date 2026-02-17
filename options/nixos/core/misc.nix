{
  config,
  lib,
  pkgs,
  ...
}: {
  services = lib.mkMerge [
    {
      fstrim.enable = config.spec.hostname == "silvia";
      gvfs = {
        enable = config.spec.windowmanager != null;
        package = pkgs.gnome.gvfs;
      };
      udisks2 = {
        enable = true;
        package = pkgs.udisks2;
        mountOnMedia = true;
      };
    }
    (lib.mkIf (config.spec.hostname == "stagea") {
      spice-vdagentd.enable = true;
      qemuGuest.enable = true;
    })
  ];

  # Ensure /media exists with the correct permissions
  systemd.tmpfiles.rules =
    [
      "d /media 0755 root root -"
    ]
    ++ lib.optionals (config.spec.hostname == "silvia") [
      "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
    ];
}
