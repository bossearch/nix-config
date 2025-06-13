{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs.unstable; [
    gowall
  ];
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "bash -c '.config/hypr/scripts/hyprpaper.sh >/dev/null; Hyprland >/dev/null'";
        user = "${config.spec.userName}";
      };
      default_session = initial_session;
    };
  };
}
