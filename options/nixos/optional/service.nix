{
  hosts,
  pkgs,
  ...
}: {
  systemd.services = {
    # automatically turn off external monitors on system poweroff
    ddcci-monitor-poweroff = {
      enable = hosts.hostname == "silvia";
      unitConfig = {
        DefaultDependencies = "no";
      };
      before = ["poweroff.target" "halt.target"];
      wantedBy = ["poweroff.target" "halt.target"];
      environment = {HOME = "/root";};
      script = ''
        for dev in /sys/class/backlight/ddcci*; do
          if [ -d "$dev" ]; then
            BUS_NUM=''${dev##*ddcci}
            ${pkgs.ddcutil}/bin/ddcutil --bus="$BUS_NUM" setvcp D6 05 || true
          fi
        done
      '';
      serviceConfig = {
        Type = "oneshot";
      };
    };
  };
}
