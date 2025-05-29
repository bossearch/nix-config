{pkgs, ...}: {
  environment.systemPackages = with pkgs.unstable; [
    gowall
  ];
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "bash -c '.config/hypr/scripts/hyprpaper.sh >/dev/null; Hyprland >/dev/null'";
        # command = ".config/hypr/scripts/hyprpaper.sh >/dev/null";
        user = "bosse";
      };
      default_session = initial_session;
    };
  };
}
