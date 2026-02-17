{
  config,
  lib,
  ...
}: {
  fileSystems = lib.mkMerge [
    (lib.mkIf (config.spec.hostname == "stagea") {
      "/home/${config.spec.username}/Shared" = {
        device = "Shared";
        fsType = "virtiofs";
        options = ["nofail" "x-systemd.automount"];
      };
    })
  ];
}
