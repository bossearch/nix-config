{
  config,
  lib,
  ...
}: {
  fileSystems = lib.mkMerge [
    (lib.mkIf (config.networking.hostName == "stagea") {
      "/media/host" = {
        device = "Shared";
        fsType = "virtiofs";
      };
    })
  ];
}
