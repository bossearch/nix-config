{
  config,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.bash}/bin/bash -c 'Hyprland >/dev/null'";
        user = "${config.spec.userName}";
      };
      default_session = initial_session;
    };
  };
}
