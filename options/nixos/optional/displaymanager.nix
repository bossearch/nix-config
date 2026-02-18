{
  hosts,
  pkgs,
  ...
}: let
  enabled = hosts.gui.enable && (hosts.gui.displaymanager == "greetd");

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
  services.greetd = {
    enable = enabled;
    settings = rec {
      initial_session = {
        command = fallbackScript;
        user = hosts.username;
      };
      default_session = initial_session;
    };
  };
  systemd.services."getty@tty2".enable = enabled;
}
