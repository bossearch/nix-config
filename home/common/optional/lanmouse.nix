{inputs, ...}: {
  imports = [inputs.lan-mouse.homeManagerModules.default];

  programs.lan-mouse = {
    enable = true;
    settings = {
      authorized_fingerprints = {
        "ab:2b:e5:e0:0d:67:4c:a3:da:44:31:a2:64:18:0d:a5:c3:bc:39:eb:f5:c2:01:81:ff:a5:e1:94:b7:25:81:1f" = "192.168.18.103";
      };
    };
  };
  systemd.user.services.lan-mouse = {
    Unit = {
      After = [
        "graphical-session.target"
        "xdg-desktop-portal.service"
        "xdg-desktop-portal-wlr.service"
      ];
      Wants = [
        "xdg-desktop-portal.service"
        "xdg-desktop-portal-wlr.service"
      ];
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
