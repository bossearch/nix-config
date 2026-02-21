{
  hosts,
  lib,
  pkgs,
  ...
}: {
  time.timeZone = "${hosts.timezone}";

  services = lib.mkMerge [
    {
      fstrim.enable = hosts.hostname == "silvia";
      gvfs = {
        enable = hosts.gui.enable;
        package = pkgs.gnome.gvfs;
      };
      udisks2 = {
        enable = true;
        package = pkgs.udisks2;
        mountOnMedia = true;
      };
    }
    (lib.mkIf (hosts.hostname == "stagea") {
      spice-vdagentd.enable = true;
      qemuGuest.enable = true;
    })
  ];

  # Ensure /media exists with the correct permissions
  systemd.tmpfiles.rules =
    [
      "d /media 0755 root root -"
    ]
    ++ lib.optionals (hosts.hostname == "silvia") [
      "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
    ];
}
