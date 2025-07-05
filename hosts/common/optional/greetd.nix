{
  config,
  pkgs,
  ...
}: let
  fallbackScript = pkgs.writeShellScript "start-desktop" ''
    # Make sure shell itself doesn't print anything either
    exec 1>/dev/null 2>&1

    if command -v Hyprland >/dev/null 2>&1; then
      exec Hyprland
    else
      chvt 2
    fi
  '';
in {
  services.greetd = {
    enable = true;
    vt = 1;
    settings = rec {
      initial_session = {
        command = fallbackScript;
        user = config.spec.userName;
      };
      default_session = initial_session;
    };
  };
  systemd.services."getty@tty2".enable = true;
}
