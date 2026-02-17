{
  hosts,
  lib,
  outputs,
  ...
}: let
  impermanence = lib.elem hosts.disko.type [
    "btrfs-luks-impermanence"
    "btrfs-impermanence"
  ];
  keyDir =
    if impermanence
    then "/persist/etc/ssh"
    else "/etc/ssh";
  hostList = lib.attrNames outputs.nixosConfigurations;
in {
  services.openssh = {
    enable = hosts.ssh;
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
    knownHosts = lib.genAttrs (lib.remove hosts.hostname hostList) (hostname: {
      publicKeyFile = ../../../hosts/${hostname}/ssh_host_ed25519_key.pub;
    });
  };
}
