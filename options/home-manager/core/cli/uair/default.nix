{pkgs, ...}: {
  home.packages = pkgs.uair;

  home.file.".config/uair/uair.toml" = {
    text = ''
      [defaults]
      format = "\r{time}"

      [[sessions]]
      id = "work"
      name = "Work"
      duration = "10m"
      command = "notify-send 'Work Done!'"
      autostart = true

      [[sessions]]
      id = "rest"
      name = "Rest"
      duration = "1m"
      command = "notify-send 'Rest Done!'"
      autostart = true
    '';
  };
}
