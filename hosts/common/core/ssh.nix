{
  config,
  lib,
  ...
}: let
  keyDir =
    if config.spec.impermanence
    then "/persist/etc/ssh"
    else "/etc/ssh";
in {
  services.openssh = {
    enable = lib.mkForce true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        path = "${keyDir}/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
