{
  hosts,
  lib,
  pkgs,
  ...
}:
lib.mkIf hosts.waydroid {
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "waydroid-run";
      runtimeInputs = with pkgs; [
        waydroid
        hyprland
        jq
      ];
      text = ''
        cleanup() {
          waydroid session stop 2>/dev/null || true
        }
        trap cleanup EXIT INT TERM HUP

        waydroid session stop 2>/dev/null || true

        export mesa_glthread=true
        export vblank_mode=0

        get_resolution=$(hyprctl monitors -j 2>/dev/null | jq -r '.[] | select(.focused==true) | "\(.width) \(.height)"' 2>/dev/null)
        read -r MON_W MON_H <<< "$get_resolution"

        if [ -n "$MON_W" ] && [ -n "$MON_H" ]; then
          waydroid prop set persist.waydroid.width "$MON_W" 2>/dev/null || true
          waydroid prop set persist.waydroid.height "$MON_H" 2>/dev/null || true
        fi

        waydroid prop set persist.waydroid.fps 60 2>/dev/null || true

        if ! waydroid status | grep -q "RUNNING"; then
          waydroid session start &
          until waydroid status | grep -q "RUNNING"; do
            sleep 1
          done
        fi

        waydroid show-full-ui
      '';
    })
  ];
}
