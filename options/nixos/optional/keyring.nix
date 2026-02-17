{
  config,
  lib,
  pkgs,
  ...
}: let
  headless = config.spec.windowmanager == null;
in {
  environment.systemPackages = with pkgs;
    if headless
    then [gnupg pinentry-curses]
    else [gnome-keyring libsecret polkit_gnome];

  services.gnome.gnome-keyring.enable = !headless;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage =
      if headless
      then pkgs.pinentry-curses
      else pkgs.pinentry-gnome3;
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = lib.mkIf (!headless) {
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
