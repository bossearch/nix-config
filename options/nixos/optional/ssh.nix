{
  config,
  lib,
  outputs,
  ...
}: let
  impermanence = lib.elem config.spec.disko.type [
    "btrfs-luks-impermanence"
    "btrfs-impermanence"
  ];
  keyDir =
    if impermanence
    then "/persist/etc/ssh"
    else "/etc/ssh";
  hosts = lib.attrNames outputs.nixosConfigurations;
in {
  services.openssh = {
    enable = config.spec.ssh;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        path = "${keyDir}/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
    # Each hosts public key
    knownHosts = lib.genAttrs (lib.remove config.spec.hostname hosts) (hostname: {
      publicKeyFile = ../../../hosts/${hostname}/ssh_host_ed25519_key.pub;
    });
  };
}
