{config, ...}: {
  systemd.user = {
    services.gh-contrib = {
      Unit = {
        Description = "Fetch GitHub contribution";
        After = ["network-online.target"];
        Wants = ["network-online.target"];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${config.home.homeDirectory}/.config/gh/gh-contrib.sh";
      };
    };
    timers.gh-contrib = {
      Unit = {
        Description = "Update GitHub contributions daily";
      };
      Timer = {
        OnCalendar = "daily";
        Persistent = true;
      };
      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };
}
