{
  config,
  lib,
  outputs,
  ...
}: let
  keyDir =
    if config.spec.impermanence
    then "/persist/etc/ssh"
    else "/etc/ssh";
  hosts = lib.attrNames outputs.nixosConfigurations;
in {
  services.openssh = {
    enable = lib.mkForce true;
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
    knownHosts = lib.genAttrs (lib.remove config.spec.hostName hosts) (hostname: {
      publicKeyFile = ../../${hostname}/ssh_host_ed25519_key.pub;
    });
  };
}
