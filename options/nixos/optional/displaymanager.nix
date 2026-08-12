{
  hosts,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = hosts.gui.enable;
    settings = {
      initial_session = {
        command = "${pkgs.hyprland}/bin/start-hyprland >/dev/null 2>&1";
        user = hosts.username;
      };
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd '${hosts.shell} -l'";
        user = "greeter";
      };
    };
  };
}
