{
  hosts,
  lib,
  ...
}: {
  fileSystems = lib.mkMerge [
    (lib.mkIf (hosts.hostname == "stagea") {
      "/home/${hosts.username}/Shared" = {
        device = "Shared";
        fsType = "virtiofs";
        options = ["nofail" "x-systemd.automount"];
      };
    })
  ];
}
