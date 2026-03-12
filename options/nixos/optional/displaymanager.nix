{
  hosts,
  pkgs,
  lib,
  ...
}: let
  autoLoginCmd = "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop >/dev/null 2>&1";

  isGreetd = hosts.gui.enable && hosts.gui.displaymanager == "greetd";
  isGetty = hosts.gui.enable && hosts.gui.displaymanager == "none";

  ttyCheck =
    if hosts.shell == "fish"
    then ''
      if test (tty) = "/dev/tty1"
    ''
    else ''
      if [ "$(tty)" = "/dev/tty1" ]; then
    '';

  ttyEnd =
    if hosts.shell == "fish"
    then "end"
    else "fi";

  shellCmd = ''
    ${ttyCheck}
      exec ${autoLoginCmd}
    ${ttyEnd}
  '';
in {
  # Greetd
  services.greetd = {
    enable = isGreetd;
    settings = {
      initial_session = {
        command = autoLoginCmd;
        user = hosts.username;
      };
      default_session = {
        command = autoLoginCmd;
        user = hosts.username;
      };
    };
  };

  # Getty
  services.getty = lib.mkIf isGetty {
    autologinUser = hosts.username;
  };

  programs = {
    bash.loginShellInit = lib.mkIf (isGetty && hosts.shell == "bash") shellCmd;
    fish.loginShellInit = lib.mkIf (isGetty && hosts.shell == "fish") shellCmd;
    zsh.loginShellInit = lib.mkIf (isGetty && hosts.shell == "zsh") shellCmd;
  };

  systemd.services."getty@tty1" = lib.mkIf isGetty (lib.mkMerge [
    {
      serviceConfig = {
        TTYVTDisallocate = "yes";
        TTYReset = "yes";
      };
    }
    (lib.mkIf hosts.silentboot {
      overrideStrategy = "asDropin";
      serviceConfig = {
        ExecStart = [
          ""
          "@${pkgs.util-linux}/bin/agetty agetty --login-program ${pkgs.shadow}/bin/login --login-options '-f ${hosts.username}' --autologin ${hosts.username} --noissue --skip-login --noclear %I $TERM"
        ];
        StandardOutput = "null";
      };
    })
  ]);
}
