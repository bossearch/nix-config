{
  hosts,
  lib,
  pkgs,
  ...
}: let
  fallbackScript = pkgs.writeShellScript "start-desktop" ''
    # Make sure shell itself doesn't print anything either
    exec 1>/dev/null 2>&1

    if command -v Hyprland >/dev/null 2>&1; then
      exec uwsm start hyprland-uwsm.desktop
    else
      chvt 2
    fi
  '';
in {
  config = lib.mkIf hosts.displaymanager {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = fallbackScript;
          user = hosts.username;
        };
        default_session = initial_session;
      };
    };
    systemd.services."getty@tty2".enable = true;
  };
}
