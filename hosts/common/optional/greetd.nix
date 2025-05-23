{pkgs,...}: {
  environment.systemPackages = with pkgs.unstable; [
    gowall
  ];
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = ".config/hypr/scripts/hyprpaper.sh >/dev/null";
        user = "bosse";
      };
      default_session = initial_session;
    };
  };
}
