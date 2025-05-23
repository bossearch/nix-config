{lib, ...}: {
  services.openssh = {
    enable = lib.mkForce true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };
}
