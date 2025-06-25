{
  config,
  lib,
  ...
}: let
  # Sops needs acess to the keys before the persist dirs are even mounted; so
  # just persisting the keys won't work, we must point at /persist
  hasOptinPersistence = lib.hasAttrByPath ["environment" "persistence" "/persist"] config;
in {
  services.openssh = {
    enable = lib.mkForce true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
    hostKeys =
      if hasOptinPersistence
      then [
        {
          path = "/persist/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ]
      else [
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
  };
}
