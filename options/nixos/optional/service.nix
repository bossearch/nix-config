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
    # apply gpu undervolt offset -50mV
    gpu-undervolt = {
      enable = hosts.hostname == "silvia";
      wantedBy = ["multi-user.target"];
      after = ["systemd-modules-load.service"];

      script = ''
        GPU=/sys/class/drm/card1/device

        for i in $(seq 1 10); do
          [ -f "$GPU/pp_od_clk_voltage" ] && break
          sleep 1
        done
        [ -f "$GPU/pp_od_clk_voltage" ] || exit 1

        echo "manual" > $GPU/power_dpm_force_performance_level
        echo "vo -50" > $GPU/pp_od_clk_voltage
        echo "c" > $GPU/pp_od_clk_voltage

        echo "auto" > $GPU/power_dpm_force_performance_level
      '';

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
    };
  };
}
