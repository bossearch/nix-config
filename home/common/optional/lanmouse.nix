{inputs, ...}: {
  imports = [inputs.lan-mouse.homeManagerModules.default];

  programs.lan-mouse = {
    enable = true;
    systemd = true;

    settings = {
      authorized_fingerprints = {
        "ab:2b:e5:e0:0d:67:4c:a3:da:44:31:a2:64:18:0d:a5:c3:bc:39:eb:f5:c2:01:81:ff:a5:e1:94:b7:25:81:1f" = "192.168.18.103";
      };
    };
  };
}
