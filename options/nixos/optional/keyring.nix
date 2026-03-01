{
  hosts,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs;
    if hosts.gui.enable
    then [gnome-keyring libsecret polkit_gnome]
    else [gnupg pinentry-curses];

  services.gnome.gnome-keyring.enable = hosts.gui.enable;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage =
      if hosts.gui.enable
      then pkgs.pinentry-gnome3
      else pkgs.pinentry-curses;
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = lib.mkIf (hosts.gui.enable) {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
