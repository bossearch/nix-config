{lib, ...}: {
  services.openssh = {
    enable = lib.mkForce true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
